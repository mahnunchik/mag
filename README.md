# mag

[Mag](https://github.com/mahnunchik/mag) is the streaming logger for NodeJS

## Installation

```
$ npm install mag --save
```

## Use cases

### Everyday use cases

If you have something to show in the terminal, use the `mag` as well as you used `console.log` before.

```
var logger = require('mag')();

logger.info('my great application is running!');
logger.debug('process pid is %s', process.pid);

//01:27:36.427 <INFORMATIONAL> my great application is running!
//01:27:36.429 <DEBUG> process pid is 29860
```
You get well formatted message with timestamp.

If you need to visually separate the messages from different sources, use the namespace of `mag`.

```
var mag = require('mag');

var logger = mag('my-app');
var libLogger = mag('my-lib');

logger.info('my great application is running');
libLogger.debug('my library is running too');

//22:36:24.245 [my-app] <INFORMATIONAL> my great application is running
//22:36:24.246 [my-lib] <DEBUG> my library is running too
```

### For application developers

If you're thinking about formatting the output messages of your application, just require `mag-hub` before all `mag` requires.

[mag-hub](https://github.com/mahnunchik/mag-hub) is passthrough stream. If you require `mag-hub` then all log objects will be written to this stream. You can read from this stream and make any transformation with your messages before writing them to stdout.

```
var hub = require('mag-hub');

// Formatters
var info = require('mag-process-info');
var format = require('mag-format-message');
var colored = require('mag-colored-output');

var myCustomFormatter = require('./my-custom-formatter.js');

hub.pipe(info())
  .pipe(format())
  .pipe(myCustomFormatter())
  .pipe(colored())
  .pipe(process.stdout);
```

More information are in [mag-hub](https://github.com/mahnunchik/mag-hub) module.

### For module developers

If you're developing a module and you have something to write to the log, just use the `mag`.
```
var mag = require('mag');
var logger = mag('my-module');

var env = process.env.NODE_ENV || 'development';

logger.info('module is running in %s environment', env);
...
myModule.on('heartbeat', function(){
  logger.debug('heartbeat of module');
});

myModule.on('error', function(){
  logger.critical(new Error('game is over'));
});
```

You must not to worry about the output message format. (In other loggers you have to think about the message format even if you develop a module - it is bad practice)

If users of your module want to format log of the module they can require `mag-hub` in their application and format logs as they want. See previous section [for app developers](https://github.com/mahnunchik/mag#for-application-developers) for more information.

**Warning:** `mag-hub` is designed for use only at the application leyer, do not require it into your modules distributed via npm.


## Features

* support syslog severity levels

## Usage

example.js
```
var logger = require('mag')('example');
logger.info("example message", {meta: "some metadata"});
```

## Configuration

Setting namespace:
```
var mag = require('mag');
var logger = mag('my namespace');

logger.info("example message", {meta: "some metadata"});
```

## License

MIT
