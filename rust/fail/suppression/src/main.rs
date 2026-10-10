#[allow(clippy::cast_lossless)]
fn main() {
    let small: u32 = 42;
    let large = small as u64;
    println!("Hello, world! {large}");
}
