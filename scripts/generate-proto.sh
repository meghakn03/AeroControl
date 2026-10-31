#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
command -v protoc >/dev/null || { echo 'Install protoc (brew install protobuf or apt-get install protobuf-compiler)'; exit 1; }
dart pub global activate protoc_plugin 21.1.2
mkdir -p frontend/lib/generated
protoc --plugin="protoc-gen-dart=${PUB_CACHE:-$HOME/.pub-cache}/bin/protoc-gen-dart" --dart_out=grpc:frontend/lib/generated -I proto proto/aerocontrol.proto
