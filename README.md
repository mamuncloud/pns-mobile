# PNS Mobile (Flutter) 📱

A premium Flutter application for the PNS (Point of Sale & Inventory) project. Built with Flutter 3+, focusing on high-craft UI/UX and seamless performance.

## 🚀 Local Development Setup

### Prerequisites
- **Flutter SDK:** 3.0+
- **Bun:** (Mandatory for JS/TS toolchain)
- **Dart SDK:** (Included with Flutter)

### Initial Setup
1. Clone the repository and navigate to `pns-mobile`.
2. Install Node.js dependencies (for development hooks):
   ```bash
   bun install
   ```
3. Fetch Flutter packages:
   ```bash
   flutter pub get
   ```

## 🛠️ Development Workflow

### Pre-commit Hooks
This project uses **Husky** and **lint-staged** to ensure code quality before every commit.
When you run `git commit`, the following checks are triggered automatically:
1. **Formatting:** `dart format` is applied to staged files.
2. **Analysis:** `flutter analyze` runs on the codebase (strict mode).
3. **Tests:** All unit/widget tests are executed.

To run these manually:
```bash
bun run lint
bun run format
bun run test
```

### 🛰️ CI/CD & Release Sequence
Building and delivery are automated via GitHub Actions, triggered by **Conventional Commits**:
- `feat`: Triggers a new feature release build.
- `fix`: Triggers a bug fix release build.

**Delivery Rules:**
- **Push to `develop`/`main`**: Builds APK and uploads as GitHub artifact.
- **Push to `main`**: Automatically sends the APK to the configured **WhatsApp distribution group**.

---

## 💼 Core Business Rules & Invariants

All developers and agents must adhere to the project's foundational logic:

### 📦 Stock Ledger Pattern
- **Double-Entry Ledger:** All inventory movements MUST be recorded in the `stock_movements` table via `StockService`.
- **Integrity:** Never update `product_variants.stock` directly without a corresponding ledger entry.

### 🏦 Currency & Pricing
- **Integer Storage:** Prices are stored as **integers** (cents/lowest unit) to prevent floating-point inaccuracies.
- **Formatters:** UI-side formatters handle locale-specific display (e.g., IDR).

### 🔏 Security & Access
- **RBAC:** Strict role-based access using `RolesGuard`.
- **Public Scopes:** Only read-only operations for products and store settings are public.
- **Autorization:** Managers or higher roles are required for state-changing actions.

---

## 🏗️ Project Support
For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/).

*Created and maintained by the Antigravity Team*
