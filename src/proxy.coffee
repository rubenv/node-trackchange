class Person
    constructor: (@firstname, @lastname) ->

class ChangeTrackingProxy
    constructor: (@obj) ->
        @_dirty = []

    get: (proxy, name) ->
        return @_dirty if name == '_dirty'
        return @obj[name]

    set: (proxy, name, value) ->
        @_dirty.push(name) if name not in @_dirty
        return @obj[name] = value

    getOwnPropertyNames: () ->
        return Object.getOwnPropertyNames(@obj)

    getOwnPropertyDescriptor: (name) ->
        return Object.getOwnPropertyDescriptor(@obj, name)

origPerson = new Person('Ruben', 'Vermeersch')

person = Proxy.create(new ChangeTrackingProxy(origPerson))

console.log person.firstname
person.email = 'ruben@rocketeer.be'
console.log person
console.log person._dirty
