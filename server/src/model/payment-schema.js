'use strict';

let mongoose = require('../db'),
  userSchema = require('./user-schema'),
  Schema = mongoose.Schema;

let paymentSchema = new Schema({
  coins: Number,
  date: { type: Date, default: Date.now },
  userId: [userSchema]
});

module.exports = paymentSchema;