# mag

tiny logger for nodejs supports [logstash's internal message format](https://github.com/logstash/logstash/wiki/logstash's-internal-message-format)

## Installation

```
$ npm install mag
```

## Features

* coloured console logging
* logstash's internal format file logging
* usage only process.stdout output
* support syslog log levels

## Usage

example.js
```
var logger = require('mag')('example');
logger.info("example message", {meta: "some metadata"});
```

Simple console output:
```
$ node example/example.js 
12:38:40 mahnunchik-desktop example[20150]: <INFO> example message { meta: 'some metadata' }
```

File log:
```
$ node example/example.js > example.log
$ cat example.log 
{"@timestamp":"2013-05-23T06:09:26.780Z","@tags":["example","20879","INFO"],"@source":"mahnunchik-desktop example[20879]","@message":"example message { meta: 'some metadata' }","@fields":{"level":6,"levelName":"INFO"}}
```

## License

(The MIT License)

Copyright (c) 2013 Eugeny Vlasenko <mahnunchik@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

