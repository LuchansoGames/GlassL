'use strict';

let mongoose = require('../db'),
  Schema = mongoose.Schema;

let scoreSchema = new Schema({
  id: String,
  score: Number,
});

module.exports = scoreSchema;