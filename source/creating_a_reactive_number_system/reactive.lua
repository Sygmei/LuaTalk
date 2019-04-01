-- This metatable is not "local" because we need the reference from inside it
number_mt = {
    -- Only the add operation is functional
    -- If we wanted a true reactive number system
    --  we would had to add all the overloads
    __add = function(lhs, rhs)
        -- We create a new table which contain a single function
        --  that calculates its value based on the sum of its two parameters
        local new_number = {
            value = function()
                return lhs.value() + rhs.value();
            end
        };
        -- This is the place we needed the reference to 'number_mt'
        setmetatable(new_number, number_mt);
        -- We return the newly created 'number'
        return new_number;
    end,
    -- Overriding string representation of the object
    __tostring = function(self)
        return self.value();
    end
}
local wrap_mt = {
    -- We have to create a table to store the values
    -- We can't store it directly in the table because
    --  we need to keep the callback to __newindex working
    -- If we didn't do that, we wouldn't be modified when a variable's value is changed
    store = {},
    -- __newindex is called when we set a value to a non-existing variable
    __newindex = function(tbl, key, value)
        -- We get a reference to the metatable of 'tbl'
        local mt = getmetatable(tbl);
        -- If the newly created variable is a number
        if type(value) == "number" then
            -- If a variable named the same is already a reactive number
            if getmetatable(rawget(mt.store, key)) == number_mt then
                -- We just update its value function
                rawget(mt.store, key).value = function()
                    return value;
                end;
            else
                -- Otherwise, it's a new variable, we create it from scratch
                local new_number = {
                    -- The value attribute is just a function that capture its up-value 'value'
                    value = function()
                        return value;
                    end
                };
                -- We set the metatable 'number_mt' to the newly created reactive number
                setmetatable(new_number, number_mt);
                -- We store the reactive number to the 'store' table
                mt.store[key] = new_number;
            end
        else
            -- Otherwise if it's not a number, we store it to the 'store' table without modifying it
            mt.store[key] = value;
        end
    end,
    __index = function(tbl, key)
        -- We get the data from 'store' table
        return getmetatable(tbl).store[key];
    end
}

-- We set a metatable to the global table
setmetatable(_G, wrap_mt)

-- The original reactive number example (thanks @Uriopass)
a = 3
b = 5
c = a + b
print(c) -- Should print 8
a = 7
print(c) -- Should print 12