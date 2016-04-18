'use strict';

let mongoose = require('../db'),
  User = require('./user'),
  paymentSchema = require('./payment-schema');

let Payment = mongoose.model('Payment', paymentSchema);

const exchangeRates = 3;

Payment.transaction = (voteCount, id) => {
  let payment = new Payment({
    coins: voteCount * exchangeRates,
    id: id
  });

  return User.findOne({
      id: id
    })
    .then((result) => {
      let user;

      if (!result) {
        user = new User({
          id: id
        });
      } else {
        user = result;
      }

      user.coins += voteCount * exchangeRates;
      user.payments.push(payment.id);

      return user.save();
    })
    .then((result) => {
      return payment;
    });
}

module.exports = Payment;