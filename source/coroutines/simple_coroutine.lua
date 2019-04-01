local function ma_fonction()
    print("Etape 3 - Debut de la coroutine")
    local msg = coroutine.yield("Valeur envoyee depuis coroutine");
    print("Etape 5 -", msg)
end

print("Etape 1 - Creation de la coroutine");
coro = coroutine.create(ma_fonction);
print("Etape 2 - Lancement de la coroutine");
ok, msg = coroutine.resume(coro);
print("Etape 4 -", msg)
ok, msg = coroutine.resume(coro, "Valeur envoyee depuis le main");