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
require("appdynamics").profile({
    controllerHostName: 'merrill.saas.appdynamics.com',
    controllerPort: 443,

    // If SSL, be sure to enable the next line
    controllerSslEnabled: true,
    accountName: 'merrill',
    accountAccessKey: '02de081213da',
    applicationName: 'dealworks-tryout-app',
    tierName: 'dealworks-tryout-app',
    nodeName: 'process' // The controller will automatically append the node name with a unique number
});
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
