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

    it 'Can access original object', ->
        obj = {}
        wrapped = ChangeTracker.create(obj)
        assert.strictEqual(obj, wrapped.__obj)

    it 'Can access the tracker', ->
        obj = {}
        wrapped = ChangeTracker.create(obj)
        assert.strictEqual(obj, wrapped.__tracker.obj)

    it 'Tracker has a resetDirty method', ->
        wrapped = ChangeTracker.create({})
        assert.equal(typeof wrapped.__tracker.resetDirty, 'function')

    it 'Tracker has a resetNew method', ->
        wrapped = ChangeTracker.create({})
        assert.equal(typeof wrapped.__tracker.resetNew, 'function')

    it 'Objects are not marked as new by default', ->
        wrapped = ChangeTracker.create({})
        assert.equal(wrapped.__tracker.new, false)
