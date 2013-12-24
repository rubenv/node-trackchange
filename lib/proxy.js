var ChangeTrackingProxy, Person, origPerson, person,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

Person = (function() {
  function Person(firstname, lastname) {
    this.firstname = firstname;
    this.lastname = lastname;
  }

  return Person;

})();

ChangeTrackingProxy = (function() {
  function ChangeTrackingProxy(obj) {
    this.obj = obj;
    this._dirty = [];
  }

  ChangeTrackingProxy.prototype.get = function(proxy, name) {
    if (name === '_dirty') {
      return this._dirty;
    }
    return this.obj[name];
  };

  ChangeTrackingProxy.prototype.set = function(proxy, name, value) {
    if (__indexOf.call(this._dirty, name) < 0) {
      this._dirty.push(name);
    }
    return this.obj[name] = value;
  };

  ChangeTrackingProxy.prototype.getOwnPropertyNames = function() {
    return Object.getOwnPropertyNames(this.obj);
  };

  ChangeTrackingProxy.prototype.getOwnPropertyDescriptor = function(name) {
    return Object.getOwnPropertyDescriptor(this.obj, name);
  };

  return ChangeTrackingProxy;

})();

origPerson = new Person('Ruben', 'Vermeersch');

person = Proxy.create(new ChangeTrackingProxy(origPerson));

console.log(person.firstname);

person.email = 'ruben@rocketeer.be';

console.log(person);

console.log(person._dirty);
