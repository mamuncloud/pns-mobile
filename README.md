# PNS Mobile

A premium Flutter application for the PNS project.

## 🚀 CI/CD & Release Workflow

This project uses GitHub Actions for continuous integration. To optimize resource usage and manage releases, the build and delivery process is triggered by **Conventional Commits**.

### Triggering a Release
The release sequence (Build APK, Artifact Upload, and WhatsApp Delivery) is triggered only when pushing to `main` or `develop` with the following commit prefixes:

- `feat`: Triggers a new feature release build.
- `fix`: Triggers a bug fix release build.

### Delivery Rules
- **Develop/Main**: Every `feat` or `fix` push triggers a release APK build and uploads it as a GitHub artifact.
- **Main only**: In addition to the build, the resulting APK is automatically sent to the configured **WhatsApp group/number** for immediate distribution.

### Verification (Always On)
Linting, static analysis, formatting checks, and unit tests run on **every push and pull request** regardless of the commit message, ensuring code quality is always maintained.

---

## Getting Started

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/).
