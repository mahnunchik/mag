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

//01:27:36.427 <INFO> my great application is running!
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

//22:36:24.245 [my-app] <INFO> my great application is running
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

## Motivation

TODO

* You do not have to configure the output if you develop a module
* You can do anything with the output if you develop an application

## How does it work?

Specification of internal messages format can be found here: [SPEC.md](https://github.com/mahnunchik/mag-logger-facade/blob/master/SPEC.md)

* [mag-logger-facade](https://github.com/mahnunchik/mag-logger-facade)
* [mag-stream](https://github.com/mahnunchik/mag-stream)
* [mag-hub](https://github.com/mahnunchik/mag-hub)
* [mag-fallback](https://github.com/mahnunchik/mag-fallback)


## Examples

You can find examples of using `mag` logger in this reposiory: [mag-examples](https://github.com/mahnunchik/mag-examples).

There are following branches:

* [simple](https://github.com/mahnunchik/mag-examples/tree/simple) - simplest replacement of console
* [module](https://github.com/mahnunchik/mag-examples/tree/module) - module using mag as logger
* [app](https://github.com/mahnunchik/mag-examples/tree/app) - example of application that uses the module above
* [app-formatted-output](https://github.com/mahnunchik/mag-examples/tree/app-formatted-output) - mag-hub, log levels, and collored output (full example of mag power)


## Ideology

A brief interpretation of [The Twelve-Factor App - Logs section](http://12factor.net/logs):

* Log is the stream of time-ordered events.
* App never concerns itself with routing or storage of its output stream.
* App should not attempt to write to or manage logfiles.
* App should write its event stream, unbuffered, to stdout.

## License

[MIT](https://github.com/mahnunchik/mag/blob/master/LICENSE)
