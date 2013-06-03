
###*
 * # mag
 *
 * tiny logger for nodejs supports [logstash's internal message format](https://github.com/logstash/logstash/wiki/logstash's-internal-message-format)
 *
 * @version 0.0.6
 * @author Eugeny Vlasenko <mahnunchik@gmail.com>
 *
###

###!
 * Module dependencies
###

util = require('util')

###!
 * Cached slice method
###

slice = Array.prototype.slice

###!
 * Logged fields
###

pid = process.pid.toString()
hostname = require('os').hostname().replace(/\s+/g, '')

###!
 * Is stdout TTY?
###

istty = process.stdout.isTTY

###!
 * Log levels with shortcuts
###

levels =
  NONE: -1
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

###!
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

###!
 * Colors to use in shell output
###

colors = [
  '\x1b[0;32m'
  '\x1b[0;36m'
  '\x1b[0;31m'
  '\x1b[0;35m'
  '\x1b[0;33m'
  '\x1b[0;37m'
  '\x1b[1;34m'
  '\x1b[1;32m'
  '\x1b[1;36m'
  '\x1b[1;31m'
  '\x1b[1;35m'
  '\x1b[1;33m'
  '\x1b[0;34m'
]

prevColor = 0

color = ()->
  return colors[prevColor++ % colors.length]


class Logger

  ###*
   *
   * Mag costructor
   *
   * @param {String} tag name to attach to each log message
   * @param {Number} level log level
   * @param {String} color color of message
   * @constructor
   *
  ###

  constructor: (@tag, @level, @color)->

  ###*
   *
   * Basic log method
   *
   * @method _log
   *
   * @param {Number} level log level
   * @param {Array} message entities for log
   *
  ###

  _log: (level, message)->
    if level <= @level
      data =
        tag: @tag
        pid: pid
        hostname: hostname
        timestamp: new Date()
        level: level
        levelName: levelNames[level]
        message: util.format.apply(this, message)
        color: @color
      process.stdout.write(exports.format(data))

  ###*
   *
   * Usage:
   *
   *     logger.log('INFO', message)
   *
   * @param {String} levelName log level name
   * @param {Any} messages entities to log
   *
  ###

  log: (levelName)->
    level = levels[levelName]
    @_log(level, slice.call(arguments, 1))

  ###*
   *
   * System is unusable
   *
   * @param {Any} messages entities to log
   *
  ###

  emergency: ()->
    @_log(0, arguments)
  emerg: @::emergency

  ###*
   *
   * Action must be taken immediately
   *
   * @param {Any} messages entities to log
   *
  ###

  alert: ()->
    @_log(1, arguments)

  ###*
   *
   * Critical conditions
   *
   * @param {Any} messages entities to log
   *
  ###

  critical: ()->
    @_log(2, arguments)
  crit: @::critical

  ###*
   *
   * Error conditions.
   *
   * @param {Any} messages entities to log
   *
  ###

  error: ()->
    @_log(3, arguments)
  err: @::error

  ###*
   *
   * Warning conditions
   *
   * @param {Any} messages entities to log
   *
  ###

  warning: ()->
    @_log(4, arguments)
  warn: @::warning

  ###*
   *
   * Normal but significant condition
   *
   * @param {Any} messages entities to log
   *
  ###

  notice: ()->
    @_log(5, arguments)

  ###*
   *
   * Informational messages
   *
   * @param {Any} messages entities to log
   *
  ###

  info: ()->
    @_log(6, arguments)

  ###*
   *
   * Debug-level messages
   *
   * @param {Any} messages entities to log
   *
  ###

  debug: ()->
    @_log(7, arguments)

  ###*
   *
   * Connect/Express middleware
   *
   * @param {String} str message to log
   *
  ###

  write: (str)->
    str = str.replace(/\n$/, '')
    @_log(6, [str])

###*
 *
 * Logger factory
 *
 * Usage:
 *
 *     logger = require('mag')('my_logger', 'INFO')
 *
 * @param {String} tag name to attach to each log message
 * @param {Number|String} level log level
 *
###

module.exports = exports = (tag='', level)->
  level = levels[level.toUpperCase()] if 'string' == typeof level
  level ?= levels.DEBUG
  return new Logger(tag, level, color())

# ANSI Terminal Colors
bold = '\x1b[0;1m'
green = '\x1b[0;32m'
reset = '\x1b[0m'
cyan = '\x1b[0;36m'

exports.levels = levels

exports.formats = formats =
  console: (data)->
    t = data.timestamp
    return "#{t.toLocaleTimeString()}.#{t.getMilliseconds()} " +
      "#{data.hostname} #{data.color}#{data.tag}[#{data.pid}]:#{reset} " +
      "#{cyan}<#{data.levelName}>#{reset} #{data.message}\n"

  ###!
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
