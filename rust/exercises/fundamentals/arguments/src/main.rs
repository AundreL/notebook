use clap::Parser;

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    #[arg(short, long)]
    name: String,
    #[arg(short, long, default_value_t = 1)]
    count: u8,
}

fn main() {
    let args = Args::parse();

    for _ in 0..args.count {
        println!("Hello {}!", args.name)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use clap::Parser;

    #[test]
    fn test_name() {
        let args = vec!["my_prog", "--name", "John", "--count", "5"];
        let res = Args::try_parse_from(args);

        assert!(res.is_ok());
        let parsed = res.unwrap();

        assert_eq!(parsed.name, "John");
        assert_eq!(parsed.count, 5);
    }

    #[test]
    fn test_name_default_count() {
        let args = vec!["my_prog", "--name", "John"];
        let res = Args::try_parse_from(args);

        assert!(res.is_ok());
        let parsed = res.unwrap();

        assert_eq!(parsed.name, "John");
        assert_eq!(parsed.count, 1);
    }
}
