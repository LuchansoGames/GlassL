'use strict';

return;

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
        return score.newAttainment('161236502', 1);
      })
      .then((data) => {        
        return score.newAttainment('161236502', 1);        
      })
      .then((data) => {        
        done();
      })
      .catch((err) => {        
        should(err).be.ok();
      });
  });
});