'use strict';

let User = require('../src/model/user'),
  should = require('should');

describe('Test coins system', function() {
  let user = new User({
    id: '1',
    coins: 3
  });

  it('Test update function mongoose', (done) => {
    user.save()
      .then(() => {
        return User.update({
          id: user.id
        }, {
          $inc: {
            coins: -1
          }
        });
      })
      .then((result) => {
        should(result).be.ok();
        result.should.be.have.property('ok');
        result.ok.should.be.eql(1);

        return User.findOne({id: user.id});
      })
      .then((result) => {
        should(result).be.ok();
        result.should.be.have.property('coins');
        result.coins.should.be.eql(2);

        done();
      })
      .catch(done);
  });

  after((done) => {
    user.remove()
    .then(() => {
      done();
    });
  });
});