'use strict';

let config = require('../configOAuth');

let vk = { };
let app = require('./app'),
  request = require('request'),
  url = `${config.url}?client_id=${config.client_id}&client_secret=${config.client_secret}&v=${config.v}&grant_type=${config.grant_type}`;

vk.config = config;
vk.token = null;

vk.getToken = () => {
  return new Promise((resolve, rej) => {
    request(url, (err, res, body) => {
      vk.token = JSON.parse(body).access_token;
      
      if (err) {
        rej(err);
      } else {
        resolve(vk.token);
      }
    });
  });
}

vk.take = function(method, params, callback) {
  var url = `https://api.vk.com/method/${method}?access_token=${this.token}&client_secret=${this.config.client_secret}`;

  for (var param in params) {
    url += `&${param}=${params[param]}`;
  }

  return new Promise((resolve, reject) => {
    request(url, (err, res, body) => {
      if (callback) {
        callback(err, body);
      } else if (body) {
          resolve(body);
      } else {
        reject(err);
      }      
    });
  });
}

module.exports = vk;