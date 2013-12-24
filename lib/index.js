var ChangeTracker, ChildChangeTracker,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

ChangeTracker = (function() {
  ChangeTracker.create = function(obj) {
    return Proxy.create(new ChangeTracker(obj));
  };

  function ChangeTracker(obj) {
    this.obj = obj;
    this._dirty = [];
  }

  ChangeTracker.prototype.get = function(proxy, name) {
    var val;
    if (name === '_dirty') {
      return this._dirty;
    }
    val = this.obj[name];
    if (typeof val === 'object') {
      val = ChildChangeTracker.create(val, this, name);
    }
    return val;
  };

  ChangeTracker.prototype.set = function(proxy, name, value) {
    this.markDirty(name);
    return this.obj[name] = value;
  };

  ChangeTracker.prototype.markDirty = function(field) {
    if (__indexOf.call(this._dirty, field) < 0) {
      return this._dirty.push(field);
    }
  };

  return ChangeTracker;

})();

ChildChangeTracker = (function() {
  ChildChangeTracker.create = function(obj, parent, field) {
    return Proxy.create(new ChildChangeTracker(obj, parent, field));
  };

  function ChildChangeTracker(obj, parent, field) {
    this.obj = obj;
    this.parent = parent;
    this.field = field;
  }

  ChildChangeTracker.prototype.get = function(proxy, name) {
    var val;
    val = this.obj[name];
    if (typeof val === 'object') {
      val = ChildChangeTracker.create(val, this.parent, this.field);
    }
    return val;
  };

  ChildChangeTracker.prototype.set = function(proxy, name, value) {
    this.parent.markDirty(this.field);
    return this.obj[name] = value;
  };

  return ChildChangeTracker;

})();

module.exports = ChangeTracker;
