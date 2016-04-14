'use strict';

let vk = require('../src/vk'),
  score = require('../src/score'),
  schould = require('should');

describe('VK API score', function() {
  it('Set new Score', function(done) {
    vk.getToken()
      .then(() => {        
        return score.newAttainment('161236502', 1);
      })
      .then((data) => {
        console.log(data);        
        return score.newAttainment('161236502', 1);
      })
      .then((data) => {
        console.log(data);
        return score.newAttainment('161236502', 1);        
      })
      .then((data) => {
        console.log(data);
        done();
      })
      .catch((err) => {
        console.log(err);
        err.should.be.null();
      });
  });
});