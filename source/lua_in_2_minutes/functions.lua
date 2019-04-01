function simple_function()
    print("Hello");
end

function function_with_args(a, b)
    return a + b;
end

function function_with_variadic_args(...)
    -- ... is a special thing in Lua
    -- it will act like if it replaced the ... with the args
    -- In this example "local a = ..." would be equivalent to
    -- "local a = 1, 2, 3, 4" meaning "a" would be equal to 1
    return { x = { ... } };
end

simple_function(); -- Calling a function without args
local x = function_with_args(11, 22);
local y = function_with_variadic_args(1, 2, 3, 4);
print(x, y.x[4]);