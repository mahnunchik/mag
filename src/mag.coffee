
###*
 * Module dependencies
###

util = require('util')

###*
 * Cached slice method
###

slice = Array.prototype.slice

###*
 * Logged fields
###

pid = process.pid.toString()
hostname = require('os').hostname().replace(/\s+/g, '')

###*
 * Is stdout TTY?
###

istty = process.stdout.isTTY

###*
 * Log levels with shortcuts
###

levels =
  EMERGENCY: 0
  emergency: 0
  emerg: 0
  panic: 0
  ALERT: 1
  alert: 1
  CRITICAL: 2
  critical: 2
  crit: 2
  ERROR: 3
  error: 3
  err: 3
  WARNING: 4
  warning: 4
  warn: 4
  NOTICE: 5
  notice: 5
  INFO: 6
  info: 6
  DEBUG: 7
  debug: 7

###*
 * Full log level names
###

levelNames = [
  'EMERGENCY'
  'ALERT'
  'CRITICAL'
  'ERROR'
  'WARNING'
  'NOTICE'
  'INFO'
  'DEBUG'
]

###*
 * Logger
 * @class Logger
###

class Logger

  ###*
   * @constructor
   * @param {String} tag tag to attach to each log message
  ###

  constructor: (@tag='')->

  ###*
   * @private
   * @param {Number} level log level
   * @param {Array} message entities for log
  ###

  _log: (level, message)->
    if level <= exports.level
      data =
        tag: @tag
        pid: pid
        hostname: hostname
        timestamp: new Date()
        level: level
        levelName: levelNames[level]
        message: util.format.apply(this, message)
      process.stdout.write(exports.format(data))

  ###*
   * @param {String} levelName log level name
   * @param message log message
  ###

  log: (levelName)->
    level = levels[levelName]
    @_log(level, slice.call(arguments, 1))

  ###*
   * @param message log message
  ###

  emergency: ()->
    @_log(0, arguments)
  emerg: @::emergency

  ###*
   * @param message log message
  ###

  alert: ()->
    @_log(1, arguments)

  ###*
   * @param message log message
  ###

  critical: ()->
    @_log(2, arguments)
  crit: @::critical

  ###*
   * @param message log message
  ###

  error: ()->
    @_log(3, arguments)
  err: @::error

  ###*
   * @param message log message
  ###

  warning: ()->
    @_log(4, arguments)
  warn: @::warning

  ###*
   * @param message log message
  ###

  notice: ()->
    @_log(5, arguments)

  ###*
   * @param message log message
  ###

  info: ()->
    @_log(6, arguments)

  ###*
   * @param message log message
  ###

  debug: ()->
    @_log(7, arguments)

  ###*
   * Connect/Express middleware
   * @param {String} str message to log
  ###

  write: (str)->
    str = str.replace(/\n$/, '')
    @_log(6, [str])

###*
 * Logger factory
###

module.exports = exports = (tag)->
  return new Logger(tag)

###*
 * Default log level
###

exports.level = levels.DEBUG

###*
 * Set global log level
 * @param {Sting|Number} level log level
###

exports.setLevel = (level)->
  level = levels[level.toUpperCase()] if 'string' == typeof level
  exports.level = level if level?

###*
 * All levels
###

exports.levels = levels


# ANSI Terminal Colors
bold = '\x1b[0;1m'
green = '\x1b[0;32m'
reset = '\x1b[0m'
cyan = '\x1b[0;36m'


exports.formats = formats =
  console: (data)->
    return "#{data.timestamp.toLocaleTimeString()} " +
      "#{data.hostname} #{green}#{data.tag}[#{data.pid}]: #{reset}" +
      "#{cyan}<#{data.levelName}>#{reset} #{data.message}\n"

  ###*
   * logstash's internal message format
   * https://github.com/logstash/logstash/wiki/logstash's-internal-message-format
   * https://logstash.jira.com/browse/LOGSTASH-675
  ###
  file: (data)->
    return JSON.stringify({
      '@timestamp': data.timestamp
      '@tags': [data.tag, data.pid, data.levelName]
      '@source': "#{data.hostname} #{data.tag}[#{data.pid}]"
      '@message': data.message
      '@fields':
        level: data.level
        levelName: data.levelName
    }) + "\n"

if istty == true
  exports.format = formats.console
else
  exports.format = formats.file
