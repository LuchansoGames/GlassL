'use strict';

let mongoose = require('./db'),
  userSchema = require('./user-schema');

let User = mongoose.model('User', userSchema);

module.exports = User;