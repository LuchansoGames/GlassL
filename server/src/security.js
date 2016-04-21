'use strict';

const crypto = require('crypto');

let security = {},
  globalConfig = require('../config'),
  config = require('../configOAuth');

security.checkScoreData = (data) => {
  let result = false;

  if (typeof(data) === 'object') {
    result = typeof(data.id) === 'string' && typeof(Number.parseInt(data.score)) === 'number';
  } else {
    result = false;
  }

  return result;
}

security.checkWriteoffData = (data) => {
  let result = false;

  if (typeof(data) === 'object') {
    result = typeof(data.id) === 'string' &&
      typeof(Number.parseInt(data.coins)) === 'number';
  } else {
    result = false;
  }

  return result;
}

security.isVkServer = (data, hash) => {
  let verefiString = '';

  // if (!(typeof(data.key) === 'string' &&
  //     typeof(data.sign) === 'string')) {
  //   return false;
  // }

  for (let paramName in data) {
    if (paramName !== 'sig') {
      verefiString += `${paramName}=${data[paramName]}`;
    }
  }

  verefiString = verefiString + config.client_secret;

  let tempHash = crypto.createHash('md5').update(verefiString).digest('hex');

  return tempHash === data.sig;
}

security.isValideSign = (hash, data, rand) => {
  let secret = globalConfig.security.secret;
  let verefiString = rand + JSON.stringify(data) + secret;

  let hashGen = crypto.createHash('md5').update(verefiString).digest('hex');

  return hashGen === hash;
}

module.exports = security;