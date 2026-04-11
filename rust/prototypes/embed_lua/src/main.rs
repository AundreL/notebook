use mlua::prelude::*;

fn main() -> LuaResult<()> {
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::fs::File;
    use std::io::prelude::*;

    #[test]
    fn test_one() -> LuaResult<()> {
        let lua = Lua::new();
        let from_rust_int: i32 = 12;

        lua.globals().set("from_rust_int", from_rust_int)?;

        lua.load("from_lua_int = 21").exec()?;
        let from_lua_int: i32 = lua.globals().get("from_lua_int")?;

        assert_eq!(from_rust_int, 12);

        lua.load("bind_check = from_rust_int").exec()?;
        let mut bind_check: i32 = lua.globals().get("bind_check")?;

        assert_eq!(from_rust_int, 12);
        assert_eq!(bind_check, 12);
        assert_eq!(from_lua_int, 21);

        lua.load("bind_check = 110").exec()?;
        assert_eq!(bind_check, 12);

        bind_check = lua.globals().get("bind_check")?;
        assert_eq!(bind_check, 110);

        Ok(())
    }

    #[test]
    fn get_values_from_file() -> LuaResult<()> {
        let lua = Lua::new();
        let mut file = match File::open("test/default_values.lua") {
            Err(why) => panic!("coudln't open default_values: {}", why),
            Ok(file) => file,
        };

        let mut config = String::new();
        match file.read_to_string(&mut config) {
            Ok(_) => {}
            Err(why) => panic!("could not read config file: {}", why),
        };

        match lua.load(config).exec() {
            Ok(_) => {}
            Err(why) => panic!(
                "critical error during testing unable to load config to lua: {}",
                why
            ),
        };

        let option_a: i32 = match lua.globals().get("option_a") {
            Ok(value) => value,
            Err(why) => panic!("critical error getting value: {}", why),
        };

        let option_b: i32 = match lua.globals().get("option_b") {
            Ok(value) => value,
            Err(why) => panic!("critical error getting value: {}", why),
        };

        let option_c: i32 = match lua.globals().get("option_c") {
            Ok(value) => value,
            Err(why) => panic!("critical error getting value: {}", why),
        };

        assert_eq!(option_a, 12);
        assert_eq!(option_b, 1000);
        assert_eq!(option_c, 130);

        Ok(())
    }
}
