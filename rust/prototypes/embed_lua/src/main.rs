use mlua::prelude::*;

fn main() -> LuaResult<()> {
    let lua = Lua::new();
    let map_table = lua.create_table()?;
    map_table.set(1, "one")?;
    map_table.set("two", 2)?;
    lua.globals().set("map_table", map_table)?;
    lua.load("for k,v in pairs(map_table) do print(k,v) end")
        .exec()?;

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_one() -> LuaResult<()> {
        let lua = Lua::new();
        let from_rust_int: i32 = 12;

        //1. create and set value of variable in lua instance using a rust variable
        lua.globals().set("from_rust_int", from_rust_int)?;

        //2. create integer in lua instance and initialize with in same instance
        lua.load("from_lua_int = 21").exec()?;
        let from_lua_int: i32 = lua.globals().get("from_lua_int")?;

        assert_eq!(from_rust_int, 12);

        //3. create variable to hold value of from_rust_int variable
        lua.load("bind_check = from_rust_int").exec()?;
        let mut bind_check: i32 = lua.globals().get("bind_check")?;

        //4. assert from_rust is still its initialization value
        assert_eq!(from_rust_int, 12);
        //5. assert variable holding lua instance is initialization value
        assert_eq!(bind_check, 12);
        //6. assert that expected value from variable initialization in the lua
        //instance is the value of 21 which it was initialized with.
        assert_eq!(from_lua_int, 21);

        //7. change value of variable that was inlitalized with a value from rust
        lua.load("bind_check = 110").exec()?;
        //8. assert that rust value has not changed before syncing with value in
        //rust from instance
        assert_eq!(bind_check, 12);
        //9. load new value of bind_check from lua and assert that it has changed
        bind_check = lua.globals().get("bind_check")?;
        assert_eq!(bind_check, 110);

        Ok(())
    }
}
