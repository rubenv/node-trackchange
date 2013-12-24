class ChangeTracker
    @create: (obj) ->
        return Proxy.create(new ChangeTracker(obj))

    constructor: (@obj) ->
        @_dirty = []

    get: (proxy, name) ->
        return @_dirty if name == '_dirty'
        val = @obj[name]
        if typeof val == 'object'
            val = ChildChangeTracker.create(val, @, name)
        return val

    set: (proxy, name, value) ->
        @markDirty(name)
        return @obj[name] = value

    markDirty: (field) ->
        @_dirty.push(field) if field not in @_dirty

class ChildChangeTracker
    @create: (obj, parent, field) ->
        return Proxy.create(new ChildChangeTracker(obj, parent, field))

    constructor: (@obj, @parent, @field) ->

    get: (proxy, name) ->
        val = @obj[name]
        if typeof val == 'object'
            val = ChildChangeTracker.create(val, @parent, @field)
        return val

    set: (proxy, name, value) ->
        @parent.markDirty(@field)
        return @obj[name] = value

module.exports = ChangeTracker
