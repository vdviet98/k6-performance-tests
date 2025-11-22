#!/bin/bash
# Script to run K6 performance test with InfluxDB output
# Usage: ./run-test.sh [test-file]

# ===== Configuration =====
INFLUXDB_URL="http://localhost:8086/k6"
K6_IMAGE="grafana/k6:latest"
TEST_SCRIPT="basic-test.js"

# Allow override test script from command line argument
if [ -n "$1" ]; then
  TEST_SCRIPT="$1"
fi

echo "Starting K6 test: $TEST_SCRIPT"
echo "InfluxDB output: $INFLUXDB_URL"
echo ""

# Run K6 in Docker container
# --rm: Auto remove container after test
# --network host: Use host network to access localhost
# -v: Mount tests folder into container
docker run --rm -i \
  --network host \
  -v $(pwd)/tests:/tests \
  $K6_IMAGE run \
  --out influxdb=$INFLUXDB_URL \
  /tests/$TEST_SCRIPT

echo ""
echo "Test completed!"