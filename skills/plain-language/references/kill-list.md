# plain-language — the kill-list

What dies on sight, by category, with before → after pairs. Two guards apply
throughout: never edit protected spans (quotes, error strings, identifiers,
contracts), and never cut what changes meaning — clarity over compression.

## Throat-clearing

Openers that delay the point.

- "It's worth noting that the cache is disabled in tests." → "The cache is disabled
  in tests."
- "In order to reproduce the bug, you need to…" → "To reproduce: …"
- Also: "basically", "essentially", "as you may know", "let me start by saying".

## Empty hedges

Hedging *without content* — the writer knows, or could check.

- "This should probably fix the flaky test." → "This fixes the flaky test
  (ran it 50×, 0 failures)." — or, honestly: "This targets the race in
  `queue.ts:88`; not verified — the flake reproduces only in CI."
- An honest hedge names the boundary of knowledge. "Might work" alone is noise;
  "works locally, untested on Windows" is information.

## False confidence — the inverse failure

Claims stated as fact without their verification status. The kill is not the claim
but the missing status.

- "Works on all platforms." → "Works on macOS and Linux (CI); not tested on Windows."
- "This has no performance impact." → "No p95 change on staging under replay load;
  cold start not measured."

## Intensity inflation

- "Significantly faster" → "2.3× faster (bench: `bench/parse.ts`)".
- "A very large number of retries" → "up to 3 retries".
- Bare "very", "extremely", "hugely" — delete or replace with the number.

## Passive evasion

- "A decision was made to drop IE11." → "We dropped IE11." (Name the actor.)
- "It was determined that the leak originates in…" → "The leak originates in…"

## Vague deixis

- "The above issue", "this problem", "the relevant file" → the identifier:
  "the race in `worker.ts:30`", "`config/default.yml`".

## Marketing and slop vocabulary

In technical prose these assert nothing: robust, seamless, powerful, comprehensive,
cutting-edge, blazingly fast, leverage, delve, crucial, streamline, elevate,
game-changing, best-in-class. Replace with the specific property or delete.

- "A robust retry mechanism" → "Retries 3× with exponential backoff (100/200/400ms)."

## Redundant pairs

"Each and every" → "every". "First and foremost" → "first". "Basic fundamentals" →
"fundamentals".

## Structural tells

Structure-level filler — common in generated text:

- **Sycophantic openers**: "Great question!", "Certainly!" → start with the answer.
- **Restating the question** before answering → don't.
- **Bullet-pointing everything**, including two-item thoughts that are one sentence.
- **Marketing triads**: "fast, reliable, and scalable" → the one property that
  matters, with its number.
- **Hedged closers**: "Let me know if you need anything else!", "Hope this helps!" →
  end at the last fact.
- **Summary of the summary**: a closing paragraph repeating the opening → delete.

## Apology padding in errors

- "Oops! Something went wrong. Please try again later." → "Could not save: the file
  is read-only (`EACCES` on `notes.md`). Run `chmod +w notes.md` and retry."
  What failed, why, what to do — no apology, no vagueness.
