# GearPump-DocsAsCode

This repo contains a small DITA project from Oxygen XML Editor's samples. The DITA project is configured to be validated using Oxygen's DITA map validation and completeness check script. The continuous integration is done using Netlify.

The starting point for the CI part is *netlify.toml*. The build command inside it does 2 main things:
1. It downloads an "All Platforms" distribution of Oxygen XML Editor.
2. It runs the DITA map validation and completeness check script from Oxygen.

The results of the validation can be seen in the console of each build.
