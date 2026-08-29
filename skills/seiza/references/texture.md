# Seiza — texture construction (locked)

Three materials, one law. **The canvas** (a speck field read as stars by night, washi
grain by day) is *subliminal* — a visitor should not notice it unless they look. **The
kikkō lattice** is the *visible identity*, standing in both worlds. **The still pond**
makes the lattice answer. Assumes [tokens.css](tokens.css).

Laws: the canvas is the ground's material (allowed wherever masked); the lattice is one
field per view; every exposed lattice edge is a ragged frontier — never an aligned
cutoff; texture is ground-only, always masked, never under running text at legibility's
expense, `aria-hidden` + `pointer-events: none` on decorative layers; **still unless
answering** — texture never moves on its own; no gradients (light survives only as the
night edge-light on surfaces, the seal's shine, and masks — absence, not light).

## The canvas — one field, two readings

Eight solid-core specks spread across **two φ-related tile periods** (377px and 233px —
adjacent Fibonacci): the layers drift against each other, so the combined field never
visibly repeats (the sunflower's golden-angle trick, in tiles). One scatter geometry,
two alpha readings: **stars** at 34/21/13% of ink, **grain** at 13/8/5%. Dots must be
solid-core (`color 0.75px, transparent 1.25px`) — a pure fade (`1px 1px, color,
transparent`) is invisible on light grounds.

```css
--star-1: color-mix(in oklab, var(--ink) 34%, transparent);  /* --star-2: 21%, --star-3: 13% */
--grain-1: color-mix(in oklab, var(--ink) 13%, transparent); /* --grain-2: 8%, --grain-3: 5% */

.stars { /* .grain is identical with --grain-* tokens */
  background-image:
    radial-gradient(circle at 61px 139px,  var(--star-1) 1.25px, transparent 2px),
    radial-gradient(circle at 295px 313px, var(--star-1) 1.25px, transparent 2px),
    radial-gradient(circle at 170px 43px,  var(--star-2) 0.75px, transparent 1.5px),
    radial-gradient(circle at 338px 175px, var(--star-2) 0.75px, transparent 1.5px),
    radial-gradient(circle at 109px 289px, var(--star-2) 0.75px, transparent 1.5px),
    radial-gradient(circle at 27px 66px,   var(--star-3) 0.75px, transparent 1.25px),
    radial-gradient(circle at 196px 121px, var(--star-3) 0.75px, transparent 1.25px),
    radial-gradient(circle at 88px 208px,  var(--star-3) 0.75px, transparent 1.25px);
  background-size:
    377px 377px, 377px 377px,
    377px 377px, 377px 377px, 377px 377px,
    233px 233px, 233px 233px, 233px 233px;
}
```

Theme swap: two stacked layers whose opacities ride `--tex-night: 0/1` and
`--tex-day: 1/0` (flipped in the dark blocks), each with
`transition: opacity 610ms ease` so the sky crossfades into paper.

## The kikkō — the visible identity, both worlds

Grid-true hexagons, **edge 21** (Fibonacci; cell 36.3731 × 42, row pitch 31.5, even rows
offset 18.1865). *The sky changes; the structure stands*: the lattice draws in each
world's `--line` token — it is never day-only. The bevelled, glossy, glowing honeycomb
is the named "wrong."

```css
.lattice {
  background: var(--line);
  mask-image: url("data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20width='36.3731'%20height='63'%3E%3Cpath%20d='M0%2010.5%20L18.1865%200%20L36.3731%2010.5%20M0%2010.5%20V31.5%20M36.3731%2010.5%20V31.5%20M0%2031.5%20L18.1865%2042%20L36.3731%2031.5%20M18.1865%2042%20V63'%20fill='none'%20stroke='black'%20stroke-width='1'/%3E%3C/svg%3E");
  /* + -webkit-mask-image duplicate */
}
```

### The frontier — no aligned cutoffs, ever

Every exposed edge of a lattice field terminates cell by cell: each hexagon **column**
starts and ends at its own depth, ±2 rows off the nominal line, whole cells present or
absent, rolled fresh per visit. Construction: a runtime SVG mask — the union of kept
hexagons drawn slightly oversized (edge 22) so hairlines aren't shaved — applied to a
**wrapper** around the tiled lattice (masks nest, never stack: two `mask-image`s on one
element override each other). A soft container fade may compose on top.

```js
function hexPathAt(cx, cy) {              // oversized: edge 22
  return 'M'+cx+' '+(cy-22)+'L'+(cx+19.05)+' '+(cy-11)+'L'+(cx+19.05)+' '+(cy+11)
       + 'L'+cx+' '+(cy+22)+'L'+(cx-19.05)+' '+(cy+11)+'L'+(cx-19.05)+' '+(cy-11)+'Z';
}
function applyRagged(el, w, h, keep) {    // HW=36.3731 HM=18.1865 PITCH=31.5
  var rows = Math.ceil(h/PITCH)+1, cols = Math.ceil(w/HW)+1, d = '';
  for (var r = 0; r < rows; r++) {
    var cy = 21 + r*PITCH, off = (r%2===0) ? HM : 0;
    for (var c = 0; c <= cols; c++) {
      var cx = off + c*HW;
      if (keep(cx, cy)) d += hexPathAt(Math.round(cx*10)/10, cy);
    }
  }
  var svg = "<svg xmlns='http://www.w3.org/2000/svg' width='"+w+"' height='"+h+
    "'><path d='"+d+"' fill='white'/></svg>";
  var u = 'url("data:image/svg+xml,' + encodeURIComponent(svg) + '")';
  el.style.webkitMaskImage = u; el.style.maskImage = u;
  el.style.webkitMaskRepeat = 'no-repeat'; el.style.maskRepeat = 'no-repeat';
}
function columnJitter(w, lo, hi) {        // random depth per hex column
  var qMax = Math.ceil(w/HW)+2, jit = [], span = hi-lo+1;
  for (var q = 0; q <= qMax; q++) jit.push(lo + Math.floor(Math.random()*span));
  return function (cx) { return jit[Math.max(0, Math.min(qMax, Math.round(cx/HW)))]; };
}
// keep(cx, cy): cy >= topBase + jTop(cx)*PITCH && cy <= bottomBase + jBot(cx)*PITCH
```

### Relief (static option)

The lightness law applied to cells: a *raised* cell fills at `--surface` (one step
nearer the light), an *embedded* cell presses into the ground
(`color-mix(in oklab, black 13%, var(--ground))`). Flat fills only — no bevels, no
shadows. At most 3 cells per field carry depth. Cell = `clip-path:
polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%)` at 36.3731×42, with a
1px-inset second hex for the hairline rim.

## The still pond — texture answers

**Texture never moves on its own — it answers.** At rest the field is glass (and under
`prefers-reduced-motion` it stays glass, complete). Interaction cells are plain DOM
hexes (`.hex-cell`, fill `var(--line)`, opacity 0) created only where the frontier keeps
lattice, overlaying the drawn lines; `pointer-events: none` with document-level
listeners, so text and links above are never blocked.

- **Rest** — the cell under the pointer rises (0.55; the seal cell 0.68) in 144ms on the
  settle and *stays risen while the pointer stays*; it releases over 610ms when the
  pointer moves on or leaves. A finger resting on water keeps it displaced.
- **Move** — ring-1 neighbours surge to 0.25 for 144ms and die: a dying wake.
- **Strike** (click) — a constant-speed circular front (55ms per cell-width, delay ∝ true
  distance, no ring quantization) with physical attenuation:
  `amp = 0.55 · e^(−ring/13) / √(1+ring)` — geometric spreading (energy over a growing
  circumference) × absorption (Fibonacci absorption length, 13 cells). Below 5% the
  water does not stir: the wave dies around ring 12, never sweeping the field. Each cell
  rises in 144ms, holds 89ms, decays 610ms — the trail is emergent. No reflections:
  the ragged boundary absorbs.
- **Arrival** — once, ~987ms after load, one wave radiates from the seal cell ("the seal
  strikes the water"), then stillness.

```js
function surge(cell, amp, dwell, red) {
  var el = cell.el;
  clearTimeout(el._t); clearTimeout(el._r);
  if (red) el.classList.add('red'); else el.classList.remove('red');
  el.style.transition = 'opacity 144ms cubic-bezier(0.16, 1, 0.3, 1)';
  el.style.opacity = amp;
  el._t = setTimeout(function () {
    el.style.transition = 'opacity 610ms ease';
    el.style.opacity = el.classList.contains('seal-cell') ? 0.34 : 0;
    if (red) el._r = setTimeout(function () { el.classList.remove('red'); }, 640);
  }, dwell);
}
function wave(ox, oy, red) {
  var msPerPx = 55 / HW;
  cells.forEach(function (cell) {
    var r = Math.hypot(cell.x - ox, cell.y - oy), ring = r / HW;
    var amp = 0.55 * Math.exp(-ring / 13) / Math.sqrt(1 + ring);
    if (amp < 0.05) return;
    setTimeout(function () { surge(cell, amp, 89, red); }, r * msPerPx);
  });
}
```

### The seal in the pond

The view's seal is **one cell of the lattice**, chosen at random each visit from the
kept (visible) cells: `.seal-cell { background: var(--seal); opacity: 0.34; }` — a flat
washed fill, never hard. **Strike the seal itself** (click within `HW·0.75` of its
center) and its color rides the wave: cells carry a transient `.red` class
(`background: var(--seal)`), cleared 640ms after their dwell so nothing snaps mid-fade.
The resting state always returns to exactly one red cell — "one seal per view" governs
rest; the spread is a response, a hanko pressed.

## The image edge

Images dissolve, they don't end: mask the foot
(`mask-image: linear-gradient(to bottom, black 34%, transparent 89%)`) into the canvas
layered behind — stars by night, paper by day. Monochrome governs the chrome, not the
content: photos keep their color, like a scroll in a gray room.
