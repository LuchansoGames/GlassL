'use strict';

let mongoose = require('../db'),
  scoreSchema = require('./score-schema');

let Score = mongoose.model('Score', scoreSchema);

Score.getTop100 = () => {
  return Score.find({}, {_id: 0, __v: 0}).sort({score: -1});
}

Score.isBetterScore = (scoreNumber) => {
  let minimalBetterScore = 0;

  return Score.find({}).sort({
      score: -1
    })
    .then((results) => {
      return new Promise((res, rej) => {
        if (results.length < 100) {
          res(true);
        } else {
          let minimalBetterScore = results[99].score;
          res(minimalBetterScore < scoreNumber);
        }
      });
    })
}

Score.newScore = (score) => {
  return score.save()
    .then(() => {
      return Score.find({}).sort({
        score: -1
      });
    })
    .then((results) => {
      if (results.length >= 100) {
        results[results.length - 1].remove();
      }
      return score;
    });
}

module.exports = Score;