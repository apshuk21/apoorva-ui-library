# UI library playbook (React + Vite + SCSS)

A complete, step‑by‑step, enterprise‑grade guide to design, build, version, document, and release a React UI library to npm — with both GitHub Actions and Jenkins CI/CD options. It’s written so you (or any student) can reproduce it anytime.

---

## Step 1: Foundations and standards

### Project definition

- **Library identity:**
  - **Scope and name:** `@apoorva/ui`
  - **Description:** A React UI component library for enterprise apps, published publicly for learning.
  - **License:** MIT
- **Runtime support:**
  - **React versions:** 18 and 19 as peer dependencies
  - **Node baseline:** Node 18 LTS minimum (CI validates on Node 18 and 20)
- **Distribution model:**
  - Public npm package under `@apoorva` scope
  - Module formats: ESM and CJS bundles; TypeScript declarations; SCSS compiled to CSS

### Repository setup

- Monorepo with `packages/*` structure for core, icons, docs
- Protect `main`, `uat`, `qa`, `develop` branches
- Include: `README.md`, `CONTRIBUTING.md`, `CHANGELOG.md` (managed by Changesets), `docs/architecture/ADRs/*`

### Tooling and policy choices

- **Package manager:** pnpm
- **TypeScript:** strict mode, declarations in build output
- **Lint/format:** ESLint + Prettier, import/order rules
- **Commits:** Conventional Commits with scopes

### Styling approach

- SCSS modules per component, shared `_tokens.scss` partial
- Optional CSS variables for theming
- No forced global reset; optional minimal normalize

### Public API and compatibility

- Single top‑level exports; `react` and `react-dom` external
- Compatible with React 18/19; evergreen browsers

### Release philosophy

- Semantic Versioning, beta channel for pre‑releases

### CI/CD direction

- Jenkins or GitHub Actions pipeline: install → lint → typecheck → test → build → Storybook → versioning → publish

---

## Step 2: Architecture and packaging standards

### **Blueprint 1 — Repository layout**

```plaintext
root/
  packages/
    @apoorva/components/   # Core React components (primary distribution)
    @apoorva/icons/        # Optional icon components (tree-shakeable)
    @apoorva/docs/         # Storybook-powered live documentation
  tools/                   # Internal scripts/build presets (optional)
  .github/workflows/       # CI pipelines (if using GitHub Actions)
  docs/architecture/       # Playbook + ADRs
  .vscode/                 # Editor recommendations
```

- **Purpose:** Physical folder/package structure for the monorepo, showing where core components, icons, and documentation live, plus areas for tooling, CI, and architecture docs.

apoorva-ui-library/ # Root repo
├── .gitignore # Ignores build artifacts and other files
├── package.json # Root workspace config
├── pnpm-workspace.yaml # Defines workspace package globs
├── docs/
│ └── architecture/
│ └── playbook.md # Your governance & process documentation
└── packages/
├── @apoorva/
│ ├── components/
│ │ └── src/ # Source code for UI components
│ ├── icons/
│ │ └── src/ # Source code for icons
│ └── docs/ # Documentation package (Storybook, etc.)
└── (future packages) # Any additional non-scoped packages
└── tools/ # Internal scripts, CLIs, build tools (empty for now)

---

### **Blueprint 2 — Packaging and exports**

**Packaging targets**

- **Bundle formats:**
  - **ESM:** For modern bundlers
  - **CJS:** For Node/CommonJS interop
  - **Types:** `.d.ts` declarations with source maps
- **Externalization:**
  - Peer deps: `react`, `react-dom`
  - Side‑effects: `"sideEffects": false` or `["**/*.scss"]` if preserving CSS imports
- **Exports map:**
  - Top‑level `.` to ESM/CJS/types
  - Optional subpaths later for granular imports

**Component conventions**

- One folder per component: `.tsx` + `.scss` + test + story
- Stable, minimal props; ref‑forwarding where needed; a11y built‑in

**SCSS conventions**

- Component‑scoped modules
- `_tokens.scss` partial for design tokens
- Optional CSS variables for runtime theming
- PostCSS with Autoprefixer

**Browser and SSR considerations**

- Target evergreen browsers
- Avoid DOM access in module scope for SSR

**Acceptance checklist for Step 2**

- Layout final (**Blueprint 1**)
- Bundles/externals/exports decided (**Blueprint 2**)
- API and a11y documented
- SCSS conventions locked

---

## Step 3: Folder bootstrapping and baseline configs

- pnpm workspace definition
- Root `package.json` with workspace build/lint/test scripts
- `tsconfig.base.json` with strict TypeScript settings
- Bootstrapped `@apoorva/components` package with Vite library mode and d.ts generation
- SCSS setup with `sass` + Autoprefixer

---

## Step 4: CI/CD and governance hooks

- Governance philosophy: consistency, traceability, confidence, scalability
- Tooling: ESLint, Prettier, Husky, lint‑staged, Commitlint, Changesets
- CI pipeline on `develop`, `qa`, `uat`, `main` for build/test
- Branching strategy with merge gates and environment mapping

---

## Step 5: Versioning and publishing flow

- Semantic versioning with Changesets
- npm token auth in CI
- Pre‑release beta channel for QA/UAT branches
- Stable release from `main` branch
- Release pipelines for GitHub Actions and Jenkins provided

---

## Step 6: Documentation and live previews with Storybook

- Why Storybook: visual feedback, design‑dev alignment, regression safety
- Monorepo‑friendly install under `@apoorva/docs` package
- MDX stories with usage and a11y notes
- Deployment of static Storybook via GitHub Pages or Jenkins to S3/internal server

---

## Step 7: Playbook usage and maintenance

- Onboarding: read Steps 1–2 and 4 first
- Daily flow: branch from `develop`, follow SCSS/API conventions, update Storybook, add Changeset
- Deprecation/breaking changes: warn on minor, remove on major with migration guide
- Compatibility testing: React 18 & 19; evergreen browsers
- Security/housekeeping: license, dependency hygiene, code ownership, release cadence
- ADRs for major decisions, updated as architecture evolves
