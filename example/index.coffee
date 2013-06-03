mag = require('../')
logger = mag('logger name', 'INFO')

msg = 'this is message'
meta_0 = {data: 'meta'}
meta_1 = {obj: {time: new Date(100000)}}

logger.log('EMERGENCY', msg, meta_0, meta_1)
logger.log('ALERT', msg, meta_0, meta_1)
logger.log('CRITICAL', msg, meta_0, meta_1)
logger.log('ERROR', msg, meta_0, meta_1)
logger.log('WARNING', msg, meta_0, meta_1)
logger.log('NOTICE', msg, meta_0, meta_1)
logger.log('INFO', msg, meta_0, meta_1)
logger.log('DEBUG', msg, meta_0, meta_1)

logger.log('emergency', msg, meta_0, meta_1)
logger.log('alert', msg, meta_0, meta_1)
logger.log('critical', msg, meta_0, meta_1)
logger.log('error', msg, meta_0, meta_1)
logger.log('warning', msg, meta_0, meta_1)
logger.log('notice', msg, meta_0, meta_1)
logger.log('info', msg, meta_0, meta_1)
logger.log('debug', msg, meta_0, meta_1)

logger.emergency(msg, meta_0, meta_1)
logger.alert(msg, meta_0, meta_1)
logger.critical(msg, meta_0, meta_1)
logger.error(msg, meta_0, meta_1)
logger.warning(msg, meta_0, meta_1)
logger.notice(msg, meta_0, meta_1)
logger.info(msg, meta_0, meta_1)
logger.debug(msg, meta_0, meta_1)

logger.emerg(msg, meta_0, meta_1)
logger.crit(msg, meta_0, meta_1)
logger.err(msg, meta_0, meta_1)
logger.warn(msg, meta_0, meta_1)

logger.write("express message1\n")
logger.write("express message2\n")

for i in [0..20]
  log = mag('test colors')
  log.info("I am test color ##{i}")
