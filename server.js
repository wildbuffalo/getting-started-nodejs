'use strict';
require("appdynamics").profile({
    controllerHostName: process.env.host-name,
    controllerPort: process.env.port,
    controllerSslEnabled: true,
    accountName: process.env.account-name,
    accountAccessKey: process.env.account-access-key,
    applicationName: process.env.application-name,
    tierName: "dealworks-tryout-app",
    reuseNode: true,
    reuseNodePrefix: "dealworks-tryout-app",
    libagent: true,
    logging: {
        logfiles: [{
            'outputType': 'console'
        }]
    }
});
const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
    res.send('Hello world\n');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
