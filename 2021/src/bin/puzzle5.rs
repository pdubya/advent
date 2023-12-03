use std::path::PathBuf;
use std::fs::File;
use std::path::Path;
use std::io::{self, BufRead};
use std::collections::HashMap;
use std::cmp::{Eq, max, min};


#[derive(PartialEq, Eq, Hash, Clone)]
struct Point {x: u32, y: u32}

fn segment_points(p1: &Point, p2: &Point) -> Vec<Point> {
    let cnt: u32 = 1 + max(max(p1.x, p2.x) - min(p1.x, p2.x),
                           max(p1.y, p2.y) - min(p1.y, p2.y));

    let xs = if p2.x > p1.x  {
        (p1.x..=p2.x).collect::<Vec<_>>()
    } else if p1.x > p2.x  {
        (p2.x..=p1.x).rev().collect::<Vec<_>>()
    } else  {
        vec![p1.x; cnt as usize]
    };

    let ys = if p2.y > p1.y  {
        (p1.y..=p2.y).collect::<Vec<_>>()
    } else if p1.y > p2.y  {
        (p2.y..=p1.y).rev().collect::<Vec<_>>()
    } else  {
        vec![p1.y; cnt as usize]
    };

    // Point constructor is gross, should all be ref or value
    xs.iter().zip(ys).map(|(x,y)| Point{x: *x, y: y}).collect::<Vec<Point>>()
}

fn read_segment(u: &str) -> Result<(Point, Point), &'static str>  {
    fn make_point(v: &str) -> Result<Point, &'static str> {
        let coords = v.split(",").collect::<Vec<&str>>();
        match coords.len()  {
            2 => Ok(Point{x: coords[0].parse::<u32>().unwrap(), y: coords[1].parse::<u32>().unwrap()}),
            _ => Err("coordinates has wrong length")
        }
    }
    let els = u.split(" -> ").collect::<Vec<&str>>();
    match els.len()  {
        2 => Ok((make_point(els[0])?, make_point(els[1])?)),
        _ => Err("found more than two points")
    }
}


fn read_lines<P>(fname: P) -> io::Result<io::Lines<io::BufReader<File>>>  
where P: AsRef<Path>, {
    let mut d = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    d.push(Path::new("resources").join(fname));
    println!("{}", d.display());
    let file = File::open(d)?;
    Ok(io::BufReader::new(file).lines())
}

fn main() {
    let mut h: HashMap<Point, u32> = HashMap::new();
    if let Ok(lines) = read_lines("data5.txt")  {
        for line in lines  {
            if let Ok(ip) = line {
                let (p1, p2) = read_segment(&ip).unwrap();
                for pt in segment_points(&p1, &p2)  {
                    match h.get_mut(&pt)  {
                        Some(t) => *t += 1,
                        None => _ = h.insert(pt, 1)
                    }
                }
            }
        }
    }
    println!("{}", h.len());
    let cnt = h.into_values().fold(0, |v, el| if el > 1 {v + 1} else {v});
    println!("{}", cnt)

}
