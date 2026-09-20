# Matter Lab

Chemistry you can poke at. Start from a real object and travel down six rungs of scale —
substance, molecule, atom, nucleus, quark — then build things back up and react them.

**Live: https://matter-lab.netlify.app**

> This is a demo. It works end to end, but it is early. Known gaps are listed below.

## The idea

One spine runs through everything: a scale ladder with the real size on every rung.

| Rung | Scale | What you see |
|---|---|---|
| Object | 10⁻¹ m | The thing you scanned |
| Substance | 10⁻³ m | What it is made of, by proportion |
| Structure | 10⁻⁹ m | One molecule, or a lattice that never ends |
| Atom | 10⁻¹⁰ m | Shells and electrons, each one clickable |
| Nucleus | 10⁻¹⁴ m | Individual protons and neutrons |
| Quark | <10⁻¹⁸ m | Three quarks, gluon flux tubes, charges summing to +1 |

Each rung is a different renderer, not a re-skin. Salt renders as an ionic lattice, copper as a
close-packed metal with a visible free-electron sea, graphite as honeycomb sheets, diamond with its
fourth bond leaving the page.

## The two tools

**Matter Lens** — photograph something, box one part of it, and go inward. Click an electron and it
opens (charge, 0.511 MeV, spin, orbital, and the fact that there is nothing inside). Click a proton
and it opens into quarks. Includes a reaction mode where bonds break and reform with every atom
tracked one-to-one, plus an exact equation balancer.

**Orbital Forge** — all 118 elements. A temperature slider from 0–6000 K that melts the table in
waves. Build atoms particle by particle; add a proton and the element transmutes. Bond atoms into
molecules on a physics bench.

## Layout

    matter-lab-site/        the deployable static site (this is what is live)
      index.html            home + the 45-second scripted tour
      lens.html             Matter Lens
      forge.html            Orbital Forge
      vercel.json
    matter-lab.html         Claude-artifact variant of the home page
    matter-lens.html        Claude-artifact variant of the Lens
    orbital-forge.html      Claude-artifact variant of the Forge

Two variants exist because the artifact build can call Claude for photo recognition, and the static
build cannot. No build step, no dependencies — every page is a single self-contained HTML file.

## Run it

    cd matter-lab-site && python3 -m http.server 8000

Then open http://localhost:8000

## Where the data comes from

Element masses, radii, electronegativities and melting points, plus particle figures, are standard
reference values from [NIST](https://webbook.nist.gov/chemistry/),
[IUPAC](https://iupac.org/what-we-do/periodic-table-of-elements/),
[PubChem](https://pubchem.ncbi.nlm.nih.gov/) and the
[Particle Data Group](https://pdg.lbl.gov/). Every reaction in the library was checked against the
built-in balancer independently. No citation in the app was generated — they are all links to real
databases.

## Known gaps

- Demo-scale content: 18 reactions, 10 specimens, 21 hand-written molecular structures.
- Nothing persists. Close the tab and your work is gone.
- Valence is one number per element — no oxidation states, no resonance. H₂SO₄ cannot be built on
  the Forge bench.
- Structures for formulas outside the library are generated sketches: right atom counts, guessed
  connectivity. Labelled as such in the UI.
- Nuclear stability is estimated from distance to the most common isotope, not a nuclide table.
- The atom view defaults to Bohr shells, which students later have to unlearn. There is an
  orbital-cloud toggle.
- Photo recognition needs Claude and is inactive on the public static build.

Corrections to the chemistry are the most useful thing you can open an issue about.

## Licence

Not chosen yet — add one before reusing.
