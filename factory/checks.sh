#!/usr/bin/env bash
# The repo's checks. Exit 0 only when the branch is fit to review.
#
# The gate runs this script from the main checkout with the job's worktree as
# the working directory. Keep it fast, deterministic and non-interactive: no
# watch modes, no prompts, nothing that rewrites files.
#
# This project is a plain Node.js package with no dependencies or build yet, so
# the checks grow with it: install deps when a lockfile appears, syntax-check
# every JS file, and run `npm test` once package.json has a real test script.
set -euo pipefail

if [ -f package-lock.json ]; then
  npm ci --prefer-offline --no-audit --no-fund
elif [ -f package.json ] && node -e 'const p=require("./package.json");process.exit(Object.keys({...p.dependencies,...p.devDependencies}).length?0:1)'; then
  npm install --no-audit --no-fund --no-package-lock
fi

# Syntax-check every JS file the repo tracks (skips node_modules and worktrees).
while IFS= read -r f; do
  node --check "$f"
done < <(git ls-files --cached --others --exclude-standard -- '*.js' '*.mjs' '*.cjs')

# Run the test suite, unless it's still npm's "no test specified" placeholder.
if node -e 'const t=(require("./package.json").scripts||{}).test||"";process.exit(t&&!t.includes("no test specified")?0:1)'; then
  npm test
else
  echo "checks.sh: no test script yet; syntax checks only." >&2
fi
