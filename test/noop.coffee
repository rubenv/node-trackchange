assert = require 'assert'

ChangeTracker = require '..'

describe 'Noop', ->
    orig = {
        test: 123
        method: () -> return 321
        deep:
            test: 456
            method: () -> return 654
    }
    obj = ChangeTracker.create(orig)

    it 'Passes through get calls', ->
        assert.equal(obj.test, 123)

    it 'Passes through get calls (deep)', ->
        assert.equal(obj.deep.test, 456)

    it 'Passes through function calls', ->
        assert.equal(obj.method(), 321)

    it 'Passes through function calls (deep)', ->
        assert.equal(obj.deep.method(), 654)

    it 'Passes through set calls', ->
        obj.test = 789
        assert.equal(obj.test, 789)

    it 'Passes through set calls (deep)', ->
        obj.deep.test = 678
        assert.equal(obj.deep.test, 678)

    it 'Can still enumerate properties'
