# Seiza — texture construction

Texture is **points and strokes only**: starfield, arc, image dissolve, seal star. Assumes
[tokens.css](tokens.css). Laws: one texture per view (two on a hero) · always masked —
dissolve, never end at an edge · ground only, never on a surface · perfectly still (no
twinkle, no parallax) · never under running text at legibility's expense · decorative
texture is `aria-hidden="true"` with `pointer-events: none`.

**The glow law:** glow must cling to an edge — a rim, a night surface's lit top, a star's
shine. It may never float free; the free-floating gradient bloom is the signature of
machine-made pages and is banned. Wanted light gradation = emptiness does the work.

## The starfield

13 stars scattered (never gridded — a grid is print, scatter is sky) on a 233px tile:
2 bright, 3 median, 8 faint. Pure CSS, no images. One construction serves both skies
because the stars are drawn in ink (`--star-*` flips with the theme).

```css
.stars {
  background-image:
    radial-gradient(1.5px 1.5px at 89px 55px,  var(--star-1), transparent),
    radial-gradient(1.5px 1.5px at 176px 165px, var(--star-1), transparent),
    radial-gradient(1px 1px at 13px 34px,   var(--star-2), transparent),
    radial-gradient(1px 1px at 144px 21px,  var(--star-2), transparent),
    radial-gradient(1px 1px at 76px 199px,  var(--star-2), transparent),
    radial-gradient(1px 1px at 55px 8px,    var(--star-3), transparent),
    radial-gradient(1px 1px at 199px 89px,  var(--star-3), transparent),
    radial-gradient(1px 1px at 34px 110px,  var(--star-3), transparent),
    radial-gradient(1px 1px at 110px 144px, var(--star-3), transparent),
    radial-gradient(1px 1px at 21px 178px,  var(--star-3), transparent),
    radial-gradient(1px 1px at 150px 220px, var(--star-3), transparent),
    radial-gradient(1px 1px at 222px 13px,  var(--star-3), transparent),
    radial-gradient(1px 1px at 183px 122px, var(--star-3), transparent);
  background-size: 233px 233px;
}
```

Always fade the field with a mask, e.g. a hero sky dissolving downward:

```css
.hero-sky {
  position: absolute; inset: -104px -40px 0; pointer-events: none;
  -webkit-mask-image: radial-gradient(ellipse 90% 75% at 50% 0%, black 21%, transparent 79%);
  mask-image: radial-gradient(ellipse 90% 75% at 50% 0%, black 21%, transparent 79%);
}
```

## The arc (hero only, ~once per site)

A hairline of a vast circle, almost all off-canvas; rim glow clings to the line; the ends
dissolve under a horizontal mask. The disk is ground-filled so it can occlude.

```css
.arc { position: relative; height: 144px; overflow: hidden;
  -webkit-mask-image: linear-gradient(to right, transparent, black 21%, black 79%, transparent);
  mask-image: linear-gradient(to right, transparent, black 21%, black 79%, transparent); }
.arc .circle { position: absolute; top: 34px; left: 50%; transform: translateX(-50%);
  width: 1597px; height: 1597px; border-radius: 50%;
  border: 1px solid var(--line-strong);
  background: var(--ground);                       /* solid: occludes what rises behind */
  box-shadow: 0 -21px 55px -13px var(--wash), inset 0 21px 55px -13px var(--wash); }
```

## The seal star — the seal's only cosmic form

A washed, feathered glow-core: **never hard, never tiled, never on a line.** Hand-placed
once, outside any repeating tile. It claims the view's seal (kicker dots etc. yield).

```css
.seal-star { position: absolute; width: 8px; height: 8px; border-radius: 50%;
  background: radial-gradient(circle,
    color-mix(in oklab, var(--seal) 89%, transparent) 0%,
    color-mix(in oklab, var(--seal) 34%, transparent) 34%,
    transparent 70%);
  box-shadow: 0 0 21px 3px color-mix(in oklab, var(--seal) 21%, transparent); }
```

**The rising star** (arc composition): place the star *before* `.circle` in the DOM,
sized 13px, its center just below the rim — the ground-filled disk occludes all but a
~2px crest and the upward shine. The seal never sits ON a line, but may rise BEHIND one.

## The image dissolve

Images dissolve, they don't end. Mask the image's foot into the ground — and at night,
into a starfield layered behind it:

```css
.photo-frame { position: relative; }
.photo-frame .behind { position: absolute; inset: 0; }   /* class="behind stars" */
.photo-frame img { position: relative; width: 100%; display: block;
  -webkit-mask-image: linear-gradient(to bottom, black 34%, transparent 89%);
  mask-image: linear-gradient(to bottom, black 34%, transparent 89%); }
```

Monochrome governs the chrome, not the content: photos keep their color; only decorative
imagery leans grayscale.
