const instana = require('@instana/collector');
instana();
// var express = require('express');
// var app = express();
var http = require("http");
// var fs = require("fs");

// var user = {
//     "VCAP_SERVICES": {
//         "user-provided": [{
//             "label": "user-provided",
//             "name": "test-nodejs",
//             "tags": [],
//             "instance_name": "test-nodejs",
//             "binding_name": null,
//             "credentials": {"abc": "123"},
//             "syslog_drain_url": "11",
//             "volume_mounts": []
//         }]
//     }
// };
// process.env.abc = 123;
// process.env.VCAP_SERVICES
var vcap = JSON.parse(process.env.VCAP_SERVICES);

var app = http.createServer(function (req, res) {
    // res.setHeader('Content-Type', 'application/json');
    // res.end(JSON.stringify(process.env.abc));
    // res.end(toString(user));
    res.writeHead(200);
    console.log(req.method);
    console.log(req.headers);

    console.log(vcap["user-provided"][0].credentials.abc);
    res.write("dddd");
    res.end();
});
// app.post('/addUser', function (req, res) {
//     // First read existing users.
//     // fs.readFile(__dirname + "/" + "users.json", 'utf8', function (err, data) {
//     //     data = JSON.parse(data);
//     // data["user4"] = user["user4"];
//     //     console.log(data);
//     //     res.end(JSON.stringify(data));
//     // });
//     res.json({ "foo": "bar" });
// })

// var server = app.listen(3000, function () {
//     var host = server.address().address
//     var port = server.address().port
//     console.log("Example app listening at http://%s:%s", host, port)
// })
app.listen(process.env.PORT || 3000);
