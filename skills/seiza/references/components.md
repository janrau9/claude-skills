# Seiza — component recipes

Every recipe assumes [tokens.css](tokens.css). All components are **margin-free** (the
placement law); parents place them with gap/padding from the ken ladder
(4 · 8 · 16 · 24 · 40 · 64 · 104). Radii: 5 minor · 8 buttons/inputs · 13 cards/menus ·
21 modals/hero · full pills. Interactive targets ≥40px, 8px apart (48px for primary on hand).

## Type registers (CSS)

Families come from the adaptation points in [tokens.css](tokens.css) — `--font-sans` /
`--font-mono` — never hardcoded. The registers below are law regardless of family.

```css
.micro { font: 400 10px/16px var(--font-mono);
  letter-spacing: 0.08em; text-transform: uppercase; color: var(--text-3); }
.small { font-size: 14px; line-height: 20px; }
.longform { font-size: 18px; line-height: 32px; }          /* +0.01em tracking at night */
h2, .heading { font: 600 20px/28px var(--font-sans);
  letter-spacing: -0.01em; }                                /* top margin ≈ 2× bottom (prose decree) */
.display { font: 600 56px/56px var(--font-sans);
  letter-spacing: -0.02em; text-transform: lowercase; text-wrap: balance; }
@media (max-width: 609px) { .display { font-size: 40px; line-height: 40px; } }
```

## Card

`background: var(--surface); border: 1px solid var(--line); border-radius: 13px;
padding: 24px; box-shadow: var(--shadow-1);`
Hover (interactive cards only): shadow → level 2, `translateY(-2px)`, 233ms settle.

## Buttons

```css
button { font: 500 14px/20px var(--font-sans); border-radius: 8px;
  padding: 8px 16px; cursor: pointer; transition: background var(--t-micro) ease; }
.btn-primary { background: var(--ink); color: var(--ground); border: none; }
.btn-primary:hover { background: var(--ink-hover); }   /* further from the ground's light */
.btn-quiet { background: transparent; color: var(--ink); border: 1px solid var(--line-strong); }
.btn-quiet:hover { background: var(--surface); }        /* earns a surface */
```

Text action: sans 14/500 link with a trailing `→` that nudges `translateX(2px)` at 233.
**Destructive:** a quiet button with plain words ("Delete draft…") + a confirmation modal
whose copy states the consequence. Never red.

## Inputs & form controls

Field (molecule): micro label above, 8px gap; error message below in seal (the view's seal).

```css
input, textarea, select { font-size: 16px; line-height: 24px; color: var(--ink);
  background: transparent; border: 1px solid var(--line-strong); border-radius: 8px;
  padding: 7px 16px; transition: border-color var(--t-micro) ease; }  /* 40px tall */
input::placeholder { color: var(--text-3); }
input:focus { outline: none; border-color: var(--ink); }   /* no glow rings */
.field.error input { border-color: var(--seal); }
.field.error .message { color: var(--seal); font-size: 14px; line-height: 20px; }
```

- Checkbox: 16px box, radius 5, `line-strong` border; checked = ink fill + ground check.
- Radio: 16px circle; checked = 6px ink dot.
- Switch: 40×24 full-round track (`line-strong` border); 16px thumb; on = ink track,
  ground thumb; flips at 144.
- Select: dressed as an input; opens the menu organism.
- Textarea: input rules; `resize: vertical`; min-height 3 lines.
- Caret is default (ink). Error claims the seal; success/info are monochrome words.

## Pills & status

Pill: micro register text, `padding: 3px 8px` (24px tall), full radius, `line-strong`
border, text-2. Featured variant inverts: ink fill, ground text, no border.
Status dot: 6px, text-3 at rest; pulses opacity 1→0.25→1 at 1597 only when genuinely
live; a live alert may claim the seal.

## Menu (dropdown)

Raised surface, radius 13, `--shadow-2`, padding 8, `z: var(--z-dropdown)`. Items 14px,
padding 8×16 (40px tall), radius 8; hover = `color-mix(in oklab, var(--ink) 5%, transparent)`.
Opens rising 377/settle, closes fading 233.

## Modal

Scrim: `background: var(--scrim)` + `backdrop-filter: blur(16px)`, `z: var(--z-modal)`.
Panel: overlay surface, radius 21, `--shadow-3`, hairline border, padding 24, max-width
24rem. Enters rising 13px at 377/settle; exits fade 233. Escape and scrim-click close.

## Toast

Raised surface, radius 13, `--shadow-2`, padding 16×24, max-width 24rem,
`z: var(--z-toast)`. Micro label + small text. Arrives rising 377/settle, leaves fading
233, auto-dismisses at **4181ms**. Success/info are monochrome; an error toast may claim
the seal.

## Data table

Header row: micro register over a `line-strong` bottom rule. Cells: 14px,
`font-variant-numeric: tabular-nums`, numerics right-aligned, padding 8×16 (40px rows).
Horizontal hairlines only — vertical dividers belong to stat grids. Row hover: the 5% ink
wash. Wide tables scroll inside their own `overflow-x: auto` container.

## Tabs

Small/500 text on a full-width hairline rail. Active: ink text + its rail segment inked
(1px); inactive text-3. The indicator slides at 233/settle. Keyboard: arrow keys move,
focus visible.

## Loading & empty

- Skeleton: shapes in `var(--line)`, radius to match the content they stand for, pulsing
  opacity at 1597 (legal — loading is live).
- Spinner: a hairline circle with an ink quarter-arc, rotating 1597ms linear.
- Progress: hairline track, ink fill, percent in the micro register (informative, always).
- Empty state: one line at text-2 + one action. The starfield may inhabit the emptiness
  (texture budget applies). Invite, don't apologize.

## Code

Block: 14px `var(--font-mono)`, `line` border, radius 8, padding 24, `overflow-x: auto`.
Inline: mono 14 on a `surface` chip, radius 5, padding 1×6.
**Syntax highlighting by weight and depth, not hue**: keywords 600 ink, strings text-2,
comments text-3, everything else ink 400. Monochrome code — the seal never appears in code.

## Icons

Outline only, 1.5px stroke, round caps/joins, drawn on ken boxes (16 or 24),
`stroke: currentColor`, never filled (the status/seal dots are the only filled marks).
Default source: [Lucide](https://lucide.dev). Always pair with a label or `aria-label`.

## Nav strip (organism)

Sticky, `z: var(--z-strip)`, padding 16×24, transparent at rest; when scrolled
(`scrollY > 8`): `background: color-mix(in oklab, var(--ground) 90%, transparent)`,
`backdrop-filter: blur(12px)`, hairline bottom border — transitions at 233. Wordmark
600/14 left; links in the micro register right (active ink, inactive text-3); the sky
toggle last (see [architecture.md](architecture.md)). On hand, links fold into a
full-screen overlay: ground background, lowercase display-scale links, Escape closes.
