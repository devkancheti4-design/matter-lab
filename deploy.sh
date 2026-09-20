#!/usr/bin/env bash
# Deploy the site to Netlify.
#
# Two steps on purpose: `netlify deploy --prod` returns "Forbidden" on this
# account, but a draft upload followed by an API publish works fine.
# --no-build is required: this is a plain static folder with nothing to build.
#
# Usage:  ./deploy.sh        (run it from anywhere)
set -euo pipefail

cd "$(dirname "$0")/matter-lab-site"

if [ ! -f .netlify/state.json ]; then
  echo "Not linked to a Netlify site. Run this once, in this folder:" >&2
  echo "  netlify link --id 5a524f04-cd72-48ac-a826-e85a0fceda09" >&2
  exit 1
fi
SITE_ID=$(python3 -c 'import json;print(json.load(open(".netlify/state.json"))["siteId"])')

OUT=$(mktemp)
trap 'rm -f "$OUT"' EXIT

echo "Uploading from $(pwd) ..."
if ! netlify deploy --dir . --no-build --json >"$OUT" 2>&1; then
  echo "Upload failed. Netlify said:" >&2
  cat "$OUT" >&2
  exit 1
fi

DEPLOY_ID=$(python3 -c '
import sys, json
raw = open(sys.argv[1]).read()
start = raw.find("{")
if start < 0:
    sys.stderr.write("No JSON in the Netlify output:\n" + raw + "\n"); sys.exit(1)
try:
    print(json.loads(raw[start:])["deploy_id"])
except Exception as e:
    sys.stderr.write("Could not read deploy_id (%s). Output was:\n%s\n" % (e, raw)); sys.exit(1)
' "$OUT")

echo "Publishing deploy $DEPLOY_ID ..."
netlify api restoreSiteDeploy \
  --data "{\"site_id\":\"$SITE_ID\",\"deploy_id\":\"$DEPLOY_ID\"}" >/dev/null

echo "Live: https://matter-lab.netlify.app"
