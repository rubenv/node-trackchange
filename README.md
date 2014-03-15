# trackchange 

> Transparent change-tracking using Harmony Proxies.

[![Build Status](https://travis-ci.org/rubenv/node-trackchange.png?branch=master)](https://travis-ci.org/rubenv/node-trackchange)

## Usage
Add trackchange to your project:

### Installation (Node.JS)
```
npm install --save trackchange
```

Reference it in your code:

```js
var ChangeTracker = require('trackchange');
```

### Running
Be sure to run node with the `--harmony` flag.

```
node --harmony myscript.js
```

### Using in code

```js
var orig = {
  test: 123
};
 
// Create a wrapper that tracks changes.
var obj = ChangeTracker.create(orig);
 
// No changes initially:
console.log(obj.__dirty); // -> []
 
// Do things
orig.test = 1;
orig.other = true;
 
// Magical change tracking!
console.log(obj.__dirty); // -> ['test', 'other']
```

You can even wrap constructors. This ensures that each created instance automatically has change tracking built-in:

```js
var TestType = ChangeTracker.createWrapper(OrigType);
 
var obj = new TestType();
console.log(obj.__dirty);
```

## License 

    (The MIT License)

    Copyright (C) 2014 by Ruben Vermeersch <ruben@rocketeer.be>

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
