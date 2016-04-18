'use strict';

let mongoose = require('../db'),
  paymentsSchema = require('./payment-schema'),
  Schema = mongoose.Schema;

let userSchema = new Schema({
  id: String,
  coins: { type: Number, default: 0 },
  payments: [paymentsSchema]
});

module.exports = userSchema;