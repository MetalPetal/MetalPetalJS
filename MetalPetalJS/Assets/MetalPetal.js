
function MTINativeFilter(name) {
    var filter = MTIJSNativeFilter.filterWithName(name);
    var proxy = new Proxy(filter, {
        get(target, propertyKey, receiver) {
            return target[propertyKey] || target.valueForPropertyKey(propertyKey) || undefined;
        },
        set(target, propertyKey, value, receiver) {
            if (propertyKey in target) {
                return false
            } else {
                return target.setValueForPropertyKey(value, propertyKey);
            }
        }
    });
    return proxy;
}
