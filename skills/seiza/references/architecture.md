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

## The sky toggle (two-state, the common icon)

<https://lea.verou.me/blog/2026/dark-mode-toggles/> — the model keeps three states, the
control shows two. The face is the common icon toggle: outline sun by day, moon by night
(Lucide, 16px ken box, 1.5px stroke, on a 40px quiet target), always showing the
**current** resolved sky; clicking flips it. System preference is evaluated **only at
click time**; toggling to what the system already prefers stores nothing (silent return
to system-tracking, so OS auto-switching keeps working). A stored choice is never demoted
because the OS later matches it. Never show a "system" option in the persistent control —
tri-state belongs only in settings panels. Pairs with `.sky-fade` in
[tokens.css](tokens.css) for the 610ms crossfade; the icon swaps inside that crossfade.

The face is pure CSS on the **same guards as the tokens**, so it can never disagree with
the resolved sky and needs no script; JS carries only the aria-label and the click.

```html
<button type="button" id="sky-toggle" aria-label="switch sky">
  <svg class="sun" width="16" height="16" viewBox="0 0 24 24" fill="none"
       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
       stroke-linejoin="round" aria-hidden="true">
    <circle cx="12" cy="12" r="4"/><path d="M12 2v2"/><path d="M12 20v2"/>
    <path d="m4.93 4.93 1.41 1.41"/><path d="m17.66 17.66 1.41 1.41"/>
    <path d="M2 12h2"/><path d="M20 12h2"/>
    <path d="m6.34 17.66-1.41 1.41"/><path d="m19.07 4.93-1.41 1.41"/>
  </svg>
  <svg class="moon" width="16" height="16" viewBox="0 0 24 24" fill="none"
       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
       stroke-linejoin="round" aria-hidden="true">
    <path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"/>
  </svg>
</button>
```

```css
#sky-toggle { display: grid; place-items: center; width: 40px; height: 40px;
  background: transparent; border: none; border-radius: 8px; padding: 0;
  color: var(--text-3); cursor: pointer; transition: color var(--t-micro) ease; }
#sky-toggle:hover { color: var(--ink); }   /* further from the ground's light */
#sky-toggle .moon { display: none; }
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) #sky-toggle .sun  { display: none; }
  :root:not([data-theme="light"]) #sky-toggle .moon { display: block; }
}
:root[data-theme="dark"] #sky-toggle .sun  { display: none; }
:root[data-theme="dark"] #sky-toggle .moon { display: block; }
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
  var setAria = function () {
    var next = resolved() === 'dark' ? 'light' : 'dark';
    toggle.setAttribute('aria-label', 'switch to ' + names[next] + ' sky');
  };
  setAria();
  if (mq.addEventListener) mq.addEventListener('change', setAria); // aria only — never touch stored overrides

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
    setAria();
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
