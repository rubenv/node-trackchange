assert = require 'assert'

ChangeTracker = require '..'

describe 'Dirty', ->
    obj = null
    beforeEach () ->
        orig = {
            test: 123
            method: () -> return 321
            deep:
                test: 456
                method: () -> return 654
        }
        obj = ChangeTracker.create(orig)

    it 'Tracks dirty members', ->
        obj.test = 456
        assert.deepEqual(obj._dirty, ['test'])

    it 'Tracks dirty members (deep)', ->
        obj.deep.test = 789
        assert.deepEqual(obj._dirty, ['deep'])
