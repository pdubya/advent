
use std::path::PathBuf;
use std::fs::File;
use std::path::Path;
use std::io::{self, BufRead};

pub fn read_lines<P>(fname: P) -> io::Result<io::Lines<io::BufReader<File>>>  
where P: AsRef<Path>, {
    let mut d = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    d.push(Path::new("resources").join(fname));
    println!("{}", d.display());
    let file = File::open(d)?;
    Ok(io::BufReader::new(file).lines())
}