
use std::collections::VecDeque;
use crate::resources;

fn step_population(u: &mut VecDeque<u64>) -> ()  {
    let births = u.pop_front().unwrap();
    u.push_back(births);

    let resets = u.get_mut(6).unwrap();
    *resets += births;
}

fn main()  {
    let mut population: VecDeque<_> = [0u64; 9].into();
    if let Ok(lines) = read_lines("data6.txt")  {
        for line in lines  {
            if let Ok(ip) = line {
                println!("{}", ip);
                for loc in ip.split(",")  {
                    if let Some(v) = population.get_mut(loc.parse::<usize>().unwrap())  {
                        *v += 1;
                    }
                    
                }
            }
        }
    }

    for i in 0..9  {
        println!("{}", population[i]);
    }

    for _ in 0..256  {
        step_population(&mut population);
    }

    for i in 0..9  {
        println!("{}", population[i]);
    }

    println!("{}", population.drain(..).sum::<u64>());
    println!("{}", population.len());
}