
var Logger = require('mag-logger-facade');
var stream = require('mag-stream');

module.exports = function (namespace){
  return new Logger(stream, namespace);
};
