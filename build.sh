set -euxo pipefail

mkdir -p "$(pwd)/functions"
go get ./...
GOBIN=$(pwd)/functions go install ./...
chmod +x "$(pwd)"/functions/*
go env
