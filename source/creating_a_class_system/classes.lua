function class(table_definition)
    local class_mt = {
        __call = function(self, ...) -- Overriding () operator
            local object = {};
            for k, v in pairs(self) do
                object[k] = v; -- Copying all attributes to instance
            end
            object:new(...); -- Calling constructor
            return object; -- Returning the newly created object
        end
    }
    local class_table = {};
    -- Copying all attributes to the new class
    for k, v in pairs(table_definition) do
        class_table[k] = v;
    end
    -- We set a metatable to the newly created class
    setmetatable(class_table, class_mt); 
    -- We return the result
    return class_table;
end

-- class is a function but we don't need parenthesis when the only parameter is a table / string
local Animal = class {
    GROUND = "ground", SEA = "sea", AIR = "air", -- Static attributes
    new = function(self, name, terrain) -- Constructor, it could be called anything
        self.name = name;
        self.terrain = terrain;
    end,
    describe = function(self) -- A method, we have 'self' as first argument
        print("I'm a", self.name, "and I live in the", self.terrain);
    end
}

local worm = Animal("Worm", Animal.GROUND); -- Calling class_mt's () operator
local dolphin = Animal("Dolphin", Animal.SEA);
local seagull = Animal("Seagull", Animal.AIR);
worm:describe(); -- ":" is just syntaxic sugar for object.method(object)
dolphin:describe();
seagull:describe();