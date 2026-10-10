#[derive(Debug)]
struct ApiToken(String);

fn main() {
    let token = ApiToken("hello".to_owned());
    println!("Hello, world! {} {token:?}", token.0.len());
}
