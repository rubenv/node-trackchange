assert = require 'assert'

ChangeTracker = require '..'

describe 'Interface', ->
    it 'Exports an object', ->
        assert.notEqual(ChangeTracker, null)
        assert.equal(typeof ChangeTracker, 'function')

    it 'Has a create method', ->
        assert.notEqual(ChangeTracker.create, null)
        assert.equal(typeof ChangeTracker.create, 'function')

    it 'Creating a change tracker returns an object', ->
        assert.equal(typeof ChangeTracker.create({}), 'object')
