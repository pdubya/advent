
use std::collections::BinaryHeap;
use std::cmp::Reverse;
mod resources;

fn main()  {
    let mut best = BinaryHeap::from([Reverse(0i32), Reverse(0i32), Reverse(0i32)]);
    let mut current = 0i32;
    let mut chunk = 0i32;
    if let Ok(lines) = resources::read_lines("data1.txt")  {
        for line in lines  {
            if let Ok(v) = &line.unwrap().parse::<i32>()  {
                current += v;
            } else  {
                chunk += 1;
                if Reverse(current) < *best.peek().unwrap()  {
                    best.pop();
                    best.push(Reverse(current));
                    println!("insert {} from chunk {}", current, chunk)
                }
                current = 0;
            }
        }
        println!("{}", best.drain().map(|u| u.0).sum::<i32>());

        println!("read {} chunks", chunk);
    }
        
}

