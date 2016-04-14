'use strict';

let mongoose = require('./db'),
  paymentsSchema = require('./payments-schema'),
  Schema = mongoose.Schema;

let userSchema = new Schema({
  id: String,
  coins: Number,
  payments: [paymentsSchema]
});