/* Livereload isn't working for some reason... */

require('./watch');
const livereload = require('livereload');
const path = require('path');

const server = livereload.createServer();
server.watch(path.resolve(__dirname, '../qbasic'));
