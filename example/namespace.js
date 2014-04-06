
var mag = require('../');

var logger = mag('my-app');
var libLogger = mag('my-lib');

logger.info('my great application is running');
libLogger.debug('my library is running too');
