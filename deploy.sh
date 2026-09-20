#!/usr/bin/env bash
# Deploy the site to Netlify.
#
# Why two steps: `netlify deploy --prod` returns "Forbidden" on this account,
# but a draft upload followed by an API publish works. This does both and
# fills in the deploy id for you.
#
# Usage:  ./deploy.sh        (from anywhere)
set -euo pipefail

cd "$(dirname "$0")/matter-lab-site"

SITE_ID=$(python3 -c 'import json;print(json.load(open(".netlify/state.json"))["siteId"])')

echo "Uploading from $(pwd) ..."
DEPLOY_ID=$(netlify deploy --dir . --json | python3 -c 'import sys,json;print(json.load(sys.stdin)["deploy_id"])')

echo "Publishing deploy $DEPLOY_ID ..."
netlify api restoreSiteDeploy \
  --data "{\"site_id\":\"$SITE_ID\",\"deploy_id\":\"$DEPLOY_ID\"}" >/dev/null

echo "Live: https://matter-lab.netlify.app"
