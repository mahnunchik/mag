
var logger = require('../')('example');
logger.info('example message', {meta: 'some metadata'});
logger.log('something to log');
