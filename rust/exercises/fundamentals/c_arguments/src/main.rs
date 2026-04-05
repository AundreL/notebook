use clap::{Parser, Subcommand};

#[derive(Parser)]
#[command(version, about, long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Option<Commands>,
}

#[derive(Subcommand)]
enum Commands {
    CommandA {
        #[arg(short, long)]
        name: String,
    },
}

fn main() {}

#[cfg(test)]
mod tests {
    use super::*;
    use clap::Parser;

    #[test]
    fn test_name() {
        let args = vec!["my_prog", "command-a", "--name", "John"];
        let cli = Cli::try_parse_from(args).unwrap();

        match &cli.command {
            Some(Commands::CommandA { name }) => {
                println!("name");
            }
            None => {}
        }
    }
}
