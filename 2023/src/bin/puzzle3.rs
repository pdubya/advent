
mod resources;
use std::collections::HashSet;

fn priority(c: char) -> i32 {
    assert!(c.is_ascii_alphabetic());
    let r: (u8, i32) = if c.is_ascii_uppercase() {(b'A', 27)} else {(b'a', 1)};
    (c as u8 - r.0) as i32 + r.1
}

fn score1(s: &str) -> i32  {
    let r = s.len()/2;
    let mut h = HashSet::new();
    for c in s[r..].chars()  {
        h.insert(c);
    }
    for c in s[0..r].chars()  {
        if h.contains(&c)  {
            return priority(c);
        }
    }
    unreachable!();
}


fn main()  {
    assert!(priority('c') == 3);
    assert!(priority('C') == 29);

    let mut sum1 = 0i32;
    let mut sum2 = 0i32;
    if let Ok(mut lines) = resources::read_lines("data3.txt")  {
        loop  {
            if let Some(line) = lines.next()  {
                let z = line.unwrap().clone();
                sum1 += score1(&z);


                let mut s = HashSet::new();
                z.chars().for_each(|c| {s.insert(c);});
                
                for _ in 1..3  {
                    let z_next = lines.next().unwrap().unwrap();
                    sum1 += score1(&z_next);
                    let mut s_next = HashSet::new();
                    z_next.chars().for_each(|c| {s_next.insert(c);});
                    s = &s & &s_next;
                }
                assert!(s.len() == 1);
                sum2 += priority(*s.iter().last().unwrap());
            } else  {
                break;
            }
        }

        println!("{}, {}", sum1, sum2);
    }
}
