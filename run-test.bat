@echo off
REM Script to run K6 performance test with InfluxDB output
REM Usage: run-test.bat [test-file]

REM ===== Configuration =====
SET INFLUXDB_URL=http://localhost:8086/k6
SET K6_IMAGE=grafana/k6:latest
SET TEST_SCRIPT=basic-test.js

REM Allow override test script from command line argument
IF NOT "%1"=="" SET TEST_SCRIPT=%1

echo Starting K6 test: %TEST_SCRIPT%
echo InfluxDB output: %INFLUXDB_URL%
echo.

REM Run K6 in Docker container
REM --rm: Auto remove container after test
REM --network host: Use host network to access localhost
REM -v: Mount tests folder into container
docker run --rm -i ^
  --network host ^
  -v %cd%/tests:/tests ^
  %K6_IMAGE% run ^
  --out influxdb=%INFLUXDB_URL% ^
  /tests/%TEST_SCRIPT%

echo.
echo Test completed!
pause