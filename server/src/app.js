'use strict';

let express = require('express');
let app = express();
const port = 22079;

app.listen(port, () => {
  console.log(`Server run on: 0.0.0.0:${port}`);
});

module.exports = app;