'use strict';

let mongoose = require('mongoose'),
  config = require('../config');

mongoose.connect(config.db.path);

module.exports = mongoose;