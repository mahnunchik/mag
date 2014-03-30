# mag

Logger for NodeJS

## Installation

```
$ npm install mag
```

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
