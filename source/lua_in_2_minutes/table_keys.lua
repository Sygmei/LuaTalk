local temp_table = {};
local temp_func = function() end
local my_table = {
    [1] = "this is a number index",
    ["this is"] = "a string index",
    [true] = "this is a boolean index",
    [temp_table] = "even a table as index works",
    [temp_func] = "anything can be used as an index actually"
}
print(my_table[1])
print(my_table["this is"])
print(my_table[true])
print(my_table[temp_table])
print(my_table[temp_func])

my_table[true] = false;

print(my_table[true])