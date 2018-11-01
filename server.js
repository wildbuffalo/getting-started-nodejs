require("appdynamics").profile({
    controllerHostName: 'merrill.saas.appdynamics.com',
    controllerPort: 443,
    controllerSslEnabled: true,
    accountName: 'Merrill',
    accountAccessKey: '02de081213da',
    applicationName: 'Javelin-Dev',
    tierName: "dealworks-tryout-app-new",
    reuseNode: true,
    reuseNodePrefix: 'dealworks-tryout-app',
    libagent: true,
    logging: {
        logfiles: [{
            'outputType': 'console'
        }]
    }
});

'use strict';

// require("appdynamics").profile({
//     controllerHostName: 'merrill.saas.appdynamics.com',
//     controllerPort: 443,
//     controllerSslEnabled: true,
//     accountName: 'Merrill',
//     accountAccessKey: '02de081213da',
//     applicationName: 'Javelin-Dev',
//     tierName: "dealworks-tryout-app",
//     reuseNode: true,
//     reuseNodePrefix: 'dealworks-tryout-app',
//     libagent: true,
//     logging: {
//         logfiles: [{
//             'outputType': 'console'
//         }]
//     }
// });

const express = require('express');


// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
    res.send('Hello wohhrld\n');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
