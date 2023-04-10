def get_value_from_key(obj, key):
    keys = key.split('/')
    val = obj
    for k in keys:
        val = val.get(k)
        if val is None:
            return None
    return val


# Example 1
obj1 = {"a": {"b": {"c": "d"}}}
key1 = "a/b/c"
result1 = get_value_from_key(obj1, key1)
print(result1)  # Output: d

# Example 2
obj2 = {"x": {"y": {"z": "a"}}}
key2 = "x/y/z"
result2 = get_value_from_key(obj2, key2)
print(result2)  # Output: a

# Example 3
obj2 = {"x": {"y": {"z": "a"}}}
key2 = "x/y/d"
result2 = get_value_from_key(obj2, key2)
print(result2)  # Output: none
