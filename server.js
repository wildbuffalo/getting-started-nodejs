// const instana = require('@instana/collector');
// instana();
// var express = require('express');
// var app = express();
var http = require("http");
// var fs = require("fs");

// var user = {
//     "user4": {
//         "name": "mohit",
//         "password": "password4",
//         "profession": "teacher",
//         "id": 4
//     }
// }
// process.env.abc = 123;
var vcap_services = JSON.parse(process.env.VCAP_SERVICES)
var app = http.createServer(function (req, res) {
    // res.setHeader('Content-Type', 'application/json');
    // res.end(JSON.stringify(process.env.abc));
    // res.end(toString(user));
    res.writeHead(200);
    console.log(req.method);
    console.log(req.headers);

    console.log(vcap_services[0][0].credentials.abc);
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
