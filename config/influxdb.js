export const options = {
    // InfluxDB output config
    ext: {
        loadimpact: {
            projectID: 0,
            name: 'K6 Performance Test'
        }
    }
};

// InfluxDB connection
// k6 run --out influxdb=http://localhost:8086/k6 test.js
