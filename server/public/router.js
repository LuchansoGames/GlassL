'use strict';

let app = require('../src/app');

app.get('/', (req, res) => {
  return res.send('Hello, this is GlassL game server');
});