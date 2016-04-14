'use strict';

let score = { },
  vk = require('./vk');

score.newAttainment = (userId, score) => {
  return vk.take('secure.addAppEvent', {user_id: userId, activity_id: 2, value: score});
}

module.exports = score;