logger = require('../')('logger test speed')
to = 1000


console_time = (new Date()).valueOf()

for i in [0..to]
  console.log("00:00:00 evlasenko-desktop logger test speed[pid]: <INFO> test message")

console_time = (new Date()).valueOf() - console_time


mag_time = (new Date()).valueOf()

for i in [0..to]
  logger.info("test message")

mag_time = (new Date()).valueOf() - mag_time

console.log("console spend #{console_time}ms")
console.log("mag spend #{mag_time}ms")