'use strict';

let mongoose = require('mongoose'),
  config = require('../config');

let mongoUrl = process.env.MONGO_URL || config.db.path;

mongoose.connect(mongoUrl);

module.exports = mongoose;