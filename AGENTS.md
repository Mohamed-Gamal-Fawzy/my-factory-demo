# my-factory-demo

A small Node.js package (`index.js`, `package.json`) used to try out the
software factory. `math.js` holds math helpers (`add`, `subtract`,
`multiply`), tested in `math.test.js`.

## Setup

A fresh checkout needs nothing beyond Node.js. There are no dependencies and no
env files yet; if a `package-lock.json` appears, run `npm ci`.

## Run

`node index.js`. There is no dev server.

## Validation

Run `bash factory/checks.sh`. It installs dependencies when there are any,
runs `node --check` on every JS file, and runs `npm test` once `package.json`
has a real test script (prefer Node's built-in runner: `node --test`).

`npm test` runs `node --test math.test.js`. It names its test files explicitly
so it never picks up copies under `.worktrees/`; add each new test file to that
script.

## Software factory

`/factory run` builds every open GitHub issue labeled `factory` through
intake → spec → build → gate → review → approve, one PR per issue. State is in
`factory/jobs/` (gitignored); `factory/bin/job` is its only writer. Checks:
`factory/checks.sh`. Dashboard: `cd factory && python3 -m http.server`, then
open http://localhost:8000/dashboard.html.

Each job works in its own git worktree, a full checkout of the repo at
`.worktrees/<job-id>` (gitignored). A tool run from the repo root that doesn't
read `.gitignore` sees those copies too; exclude `.worktrees/` in its config.
