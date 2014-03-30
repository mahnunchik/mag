
var Logger = require('mag-logger-facade');

var stream;

try {
  stream = require('mag-hub');
} catch (err) {
  stream = require('mag-fallback');
}

module.exports = function (namespace){
  return new Logger(stream, namespace);
};
