# rescript-ms

Reimplementation of [ms](https://github.com/vercel/ms) in [ReScript](https://rescript-lang.org).

## Installation

```shell
# yarn
yarn add rescript-ms

# or npm
npm install --save rescript-ms
```

Then add `rescript-validator` to your `bsconfig.json`'s `bs-dependencies`:

```json
"bs-dependencies": [
  "rescript-ms"
]
```

## Usage

```js
Ms.parse('2 days'); // 172800000
Ms.parse('1d'); // 86400000
Ms.parse('10h'); // 36000000
Ms.parse('2.5 hrs'); // 9000000
Ms.parse('2h'); // 7200000
Ms.parse('1m'); // 60000
Ms.parse('5s'); // 5000
Ms.parse('1y'); // 31557600000
Ms.parse('100'); // 100
Ms.parse('-3 days'); // -259200000
Ms.parse('-1h'); // -3600000
Ms.parse('-200'); // -200

Ms.format(60000); // "1m"
Ms.format(2 * 60000); // "2m"
Ms.format(-3 * 60000); // "-3m"
```
