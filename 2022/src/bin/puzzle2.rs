

mod resources;

#[derive(Copy, Clone)]
enum Move  {
    Rock,
    Paper,
    Scissors
}

struct Round(Move, Move);
fn score(r: Round) -> i32  {
    // score for move 1 compared to move 0
    let s0 = match r  {
        Round(Move::Rock, Move::Paper) => 6,
        Round(Move::Rock, Move::Scissors) => 0,
        Round(Move::Paper, Move::Scissors) => 6,
        Round(Move::Paper, Move::Rock) => 0,
        Round(Move::Scissors, Move::Rock) => 6,
        Round(Move::Scissors, Move::Paper) => 0,
        _ => 3
    };
    let s1 = match r.1  {
        Move::Rock => 1,
        Move::Paper => 2,
        Move::Scissors => 3
    };
    s0 + s1
}



fn main()  {
    let mut points = 0i32;
    if let Ok(lines) = resources::read_lines("data2.txt")  {
        for line in lines  {
            let v = line.unwrap();
            let u: Vec<&str> = v.split(" ").collect();
            let m0 = match u[0]  {
                "A" => Move::Rock,
                "B" => Move::Paper,
                "C" => Move::Scissors,
                _ => unreachable!()
            };
            /*
            let m1 = match u[1]  {
                "X" => Move::Rock,
                "Y" => Move::Paper,
                "Z" => Move::Scissors,
                _ => unreachable!()
            };
            */
            let m1 = match (m0, u[1])  {
                (_, "Y") => m0,
                (Move::Rock, "X") => Move::Scissors,
                (Move::Paper, "X") => Move::Rock,
                (Move::Scissors, "X") => Move::Paper,
                (Move::Rock, "Z") => Move::Paper,
                (Move::Paper, "Z") => Move::Scissors,
                (Move::Scissors, "Z") => Move::Rock,
                _ => unreachable!()
            };

            let r = Round(m0, m1);
            points += score(r);
        }
    }
    println!("{}", points);
}
