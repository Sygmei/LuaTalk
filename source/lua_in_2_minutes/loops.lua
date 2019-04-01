local i = 10;
-- while-loop
while i > 0 do
    print(i);
    -- Lua doesn't support decrementing with -- or -= 1
    -- It doesn't support incrementation either
    i = i - 1; 
end

-- for-loop
-- syntax is for <iterator> = <start>, <end>, <step> do
for i = 10, 1, -1 do
    print(i);
end

local i = 10;
-- repeat-loop
-- Will be executed at least once
repeat
    print(i);
    i = i - 1;
until i == 0;