struct Worker {
    name: String,
    id: u32,
    handler: fn(i32) -> i32,
}

fn double(x: i32) -> i32 {
    x * 2
}

fn square(x: i32) -> i32 {
    x * x
}

fn main() {}

fn add(a: i32, b: i32) -> i32 {
    a + b
}

struct Window {
    width: u32,
    height: u32,
}

impl Window {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

fn take_ownership(string_in: String) {
    println!("takes ownership of string_in: {}", string_in)
}

fn take_ref(string_in: &String) {
    println!("borrows string_in: {}", string_in);
}

fn modify_ref(string_in: &mut String) {
    *string_in = String::from("new string value");
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(2, 2), 4);
    }

    #[test]
    fn function_handler() {
        let worker_a = Worker {
            name: String::from("use_1_double"),
            id: 1,
            handler: double,
        };

        let worker_b = Worker {
            name: String::from("use_2_double"),
            id: 2,
            handler: double,
        };

        let worker_c = Worker {
            name: String::from("use_3_square"),
            id: 3,
            handler: square,
        };

        let res_a = (worker_a.handler)(2);
        let res_b = (worker_b.handler)(5);
        let res_c = (worker_c.handler)(6);

        assert_eq!(res_a, 4);
        assert_eq!(worker_a.name, "use_1_double");
        assert_eq!(worker_a.id, 1);
        assert_eq!(res_b, 10);
        assert_eq!(worker_b.name, "use_2_double");
        assert_eq!(worker_b.id, 2);
        assert_eq!(res_c, 36);
        assert_eq!(worker_c.name, "use_3_square");
        assert_eq!(worker_c.id, 3);
    }

    #[test]
    fn window_area() {
        let window = Window {
            width: 40,
            height: 100,
        };

        assert_eq!(window.area(), 4000);
    }

    #[test]
    fn ownership_test() {
        let string_in = String::from("test string");

        //move ownership to function
        take_ownership(string_in);

        //compiler error: borrow of moved value: `string_in`
        //println!("{}", string_in):
    }
    #[test]
    fn borrow_test() {
        let string_in = String::from("test string");

        take_ref(&string_in);

        //should be able to string use
        assert_eq!(string_in, "test string");
        assert_ne!(string_in, "should fail");
    }
    #[test]
    fn modify_test() {
        let mut string_in = String::from("test string");

        assert_eq!(string_in, "test string");
        modify_ref(&mut string_in);
        assert_eq!(string_in, "new string value");
    }
}
