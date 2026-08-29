# plain-language — document recipes

The shape of each document type. All obey the laws: conclusion first, exact
identifiers, the verified/assumed/not-tested triad, numbers over adjectives,
end usable.

## Explain — the answer (default register)

1. First sentence answers. Yes/no questions start with yes or no.
2. Mechanism in 2–6 sentences, identifiers exact (`file:line`, symbol).
3. Stop. No restated question, no background tour, no closing summary.

> **Q:** Does `retryFetch` retry on 4xx?
> **A:** No — only on network errors and 5xx (`http.ts:52` checks
> `status >= 500`). A 4xx rejects immediately with the response body as the error.

## Explain — the journey (flows and depth)

For "what happens when…", "walk me through", end-to-end questions, or any depth
request about a flow. Follow ONE concrete actor chronologically:

- Numbered steps, one sentence each, every step anchored to an identifier.
- One scenario, main path; a branch gets one line where it forks, no tour.
- End at the observable outcome.

> 1. Submit fires `handleSubmit` (`form.tsx:41`), which validates locally.
> 2. Valid data POSTs to `/api/orders` (`routes.ts:12`); invalid stops here with
>    inline errors.
> 3. `createOrder` (`orders.ts:88`) writes the row and enqueues `order.created`.
> 4. The worker (`worker.ts:30`) sends the confirmation email — the user sees the
>    success toast before this completes.

## Commit message

- Subject: imperative, ≤72 chars, names the change — "Fix race in queue drain",
  not "Fixed some issues".
- Body (when the diff doesn't explain itself): why the change, what it affects,
  what was verified. One paragraph beats five bullets.

## PR description

1. **What & why** — one or two sentences; the reviewer decides scope here.
2. **Changes** — named files/areas with the one-line reason each.
3. **Verification** — the triad: what was tested and how, what's assumed, what isn't
   covered. "Tests pass" names which tests.
4. **Review notes** — where to look hardest, known trade-offs.

## Error message

What failed · why (with the raw error/code verbatim) · what to do, in order.
No apology, no "something went wrong", no blame on the user.

> "Could not connect to Postgres at `localhost:5432` (`ECONNREFUSED`). Start it
> with `docker compose up db`, then retry."

## Incident report

1. **Impact** first: who/what, how long, how bad — with numbers.
2. **Timeline**: timestamped facts, actor named, no narrative padding.
3. **Cause**: the mechanism, identifiers exact. "Root cause" only if actually root.
4. **Fix & follow-ups**: what's done (verified), what's pending (owner, date).

## Release notes

Per item: what changed, for whom, action required (if any). Group by
breaking / added / fixed. No "various improvements".

## Docstring / code comment

A comment states a constraint the code can't show — why, not what:
invariants, units, gotchas, external contracts. Never narrate the next line,
never address the reviewer. A docstring: one sentence of purpose, then only
parameters/returns whose meaning isn't in their names, then failure modes.

## README section

Lead with what the thing does and the fastest working example. Install → use →
configure, in execution order. Every command copy-pasteable; every flag named.

## Audit output (the mode's format)

One finding per line, linter-style:

```
pr-desc:3 · empty-hedge · "should probably be fine" · state what was tested, or test it
readme:12 · slop · "blazingly fast" · replace with the benchmark number
report:8 · false-confidence · "works everywhere" · add verified/assumed/not-tested status
```
