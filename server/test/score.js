'use strict';

let Score = require('../src/model/score'),
  should = require('should');

describe('Test score model', function() {
  let scoreArray = new Array();

  it('save', (done) => {
    let results = new Array();

    for (let i = 0; i < 100; i++) {
      let score = new Score({
        id: '1',
        score: Math.round(5 + Math.random() * 100)
      });

      results.push(score.save());

      scoreArray.push(score);
    }

    Promise.all(results)
      .then(() => {
        done();
      })
      .catch((err) => {
        done(err);
      });
  });

  it('isBetterScore', (done) => {
    Score.isBetterScore(120)
      .then((result) => {
        result.should.be.ok();
        done();
      })
      .catch((err) => {
        done(err);
      });
  });

  it('newScore', (done) => {
    let score = new Score({
      id: "2",
      score: 200
    });


    Score.newScore(score)
      .then((result) => {
        scoreArray.push(result);
        done();
      })
      .catch(done);
  });

  it('getTop100', (done) => {
    Score.getTop100()
      .then((results) => {
        should(results).be.ok();
        results.should.be.have.property('length');
        results.length.should.be.eql(100);
        results[0].should.be.have.property('id');
        results[0].should.be.have.property('score');
        should.not.exist(results[0]._id);
        done();
      })
      .catch(done);
  });

  it('remove', (done) => {
    let results = new Array();

    scoreArray.forEach((score) => {
      results.push(score.remove());
    });

    Promise.all(results)
      .then(() => {
        done();
      })
      .catch((err) => {
        done(err);
      });
  });
});