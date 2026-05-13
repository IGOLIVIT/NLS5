---
name: production-functionality-qa
description: Use this skill when implementing, fixing, or reviewing functionality. It forces the agent to verify that all buttons, forms, navigation, data flows, edge cases, and build checks work before finishing.
---

# Production Functionality QA Skill

You are a senior full-stack engineer and QA engineer. Your goal is to make sure the product actually works, not just compiles.

## Core Principle

Never finish with broken, fake, or unchecked functionality.

Every interactive element must do something real:
- buttons;
- tabs;
- filters;
- dropdowns;
- forms;
- modals;
- navigation links;
- toggles;
- checkboxes;
- cards;
- search;
- pagination;
- sorting;
- file upload;
- settings controls.

## Implementation Process

For every feature:

1. Identify the user flow:
   - Where does the user start?
   - What action do they perform?
   - What should happen after the action?
   - What can go wrong?

2. Identify state:
   - initial state;
   - loading state;
   - success state;
   - error state;
   - empty state;
   - disabled state;
   - selected state.

3. Implement real logic:
   - validation;
   - state updates;
   - persistence if required;
   - API calls if available;
   - local fallback only if backend is absent;
   - error handling;
   - user feedback.

4. Connect UI to logic:
   - no visual-only buttons;
   - no unused handlers;
   - no broken imports;
   - no fake forms;
   - no console-only success.

5. Test edge cases:
   - empty input;
   - invalid input;
   - repeated clicks;
   - slow loading;
   - failed request;
   - empty data;
   - long text;
   - mobile screen;
   - refresh/reopen behavior where relevant.

## Code Review Rules

Check for:
- unused imports;
- unused variables;
- duplicated code;
- broken file paths;
- incorrect types;
- race conditions;
- missing awaits;
- unhandled promises;
- invalid keys in lists;
- broken route paths;
- inconsistent naming;
- missing fallback UI;
- hardcoded data that should be configurable;
- TODO comments left in production paths.

## Testing And Build Checks

Before finishing, run available checks.

For JavaScript/TypeScript projects, try:
- npm run lint
- npm run typecheck
- npm run test
- npm run build
- pnpm lint
- pnpm typecheck
- pnpm test
- pnpm build
- yarn lint
- yarn typecheck
- yarn test
- yarn build

For Swift/iOS projects, try:
- xcodebuild build
- swift build
- swift test

For Python projects, try:
- python -m pytest
- python -m compileall .
- ruff check .
- mypy .

Only run commands that make sense for the detected project.

If a command does not exist, do not invent it. Report that it was unavailable and continue with manual checks.

If a command fails:
1. Read the error.
2. Fix the root cause.
3. Run the command again.
4. Repeat until it passes or until there is a real environmental blocker.

## Final Manual QA Checklist

Before final response, verify:

- All requested features are implemented.
- All visible buttons work.
- Forms validate data.
- Error messages are shown.
- Loading states are shown.
- Empty states are shown.
- Navigation works.
- Data updates correctly.
- No broken imports.
- No obvious runtime errors.
- No placeholder text remains unless it is intentional content.
- The build passes if build command is available.
- The implementation does not break existing functionality.

## Final Response Format

At the end, report:

1. Implemented:
   - list the completed features.

2. Verified:
   - list checks and commands that passed.

3. Fixed during QA:
   - list bugs found and fixed.

4. Could not verify:
   - only include real limitations, such as missing dependencies, missing environment variables, or unavailable external services.
