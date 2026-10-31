# Validation

Local verification on 31 October 2026:

- Rust 1.85.1: formatting and Clippy with warnings denied passed.
- Rust tests: five state-machine unit tests and two real transport integration tests passed.
- Flutter 3.29.3 / Dart 3.7.2: analysis passed with no issues.
- Flutter tests: two widget tests and one real gRPC reconnection test passed.
- Release Flutter web build passed.
- Browser verification: received live telemetry; armed and started a mission through the dashboard; observed ascent, changing position, speed and mission progress.
- Docker: backend and dashboard multi-stage builds passed. The deployed Compose stack passed snapshot, arm, mission, hold, land and event retrieval through the same-origin Nginx gRPC-Web proxy. Both containers were confirmed running.

GitHub Actions workflows are supplied for validation, artifact packaging, Docker smoke testing, and publishing versioned GHCR images on `v*` tags. They have not been executed remotely in this workspace.
