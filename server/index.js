'use strict';

let app = require('./src/app');

require('./public/router');
let vk = require('./src/vk');

vk.getToken();