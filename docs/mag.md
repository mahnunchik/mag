

<!-- Start src/mag.coffee -->

# mag

tiny logger for nodejs supports [logstash's internal message format](https://github.com/logstash/logstash/wiki/logstash's-internal-message-format)

Author: Eugeny Vlasenko <mahnunchik@gmail.com>

Version: 0.0.6

## Logger(tag, level, color)

Mag costructor

### Params: 

* **String** *tag* name to attach to each log message

* **Number** *level* log level

* **String** *color* color of message

## _log(level, message)

Basic log method

### Params: 

* **Number** *level* log level

* **Array** *message* entities for log

## log(levelName, messages)

Usage:

    logger.log('INFO', message)

### Params: 

* **String** *levelName* log level name

* **Any** *messages* entities to log

## emergency(messages)

System is unusable

### Params: 

* **Any** *messages* entities to log

## alert(messages)

Action must be taken immediately

### Params: 

* **Any** *messages* entities to log

## critical(messages)

Critical conditions

### Params: 

* **Any** *messages* entities to log

## error(messages)

Error conditions.

### Params: 

* **Any** *messages* entities to log

## warning(messages)

Warning conditions

### Params: 

* **Any** *messages* entities to log

## notice(messages)

Normal but significant condition

### Params: 

* **Any** *messages* entities to log

## info(messages)

Informational messages

### Params: 

* **Any** *messages* entities to log

## debug(messages)

Debug-level messages

### Params: 

* **Any** *messages* entities to log

## write(str)

Connect/Express middleware

### Params: 

* **String** *str* message to log

## exports

Logger factory

Usage:

    logger = require('mag')('my_logger', 'INFO')

### Params: 

* **String** *tag* name to attach to each log message

* **Number|String** *level* log level

<!-- End src/mag.coffee -->

