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

## 🌍 Environment Configuration

This project supports multiple environments for the API Base URL. Sensitive URLs are **hidden** from the source code and should be injected via terminal flags or GitHub Secrets.

### Running with Environments

| Environment | Command | Description |
|-------------|---------|-------------|
| **Local**   | `flutter run` | Defaults to `localhost:3001` (Auto-switches to `10.0.2.2` for Android). |
| **Dev**     | `flutter run --dart-define=APP_ENV=https://dev.api.***.com` | Development branch API. |
| **Stage**   | `flutter run --dart-define=APP_ENV=https://stage.api.***.com` | Staging branch API. |
| **Prod**    | `flutter run --release --dart-define=APP_ENV=https://api.***.com` | Production branch API. |

### CI/CD Branch Mapping

The GitHub Actions pipeline automatically maps branches to their respective API URLs using **GitHub Secrets**:
- **`main`** ➡️ `PROD_API_URL`
- **`stage`** ➡️ `STAGE_API_URL`
- **`dev`** ➡️ `DEV_API_URL`

> [!IMPORTANT]
> **GitHub Secrets Setup**: Ensure `PROD_API_URL`, `STAGE_API_URL`, and `DEV_API_URL` are configured in your repository settings.

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

## 🛰️ CI/CD & Controlled Release Workflow

This project uses a professional, tag-based release cycle to ensure that only stable, official versions are broadcasted to the team via WhatsApp.

### Release Sequence Diagram
```mermaid
graph TD
    A[Finish Features] --> B[Merge to main]
    B --> C{Ready for Release?}
    C -- No --> D[Keep Working (Artifacts only)]
    C -- Yes --> E[Run ./scripts/release.sh 1.2.0]
    E --> F[GitHub Actions Bot Starts]
    F --> G[Build Production APK]
    G --> H[Create GitHub Release Entry]
    H --> I[Send APK to WhatsApp Group]
    style I fill:#0f0,stroke:#333,stroke-width:2px
```

### 🚀 How to Release
To trigger a new official release (build APK + send to WhatsApp + create GitHub Release), use the helper script:
```bash
./scripts/release.sh 1.2.0
```
This script handles the version tagging and pushing for you, ensuring a smooth delivery to the entire team.

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
