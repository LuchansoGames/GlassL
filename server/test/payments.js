'use strict';

let Payment = require('../src/model/payment'),
  User = require('../src/model/user'),
  should = require('should');

describe('Payment system test', () => {
  let userId = '1';

  it('Create transaction', (done) => {
    Payment.transaction(1, userId)
      .then((payment) => {
        should(payment).be.ok();
        payment.should.be.have.property('coins');
        payment.coins.should.be.eql(3);

        done();
      })
      .catch(done);
  });

  it('Check new user', (done) => {
    User.findOne({
      id: userId
    }).then((user) => {
      should(user).be.ok();
      user.should.be.have.property('coins');
      user.should.be.have.property('payments');
      user.coins.should.be.eql(3);
      user.payments.should.be.Array();
      user.payments.length.should.eql(1);

      done();
    });
  });

  it('Remove user and payment', (done) => {
    User.findOne({
        id: userId
      })
      .then((user) => {
        return user.remove();
      })
      .then(() => {
        done();
      })
      .catch(done);
  });
});