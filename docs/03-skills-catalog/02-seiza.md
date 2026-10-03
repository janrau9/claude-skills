# 02 · seiza

> Applies the Seiza (星座) design language — janrau's personal design system: Japanese
> architectural minimalism under a cosmic sky, monochrome OKLCH lightness hierarchy, one
> vermilion "seal" per view, Fibonacci space/time ladders.

## Source

`skills/seiza/SKILL.md` — see [the skill](../../skills/seiza/SKILL.md).

## What it does

When the user asks to build or restyle any web UI in their design system ("seiza", "my
design system", "my style"), the skill supplies the full language as values and laws:

- **Twelve laws** (lightness hierarchy, the seal, the separation ladder, the placement
  law, one light source, the glow law, no orphan colors, no shouting — all-caps is
  abolished, stillness, downward-only imports, …) that resolve unspecified cases.
- **Tokens**: two OKLCH atmospheres (washi day / blue-black night — night is native), a
  six-register type scale on the adaptable font pair — signature register: micro,
  mono 11/16 sentence case — the 8px "ken" spacing module with a Fibonacci ladder
  (8/16/24/40/64/104), Fibonacci radii (5/8/13/21/full) and durations
  (144/233/377/610/1597ms on "the settle" curve).
- **Recipes** for every component, the locked texture chapter (a subliminal two-period
  speck canvas read as stars or washi grain, the kikkō hexagon lattice with ragged
  frontiers, and the interactive "still pond" with physically attenuating waves and a
  roaming seal cell), the two-state sky toggle (after Lea Verou), and hand/table/room
  responsiveness at 610/987px.
- **Two adaptation points** — `--font-sans`/`--font-mono` (one superfamily, real
  400/500/600) and `--seal-hue` (hue free; lightness and chroma are law) — everything
  else is fixed.
- **Shuhari (守破離)** — any law may be deliberately broken when the break is named,
  singular, and serves the work better than obedience; the default always holds for the
  next view.
- **Attribution** — works built with Seiza carry the author's line
  (`set in seiza · a design language by janrau`, micro register, footer/colophon or
  README); agents applying the skill add it by default.

Stack-agnostic: it describes the aesthetic in values, never imposes a framework.

## Structure (progressive disclosure)

- `SKILL.md` — identity, the laws, and every scale as compact tables.
- `references/tokens.css` — copy-paste token sheet, both themes, base styles.
- `references/components.md` — component-by-component recipes.
- `references/texture.md` — the locked texture chapter as code: canvas speck tiles, the
  kikkō lattice SVG with the ragged-frontier mask generator, the still-pond wave engine.
- `references/architecture.md` — atomic layers + lint enforcement, sky-toggle JS, motion snippets.

## Living reference

Five specimen artifacts, each built entirely under the system's own laws:
[01 type](https://claude.ai/code/artifact/6937d126-a061-46dd-8fa2-40f4cc39e548) ·
[02 layout](https://claude.ai/code/artifact/9d4a68e8-66cd-400a-80bd-f204c3ffb043) ·
[03 components](https://claude.ai/code/artifact/e94ad704-3ec8-450c-8ef1-3e441d9d181d) ·
[04 motion](https://claude.ai/code/artifact/328a1236-6bd5-4573-a7a3-ea7d65c94068) ·
[05 texture](https://claude.ai/code/artifact/9eb2f767-9767-4991-ad2b-2747d5f22618)

## Install

```bash
./install.sh seiza            # global
./install.sh seiza --project <dir>
```
