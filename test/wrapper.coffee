assert = require 'assert'

ChangeTracker = require '..'

describe 'Wrapper', ->
    obj = null
    obj2 = null

    class TestType
        constructor: () ->
            @initial = true

        test: () ->
            @field = true

        @static: () ->

    TestType2 = ChangeTracker.createWrapper(TestType)
        
    beforeEach () ->
        obj = new TestType()
        obj2 = new TestType2()

    it 'Can construct a wrapped type', ->
        assert.equal(typeof obj2, 'object')

    it 'Has the same prototype', ->
        assert.equal(obj2.prototype, obj.prototype)

    it 'Has the same constructor', ->
        assert.equal(obj.constructor.name, 'TestType')
        assert.equal(obj2.constructor.name, 'TestType')

    it 'Has the same interface', ->
        assert.equal(obj.test, obj2.test)
        assert.equal(typeof obj.test, 'function')

    it 'Can call members', ->
        assert.equal(obj.field, undefined)
        obj.test()
        assert.equal(obj.field, true)

        assert.equal(obj2.field, undefined)
        obj2.test()
        assert.equal(obj2.field, true)

    it 'Tracks changes', ->
        obj.test()
        assert.equal(obj.__dirty, undefined)
        
        assert.deepEqual(obj2.__dirty, ['initial'])
        obj2.test()
        assert.deepEqual(obj2.__dirty, ['initial', 'field'])

    it 'Tracks changes in constructor', ->
        assert.deepEqual(obj2.__dirty, ['initial'])

    it 'Objects created through the wrapper are marked as new', ->
        assert.equal(obj2.__tracker.new, true)

    it 'Has a static method', ->
        assert.equal(typeof TestType.static, 'function')
        assert.equal(typeof TestType2.static, 'function')
        assert.equal(TestType2.static, TestType.static)

    it 'Preserves the name property on the class', ->
        assert.equal(TestType.name, 'TestType')
        assert.equal(TestType2.name, 'TestType')

    it 'Can hook into object creation', ->
        calls = 0
        TestType2 = ChangeTracker.createWrapper TestType, (obj) ->
            assert.equal(typeof obj, 'object')
            calls++

        assert.equal(calls, 0)
        obj = new TestType2()
        assert.equal(calls, 1)
