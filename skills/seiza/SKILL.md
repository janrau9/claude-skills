---
name: seiza
description: Apply the Seiza (星座, "constellation") design language — janrau's personal design system; Japanese architectural minimalism under a cosmic sky. Monochrome OKLCH lightness hierarchy, ONE vermilion "seal" accent per view, a single Geist superfamily, Fibonacci space/time ladders, hairline structure, starfield texture, full light/dark theming. Use whenever building or restyling any web UI (site, app, dashboard, blog, docs, component) where the user wants their design system or signature look — trigger phrases include "seiza", "janrau", "my design system", "my design language", "my style". Stack-agnostic — values and laws, not framework code. Do NOT use when the user names a different aesthetic or asks for a deliberately off-brand one-off.
references: [tokens, components, texture, architecture]
---

# Seiza (星座) design language

> **A quiet structure standing under a vast sky.** Monochrome like ink on paper; one law of
> hierarchy — what matters stands nearer the light; surfaces built only where depth demands
> them; texture from starlight, never pattern; and a single small seal of vermilion — one
> lone star per view, never more.

Seiza is Japanese architectural minimalism (Ma — emptiness as material) crossed with the
cosmos (the night sky as the native theme). It is technology-agnostic: every rule below is a
value or a law. Implement with whatever the project uses; never add a framework for this.

Deep material lives in `references/`: [tokens.css](references/tokens.css) (copy-paste token
sheet), [components.md](references/components.md) (every component recipe),
[texture.md](references/texture.md) (starfield/arc construction),
[architecture.md](references/architecture.md) (atomic layers, lint enforcement, sky toggle).

**Living reference** — five specimen pages built entirely under these laws:
01 type <https://claude.ai/code/artifact/6937d126-a061-46dd-8fa2-40f4cc39e548> ·
02 layout <https://claude.ai/code/artifact/9d4a68e8-66cd-400a-80bd-f204c3ffb043> ·
03 components <https://claude.ai/code/artifact/e94ad704-3ec8-450c-8ef1-3e441d9d181d> ·
04 motion <https://claude.ai/code/artifact/328a1236-6bd5-4573-a7a3-ea7d65c94068> ·
05 texture <https://claude.ai/code/artifact/9eb2f767-9767-4991-ad2b-2747d5f22618>

## The laws

Everything else derives from these. When a case is unspecified, apply the laws.

1. **The lightness law.** Importance is proximity, and proximity is luminance distance from
   the ground. Surfaces rise toward the light; text depths sink toward the ground. To
   de-emphasize, don't shrink — let it sink. Hover moves things *further* from the ground's
   lightness (darker by day, brighter at night).
2. **The seal law.** One vermilion mark per view, never more. Never on running text, hover
   states, or buttons. A validation error *claims* the view's seal (all decorative seals
   yield). Destructive actions get words + confirmation, never red.
3. **The separation ladder.** To separate two things use the weakest tool that works:
   space → hairline → surface. One boundary, one rung. A surface is earned only by
   objecthood (a thing acted on as a unit) or a change of depth; it includes its hairline.
4. **The placement law.** No component owns a margin. Parents place children with gap and
   padding (the gardener places the stones). Prose rhythm is the prose *container's* decree
   via scoped selectors, never an element's own margin.
5. **The ladders.** Space, time, and radii come only from Fibonacci ladders (below). A value
   off a ladder is a guess.
6. **One light source.** Directly above. Day: shadows drop straight down (no x-offset),
   cast in ink. Night: shadows vanish; surfaces catch a 1px edge-light on the top rim.
7. **The glow law.** Glow must cling to an edge — a rim, a lit top, a star's shine. It may
   never float free: the free-floating gradient bloom is the signature of machine-made
   pages and is banned. Wanted light gradation = emptiness does the work.
8. **No orphan colors.** Every color (text included) is a token; every token crosses with
   the theme (610ms). Never a literal valid in one theme only.
9. **Caps confinement.** UPPERCASE exists only in the micro register (mono 10, +0.08em,
   a few words). Never headings, never buttons. Display is lowercase (Latin only; CJK
   unaffected).
10. **Stillness.** The design must be complete when perfectly still. Reduced motion stops
    everything. Ambient animation only for genuinely live states. Texture never animates.
11. **Downward-only imports.** Atomic layers (tokens → atoms → molecules → organisms →
    templates → pages): a layer imports any layer below, never same-level or above.
12. **Monochrome governs the chrome, not the content.** Photos, artwork, charts keep their
    color — a scroll in a gray room.

## Color — one atmosphere per theme, only L moves

Author in **OKLCH** (perceptual lightness — HSL's L lies). Each theme is one hue+chroma
pair; every neutral is an L stop on it. Light = warm washi paper `oklch(L 0.006 85)`; dark
(the native theme) = blue-black night `oklch(L 0.012 270)`.

| Token | Light L (≈hex) | Dark L (≈hex) | Role |
|---|---|---|---|
| ground | 0.97 `#f6f4f0` | 0.15 `#0a0a11` | the page |
| surface | 0.985 `#fbfaf7` | 0.20 `#15151d` | cards |
| raised | 0.995 `#fefdfb` | 0.24 `#1e1e27` | hover, dropdowns |
| overlay | 1.00 `#ffffff` | 0.28 `#26262f` | modals |
| line | 0.90 `#e4e1da` | 0.27 `#24242d` | hairlines |
| line-strong | 0.84 `#d2cec6` | 0.35 `#33333e` | strong rules |
| text-3 | 0.55 `#767066` | 0.60 `#7d7d89` | tertiary floor |
| text-2 | 0.45 `#5a554d` | 0.75 `#a8a8b3` | secondary |
| ink | 0.23 `#211e19` | 0.95 `#eeedf4` | primary (never pure #fff) |
| seal | `oklch(0.62 0.19 29)` `#e34a33` | `oklch(0.68 0.19 29)` `#f96146` | the one red |

Selection inverts (ink bg, ground text). Full sheet with shadows, stars, durations:
[references/tokens.css](references/tokens.css).

## Typography — one superfamily, hierarchy by light

**Geist** (sans) + **Geist Mono** — same family, two voices; both on Google Fonts, loaded
with `display=swap`. Weights **400/500/600 only**. Hierarchy instruments in order:
lightness first, weight second, size last (one lowercase display moment per view).

| Register | Size/line | Face·weight | Treatment |
|---|---|---|---|
| micro | 10/16 | mono 400 | UPPERCASE, +0.08em, text-3 — the signature register |
| small | 14/20 | sans 400 | secondary UI |
| base | 16/24 | sans 400 | UI body (16px = no mobile input zoom) |
| long-form | 18/32 | sans 400 | articles; +0.01em tracking at night |
| heading | 20/28 | sans 600 | −0.01em, sentence case, top margin ≈ 2× bottom |
| display | 56/56 (40/40 hand) | sans 600 | −0.02em, lowercase, one per view |

Line-heights are multiples of 4 (the half-ken baseline). Section markers: `01 — name` in
the micro register. Links: underline at 25% ink, offset 2px, full on hover; external gets
`↗`. Measure 42rem (~66ch); 56rem only for wide layouts.

## Space — the ken, Fibonacci, φ

Module = the **ken** (間, 8px — the same kanji as Ma). The ladder is Fibonacci *in ken*:

**4** (½ken, type baseline only) · **8** · **16** · **24** · **40** · **64** · **104** px
(1·2·3·5·8·13 ken — each step the sum of the two before; adjacent steps relate by φ).

Section rhythm 64. **The approach**: 104px of emptiness before a page's first ink. Page
padding 24 (hand) / 40 (table+). Grids: max 3 columns, gaps 24; stat cells divide with
hairlines on both axes, zero gap. **The alcove** (tokonoma): the one sanctioned asymmetry,
a 1:φ split (label bay : content room), hairline-divided.

**Navigation is a strip, not a wall**: sticky top strip, transparent at rest, earning its
hairline + blurred ground only when content scrolls beneath (the separation ladder, live).
Active link ink, inactive text-3. On hand, links fold into a full-screen overlay (depth
change ⇒ surface earned). Sidebars only for dense apps, and then surfaceless.

## Responsive — hand · table · room

Content-out: measures are capped, so **on vast screens Seiza adds sky, not columns**. Two
Fibonacci breakpoints only: **610px** and **987px**.

- **hand** <610 — padding 24, display 40/40, grids collapse (stats 2-col), alcove stacks,
  overlay menu. Vertical rhythm does NOT compress.
- **table** 610–987 — padding 40, 2-col grids, alcove active.
- **room** ≥987 — 3-col max, 56rem wide layouts, inline nav.

Touch targets ≥40px (5 ken), 8px apart; 48px preferred for primary on hand. Hover is an
enhancement, never a gate. Type is device-invariant except display.

## Components — the recipe

Radii are Fibonacci: **5** minor · **8** buttons/inputs · **13** cards/menus · **21**
modals/hero · **full** pills. Shadow geometry in ken, straight down, cast in ink:
level 1 `0 8 24 −8 @10%` · level 2 `0 16 40 −16 @14%` · level 3 `0 24 64 −24 @18%`;
at night all three become `inset 0 1px 0` edge-light (7/10/14%). Z-ladder: content 0 ·
strip 13 · dropdown 21 · scrim/modal 34 · toast 55.

| Component | Surface | Radius | Padding | Type | Shadow |
|---|---|---|---|---|---|
| card | surface | 13 | 24 | base | 1 |
| button | ink / outline | 8 | 8×16 | 14·500 | — |
| input (40px tall) | none | 8 | 8×16 | base | — |
| pill (24px tall) | none / ink | full | 4×8 | micro | — |
| menu | raised | 13 | 8 | 14 | 2 |
| modal | overlay | 21 | 24 | base | 3 |
| toast | raised | 13 | 16×24 | small | 2 |

Focus: `outline: 1px solid ink, offset 3px` — no glow rings; input focus brings the border
to ink. Icons: outline only, 1.5px stroke, round caps, ken boxes (16/24), `currentColor`
(default source: Lucide). Scrollbars 8px. Every remaining recipe — form controls, table,
tabs, toast, loading/empty, code blocks (syntax by weight and depth, not hue):
[references/components.md](references/components.md).

## Motion — time on the same golden ladder

Durations are Fibonacci ms — **144** micro/state-change · **233** hover · **377** reveal ·
**610** entrance/theme · **1597** ambient. One curve, **the settle**:
`cubic-bezier(0.16, 1, 0.3, 1)` — no bounce, no overshoot, ever.

- **Arrive by rising, leave by fading**: entrances rise 13px and settle; exits fade in
  place, one ladder step shorter. State changes (icon/label swaps): 144, incoming face
  rises 4px, outgoing fades; auto-revert cues (e.g. Copied) at 1597; toasts dismiss at 4181.
- **Entrance stagger**: 55ms apart, delays capped at 377. Load-time only — no
  scroll-jacking, no parallax. Theme crossfade 610 on colors only.
- Animate only opacity + transform (+ colors for crossfades). Never layout properties.
- `prefers-reduced-motion` stops everything; the page must be complete when still.

## Texture — points and strokes only

Vocabulary: **starfield** (13 stars scattered — never gridded — on a 233px CSS-gradient
tile: 2 bright/3 median/8 faint, in ink: night 60/35/18%, day dust 20/12/7%), **arc** (a
hairline of a 1597px circle, only the horizon showing, rim glow, ends masked — hero only),
**image dissolve** (masks fade an image's foot into the ground / the stars), and **the seal
star** (the seal's only cosmic form: a washed feathered glow-core + halo — never hard,
never tiled, never *on* a line, though it may *rise behind* the horizon, occluded to a
crest of shine). Budget: one texture per view, two on a hero. Always masked. Ground only —
never on a surface. Perfectly still. Construction CSS:
[references/texture.md](references/texture.md).

## Theming & the sky toggle

Tokens on `:root` (light); dark under `@media (prefers-color-scheme: dark)` guarded
`:root:not([data-theme="light"])`, and again under `:root[data-theme="dark"]`. The toggle
is **two-state** (after Lea Verou, <https://lea.verou.me/blog/2026/dark-mode-toggles/>):
label shows the current sky (`sky · day` / `sky · night`), click flips; if the target
equals the system preference *at click time*, remove the override (silent return to
system-tracking) — never show a "system" option in the persistent control (tri-state
belongs only in settings panels). Crossfade via a temporary class; guarded localStorage.
Full snippet: [references/architecture.md](references/architecture.md).

## Voice

Display words are lowercase and singular. Buttons name the outcome ("Publish", never
"OK"). Errors say what happened and how to fix it — the only red sentences in the world.
Empty states invite, don't apologize: one line at text-2 + one action (Ma is the design).
Numbers align with `tabular-nums`.

## Accessibility — non-negotiable

Semantic landmarks; text-3 is the readability floor (verify AA on real pairs); keyboard
paths for every overlay (Escape closes); visible focus; honor `prefers-color-scheme` +
`prefers-reduced-motion`; declare `color-scheme: light dark`; hover never a gate; touch
targets per the responsive section; decorative texture is `aria-hidden`.

## Applying Seiza to an existing project

Keep the stack. Work in this order: (1) collapse colors to the two atmospheres,
(2) install Geist/Geist Mono and re-cast the registers, (3) thin borders to hairlines and
align radii to 5/8/13/21, (4) re-cut spacing onto the ken ladder and strip child margins,
(5) re-map shadows to the three levels + night edge-light, (6) add theming + the sky
toggle, (7) re-time motion onto the Fibonacci ladder, (8) finish with at most one texture
and place the seal. Stop before it gets busy: **if a screen feels empty, that is usually
correct.**
