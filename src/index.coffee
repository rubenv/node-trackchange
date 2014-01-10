class ChangeTracker
    @create: (obj, isNew = false) ->
        return Proxy.create(new RootChangeTracker(obj, isNew))

    @createWrapper: (type) ->
        return () ->
            newObj = Object.create(type.prototype)
            wrapped = ChangeTracker.create(newObj, true)
            type.apply(wrapped, arguments)
            return wrapped

    constructor: (@obj) ->

    getOwnPropertyNames: () ->
        return Object.getOwnPropertyNames(@obj)

    getOwnPropertyDescriptor: (name) ->
        return Object.getOwnPropertyDescriptor(@obj, name)

    set: (proxy, name, value) ->
        @markDirty(name)
        return @obj[name] = value

class RootChangeTracker extends ChangeTracker
    constructor: (obj, isNew) ->
        super(obj)
        @dirty = []
        @new = isNew

    get: (proxy, name) ->
        return @dirty if name == '__dirty'
        return @obj if name == '__obj'
        return @ if name == '__tracker'
        val = @obj[name]
        if typeof val == 'object'
            val = ChildChangeTracker.create(val, @, name)
        return val

    markDirty: (field) ->
        @dirty.push(field) if field not in @dirty

    resetDirty: () ->
        @dirty = []

    resetNew: () ->
        @new = false

class ChildChangeTracker extends ChangeTracker
    @create: (obj, parent, field) ->
        return Proxy.create(new ChildChangeTracker(obj, parent, field))

    constructor: (obj, @parent, @field) ->
        super(obj)

    get: (proxy, name) ->
        val = @obj[name]
        if typeof val == 'object'
            val = ChildChangeTracker.create(val, @parent, @field)
        return val

    markDirty: () ->
        @parent.markDirty(@field)

module.exports = ChangeTracker
