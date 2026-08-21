# Seiza — architecture, theming machinery, motion snippets

## Atomic layers & the import rule

Tokens (layer 0) → atoms → molecules → organisms → templates → pages. The metaphor is
literal: materials, bricks, joinery, rooms, floor plan, inhabited building.

| Layer | Citizens |
|---|---|
| tokens | atmosphere, ken ladder, radii, shadows, durations, registers |
| atoms | button, input, pill, micro-label, link, seal-dot, status dot, hairline |
| molecules | field (label+input+error), stat cell, menu item, action row, kicker |
| organisms | nav strip, card, menu, modal, toast, stat grid, footer |
| templates | page skeletons — the approach, the 42rem gap-64 column, section scaffolds |
| pages | content-filled instances |

**Downward-only imports:** a layer may import from *any* layer below it, never same-level
or above. Tokens are importable by all. (Not adjacent-only — that breeds pass-through
wrapper components, which is indirection-as-noise.) Same-level need = one of them is
mislabeled, or they are one component. This is the placement law seen from the code side:
atoms are spaceless stones; each layer up is the gardener for the layer below.

Folder structure: `components/{atoms,molecules,organisms,templates}` + `pages/`.

### eslint-plugin-boundaries

```js
// eslint.config.js (flat config)
import boundaries from "eslint-plugin-boundaries";
export default [{
  plugins: { boundaries },
  settings: {
    "boundaries/elements": [
      { type: "tokens",    pattern: "src/tokens/**" },
      { type: "atoms",     pattern: "src/components/atoms/**" },
      { type: "molecules", pattern: "src/components/molecules/**" },
      { type: "organisms", pattern: "src/components/organisms/**" },
      { type: "templates", pattern: "src/components/templates/**" },
      { type: "pages",     pattern: "src/pages/**" },
    ],
  },
  rules: {
    "boundaries/element-types": ["error", {
      default: "disallow",
      rules: [
        { from: "atoms",     allow: ["tokens"] },
        { from: "molecules", allow: ["tokens", "atoms"] },
        { from: "organisms", allow: ["tokens", "atoms", "molecules"] },
        { from: "templates", allow: ["tokens", "atoms", "molecules", "organisms"] },
        { from: "pages",     allow: ["tokens", "atoms", "molecules", "organisms", "templates"] },
      ],
    }],
  },
}];
```

(`dependency-cruiser` expresses the same rule with `forbidden` path rules if the project
already uses it.)

## The sky toggle (two-state, after Lea Verou)

<https://lea.verou.me/blog/2026/dark-mode-toggles/> — the model keeps three states, the
control shows two. The label shows the current resolved sky; clicking flips it. System
preference is evaluated **only at click time**; toggling to what the system already
prefers stores nothing (silent return to system-tracking, so OS auto-switching keeps
working). A stored choice is never demoted because the OS later matches it. Never show a
"system" option in the persistent control — tri-state belongs only in settings panels.
Pairs with `.sky-fade` in [tokens.css](tokens.css) for the 610ms crossfade.

```html
<button type="button" id="sky-toggle" aria-live="polite">sky</button>
```

```js
(function () {
  var root = document.documentElement;
  var toggle = document.getElementById('sky-toggle');
  var mq = window.matchMedia('(prefers-color-scheme: dark)');
  var names = { light: 'day', dark: 'night' };

  var stored = null;
  try { stored = localStorage.getItem('seiza-sky'); } catch (e) {}
  if (stored === 'light' || stored === 'dark') root.dataset.theme = stored;

  var resolved = function () { return root.dataset.theme || (mq.matches ? 'dark' : 'light'); };
  var setLabel = function () {
    var cur = resolved();
    toggle.textContent = 'sky · ' + names[cur];
    toggle.setAttribute('aria-label', 'switch to ' + names[cur === 'dark' ? 'light' : 'dark'] + ' sky');
  };
  setLabel();
  if (mq.addEventListener) mq.addEventListener('change', setLabel); // label only — never touch stored overrides

  var fadeTimer = null;
  toggle.addEventListener('click', function () {
    var target = resolved() === 'dark' ? 'light' : 'dark';
    var system = mq.matches ? 'dark' : 'light';
    root.classList.add('sky-fade');
    if (fadeTimer) clearTimeout(fadeTimer);
    fadeTimer = setTimeout(function () { root.classList.remove('sky-fade'); }, 660);
    if (target === system) {
      delete root.dataset.theme;
      try { localStorage.removeItem('seiza-sky'); } catch (e) {}
    } else {
      root.dataset.theme = target;
      try { localStorage.setItem('seiza-sky', target); } catch (e) {}
    }
    setLabel();
  });
})();
```

Place the toggle script inline near the top of `<body>` (or apply the stored theme in a
tiny head script) so the first paint uses the stored sky — no flash.

## Entrance & state-change snippets

```css
@keyframes rise { to { opacity: 1; transform: translateY(0); } }
@media (prefers-reduced-motion: no-preference) {
  .entrance { opacity: 0; transform: translateY(13px);
    animation: rise var(--t-entrance) var(--settle) forwards; }
  .entrance:nth-child(1) { animation-delay: 55ms; }
  .entrance:nth-child(2) { animation-delay: 110ms; }
  .entrance:nth-child(3) { animation-delay: 165ms; }
  .entrance:nth-child(4) { animation-delay: 220ms; }
  .entrance:nth-child(5) { animation-delay: 275ms; }
  .entrance:nth-child(6) { animation-delay: 330ms; }
  .entrance:nth-child(n+7) { animation-delay: 377ms; }
}

/* state change: stacked faces — incoming rises a half-ken, outgoing only fades */
.swap { display: grid; }
.swap .face { grid-area: 1 / 1; display: inline-flex; align-items: center; gap: 8px;
  justify-content: center;
  transition: opacity var(--t-micro) var(--settle), transform var(--t-micro) var(--settle); }
.swap .face-b { opacity: 0; transform: translateY(4px); }
.is-toggled .face-a { opacity: 0; }
.is-toggled .face-b { opacity: 1; transform: none; }
```

Custom animations compose **only** ladder durations (144/233/377/610/1597) and the settle.
