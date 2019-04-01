local const_mt = {
    -- We have to create a table to store the values
    -- We can't store it directly in the table because
    --  we need to keep the callback to __newindex working
    -- If we didn't do that, we wouldn't be modified when a variable's value is changed
    store = {},
    -- A table that will keep all keys that holds values that shouldn't be modified
    const_keys = {},
    -- __newindex is called when we set a value to a non-existing variable
    __newindex = function(tbl, key, value)
        -- If the 'const_keys' table already contains the key
        if getmetatable(tbl).const_keys[key] then
            -- We display an error
            error(tostring(key) .. " is immutable !");
        end
        -- If the value is a table that contains the flag __const
        if type(value) == "table" and value.__const then
            -- We add the key to 'const_keys'
            getmetatable(tbl).const_keys[key] = true;
            -- We extract the real value from the table
            value = value.value;
        end
        -- We store the value 'value' at index 'key' in the 'store' table of the metatable of the table 'tbl'
        getmetatable(tbl).store[key] = value;
    end,
    -- __index is called when we try to access a value
    __index = function(tbl, key)
        -- We retrieve the value at index 'key' in the 'store' table of the metatable of the table 'tbl'
        -- Don't sleep yet ! There's more :)
        return getmetatable(tbl).store[key]; 
    end
}

-- const is a just a function that wraps all values of the table passed as parameter
-- It will then place the newly created wrapped object in the global table _G
function const(tbl)
    for key, value in pairs(tbl) do -- For all values in tbl
        _G[key] = {
            __const = true, -- __const is not a standard attribute, it is here used as a flag
            value = value -- Inserting value in the table
        };
    end
end

-- We set a metatable to the global table
setmetatable(_G, const_mt);

-- Usage
const { a = 3 }; -- const is a function that takes a single table
print("a is", a); -- Should print "a is 3"
a = 10; -- Should raise an error