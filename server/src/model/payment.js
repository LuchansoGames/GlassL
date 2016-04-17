'use strict';

let mongoose = require('../db'),
  paymentSchema = require('./payment-schema');

let Payment = mongoose.model('Payment', paymentSchema);

module.exports = Payment;