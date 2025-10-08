# React Project Constitution

<!-- React Application Constitution for Best Practices and Standards -->

Authoritative guardrails governing architecture, technology choices, coding standards, and evolution of this React project.

**Version**: 1.0.0  
**Ratified**: October 8, 2025  
**Last Amended**: October 8, 2025

## 1. Branching and Repository Standards

### Branch Naming (MUST)

- Every branch name **MUST** follow this pattern:  
  `type/short-description`  
  Examples:
  - ✅ `feat/add-user-profile`
  - ✅ `fix/handle-form-validation`
  - ✅ `docs/update-readme`
  - ✅ `chore/update-dependencies`
- The **type** prefix MUST be one of:  
  `feat`, `fix`, `chore`, `refactor`, `test`, `docs`, `hotfix`.
- Branch names **MUST NOT** begin with a number or contain uppercase letters or spaces.
- **Minimum branch-name length:** 10 characters.
- **Maximum branch-name length:** 50 characters.

### Branch Lifecycle (MUST)

- `main` → always deployable; protected.
- `develop` → integration branch; merged to `main` via PR after successful review.
- `feature/*` → created from `develop`; merged via PR after all checks pass.
- `hotfix/*` → created from `main`; merged into both `main` and `develop`.

### Commit Hygiene (MUST)

- Commit messages MUST follow the format: `[TYPE]: [BRIEF_DESCRIPTION]`
  - Example: `feat: add user authentication component`
  - Example: `fix: resolve form validation issue`
  - Example: `docs: update component documentation`
- Use imperative mood (e.g., "add feature" not "added feature")

## 2. Technology Stack

The following technologies are MANDATED. Introductions of alternatives require a formal RFC + approval by core maintainers.

| Layer        | Technology (Locked)        | Notes                                        |
| ------------ | -------------------------- | -------------------------------------------- |
| Runtime      | Node.js 18+ / Bun          | LTS versions only; Bun for performance gains |
| Language     | TypeScript 5.0+            | Strict mode enabled; no JavaScript files     |
| UI Framework | React 18+                  | Function components only; hooks pattern      |
| Build Tool   | Vite / Next.js             | Vite for SPA; Next.js for SSR/SSG            |
| State Mgmt   | Zustand / Redux RTK        | Zustand preferred; RTK for complex state     |
| Styling      | Tailwind CSS / CSS Modules | Utility-first; CSS Modules for components    |
| Testing      | Vitest + RTL               | Vitest for unit/integration; RTL for React   |
| Linting      | ESLint + Prettier          | React-specific rules; automated formatting   |
| Package Mgr  | pnpm                       | Workspace support; faster installs           |

PROHIBITED without approval: Vue.js, Angular, Svelte, jQuery, Bootstrap, Styled Components, Emotion, Class Components

## 3. Architectural Principles

1. **Component Composition Over Inheritance** - Favor composition patterns; avoid deep component hierarchies
2. **Single Responsibility Components** - Each component serves one clear purpose; atomic design principles
3. **Unidirectional Data Flow** - Props down, events up; predictable state mutations
4. **API Integration Patterns** - Centralized API layer with React Query/SWR for caching
5. **Performance-First Rendering** - Code splitting, lazy loading, and memoization by default
6. **Accessibility by Default** - ARIA compliance, semantic HTML, keyboard navigation support

### React Architecture Philosophy

**Container-Presentational Pattern**: Clear separation between smart and dumb components

1. **Container Components (Smart)**

   - Manage state and side effects using hooks
   - Handle data fetching and business logic
   - Examples: `UserDashboardContainer`, `ProductListContainer`

2. **Presentational Components (Dumb)**

   - Render UI based solely on props
   - No side effects; only useMemo/useCallback for optimization
   - Communicate via props and callback functions

3. **Custom Hooks for Logic**
   - Extract reusable stateful logic into custom hooks
   - Example: `useUserAuthentication`, `useLocalStorage`, `useApi`

**Component Hierarchy Pattern**: Atomic Design methodology

- Components organized as Atoms → Molecules → Organisms → Templates → Pages
- API integration handled at page/template level

## 4. Coding Standards

| Concern           | Standard                                                          |
| ----------------- | ----------------------------------------------------------------- |
| Language          | TypeScript 5.0+ with strict mode; no any types allowed            |
| Component Style   | Function components only; PascalCase naming; default exports      |
| Props Interface   | Explicit TypeScript interfaces; Props suffix (UserCardProps)      |
| Hooks Usage       | Custom hooks with use prefix; dependency arrays required          |
| State Management  | useState for local; Zustand for global; immutable updates only    |
| Async Patterns    | React Query/SWR for data fetching; async/await syntax             |
| Event Handling    | Arrow functions in JSX; preventDefault for form submissions       |
| Styling Approach  | Tailwind utility classes; CSS modules for complex components      |
| File Organization | Feature-based folders; index.ts barrel exports                    |
| Import Order      | React, libraries, internal, relative; grouped with newlines       |
| Error Boundaries  | Wrap async components; graceful degradation with fallback UI      |
| Performance       | React.memo for pure components; useMemo/useCallback strategically |
| Accessibility     | ARIA attributes; semantic HTML; keyboard navigation support       |
| Form Validation   | React Hook Form with Zod schema validation                        |
| Props Drilling    | Max 3 levels deep; use context or state management beyond         |

## 5. Linting & Code Quality Standards

### Mandatory Linting Requirements

- **All code must pass linting checks before merge**; no exceptions without documented justification
- **Standardized ESLint and Prettier configuration** across all React components with centralized ruleset
- **Automated linting integrated into CI/CD pipeline** with build failure on violations

### Code Formatting Standards

- **Automated code formatting on save** with consistent Prettier configuration
- **Pre-commit hooks enforce formatting** to prevent inconsistent code styles

#### Formatting Configuration Standards

```json
// Prettier Configuration (.prettierrc)
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "bracketSameLine": false,
  "arrowParens": "avoid",
  "endOfLine": "lf",
  "jsxSingleQuote": true,
  "quoteProps": "as-needed"
}
```

```json
// ESLint Configuration (.eslintrc.json) - React Specific Rules
{
  "extends": [
    "@typescript-eslint/recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
    "plugin:jsx-a11y/recommended"
  ],
  "rules": {
    "react/prop-types": "off",
    "react/react-in-jsx-scope": "off",
    "react-hooks/exhaustive-deps": "error",
    "jsx-a11y/anchor-is-valid": "error",
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/explicit-function-return-type": "warn"
  }
}
```

### Quality Metrics & Static Analysis

- **SonarQube integration** for code complexity, security vulnerabilities, and code smells detection
- **Test coverage enforcement** with minimum thresholds integrated into linting pipeline
- **Performance linting rules** to detect inefficient React patterns and suggest optimizations

### Language-Specific Linting Standards

#### React/JSX Specific Rules

- **Component Rules**: PascalCase naming, function components only, proper prop typing
- **Hook Rules**: Enforce rules of hooks, dependency array completeness, custom hook naming
- **JSX Rules**: Self-closing tags, proper attribute spacing, consistent quote usage
- **Performance Rules**: Detect unnecessary re-renders, missing memoization opportunities
- **Security Rules**: Prevent XSS via dangerouslySetInnerHTML, validate href attributes

#### TypeScript Specific Rules

- **Type Safety**: No any types, explicit return types for functions, strict null checks
- **Import/Export**: Consistent import organization, no unused imports, proper barrel exports
- **Interface Rules**: Prefer interfaces over types, consistent naming conventions (Props suffix)
- **Generic Rules**: Proper generic constraints, meaningful generic parameter names

#### Accessibility Rules

- **ARIA Compliance**: Required ARIA attributes for interactive elements
- **Semantic HTML**: Enforce proper HTML semantics, heading hierarchy validation
- **Keyboard Navigation**: Ensure focusable elements have proper tabindex and handlers
- **Color Contrast**: Warn about potential color contrast issues in CSS classes

### Developer Experience

- **IDE Integration**: VS Code with ESLint and Prettier extensions for real-time feedback
- **Pre-commit hooks**: Husky + lint-staged for automated linting and formatting validation
- **Exception handling**: Use `// eslint-disable-next-line rule-name` with required justification comments

## 6. Testing Rules

- **Coverage Requirements**: Minimum 80% line coverage; 90% for critical business logic components
- **Coverage Threshold Policy**: Coverage cannot decrease between commits; new features must include tests

### Test File Organization

- **Unit Tests MUST be co-located** in `__tests__` directories adjacent to source files.

  - Example: `src/components/Button/Button.tsx` → `src/components/Button/__tests__/Button.test.tsx`
  - Example: `src/hooks/useAuth.ts` → `src/hooks/__tests__/useAuth.test.ts`
  - Unit test filenames MUST end with `.test.tsx` or `.test.ts`

- **Integration Tests MUST be organized** in `src/__tests__/integration` directory structure.

  - Tests that validate component interactions and data flow between multiple components
  - Example: `src/__tests__/integration/UserDashboard.integration.test.tsx`
  - Integration test filenames MUST end with `.integration.test.tsx`

- **E2E Tests MUST be placed only in the `e2e` directory** at project root.
  - Full application workflow testing using Playwright or Cypress
  - E2E test filenames MUST end with `.e2e.test.ts`
  - Mock external APIs and services for consistent test environment

### React Testing Standards

- **Testing Library Philosophy**: Test behavior, not implementation details
- **Component Testing**: Render components with realistic props; test user interactions
- **Hook Testing**: Use `@testing-library/react-hooks` for isolated hook testing
- **Async Testing**: Proper handling of async operations with `waitFor` and `findBy` queries
- **Mock Strategy**: Mock external dependencies; avoid mocking React internals
- **Snapshot Testing**: Limited use for static components only; prefer semantic assertions

## 7. Security & Privacy

### Core Security Principles

- **Principle of least privilege** for access control and component permissions
- **No plaintext secrets** in code; environment variables for configuration only
- **CSRF/XSS protection** enforced for all form submissions and data rendering

### Input Validation & Sanitization

- **React XSS Prevention**: Never use `dangerouslySetInnerHTML` without DOMPurify sanitization; validate all user inputs
- **Form Validation**: Client-side validation with Zod schemas; always validate on server-side
- **URL Validation**: Sanitize and validate href attributes; prevent javascript: protocol injection
- **Content Security Policy**: Implement strict CSP headers; no inline scripts or styles allowed

### React-Specific Security Measures

- **Component Security**: Sanitize props before rendering; validate children prop types
- **State Security**: Never store sensitive data in React state; use secure storage APIs
- **Third-Party Components**: Security audit all npm dependencies; prefer well-maintained libraries
- **Build Security**: Use Webpack bundle analyzer to detect malicious packages; implement SRI hashes

### Network Security

- **API Security**: Implement proper CORS policies; use HTTPS for all API communications
- **Authentication**: JWT tokens stored in httpOnly cookies; implement proper token refresh flow
- **Request Validation**: Validate API responses before state updates; handle error responses gracefully

## 8. Glossary

| Term                     | Meaning                                                                                                  |
| ------------------------ | -------------------------------------------------------------------------------------------------------- |
| Component                | Reusable UI element written as a React function component with TypeScript props interface                |
| Hook                     | Custom React hook for reusable stateful logic, must start with 'use' prefix                              |
| Container Component      | Smart component that manages state and side effects, delegates rendering to presentational components    |
| Presentational Component | Dumb component that receives data via props and renders UI without side effects                          |
| Props Drilling           | Anti-pattern of passing props through multiple component layers; use context or state management instead |
| Hydration                | Process of attaching React event handlers to server-rendered HTML markup                                 |
| Code Splitting           | Technique to split JavaScript bundles for lazy loading and improved performance                          |
| CSP                      | Content Security Policy - Browser security feature preventing XSS attacks via script injection           |
| XSS Prevention           | Cross-Site Scripting prevention through input sanitization and output encoding                           |
| RTL                      | React Testing Library - Testing utilities focused on testing behavior over implementation details        |
| Zustand                  | Lightweight state management library for React applications                                              |
| Barrel Export            | index.ts file that re-exports multiple modules for cleaner import statements                             |

## 9. Enforcement

**Enforcement Policy**:

- All PRs must pass automated linting, testing, and security checks before merge
- Code reviews must verify compliance with architectural principles and coding standards
- Regular audits of dependencies and security practices

---

**Constitution Version**: 1.0.0  
**Last Updated**: October 8, 2025  
**Change Summary**: Streamlined React project constitution with essential best practices for TypeScript, testing, security, and performance
