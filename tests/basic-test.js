// Import K6-modules
import http from 'k6/http'; // Send HTTP requests 
import { sleep, check } from 'k6'; // sleep - Delay between requests, check - Validate responses

export const options = { 
    stages: [
        { duration: '30s', target: 10 }, // Ramp up to 10 VUs
        { duration: '1m', target: 10 }, // Stay at 10 VUs
        { duration: '10s', target: 0 }, // Ramp down to 0
    ],
};

export default function () { // Main test function
    const res = http.get('https://test.k6.io'); // Send GET request

    check(res, {
        'status is 200': (r) => r.status === 200,
        'response time < 500ms': (r) => r.timings.duration < 500,
    }); // Check if HTTP status = 200, response time < 500ms

    sleep(1);
}