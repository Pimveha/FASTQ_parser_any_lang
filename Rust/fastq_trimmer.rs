use std::fs::File;
use std::io::{BufRead, BufReader};

const THRESHOLD: usize = 500;
const WINDOW_SIZE: usize = 10;

struct Record {
    name: String,
    seq: String,
    qual: Vec<u8>,
}

fn main() {
    let file = File::open("example.fastq").unwrap();
    let reader = BufReader::new(file);

    let mut records = Vec::new();
    let mut current_record = Record {
        name: String::new(),
        seq: String::new(),
        qual: Vec::new(),
    };
    let mut line_num = 0;

    for line in reader.lines() {
        let line = line.unwrap();
        line_num += 1;
        match line_num % 4 {
            1 => {
                // begin van nieuwe record
                if !current_record.name.is_empty() {
                    records.push(current_record);
                }
                current_record = Record {
                    name: line[1..].to_string(),
                    seq: String::new(),
                    qual: Vec::new(),
                };
            }
            2 => {
                current_record.seq = line;
            }
            3 => {
                // negeert nu de dir
            }
            _ => {
                // quality line
                // current_record.qual = line;      original
                current_record.qual = line.as_bytes().to_vec();
            }
        }
    }

    records.push(current_record);

    // print records
    for record in records {
        println!("Name: {}", record.name);
        println!("Seq: {}", record.seq);
        println!("Qual: {:?}", record.qual);
        println!("\n\n");
        // trimmer(record.qual);
        let (lower_bound_index, upper_bound_index) = trimmer(record.qual);
        println!(
            "lower bound index = {}, upper bound index = {}",
            lower_bound_index, upper_bound_index
        );
        // .map(|&x| u32::from(x))
        // println!("int vec: {:?}", trimmer(record.qual));
        println!("\n\n\n\n\n\n\n");
    }
    // trimmer(record.qual)
    // trimmer(record.qual: String)
}

fn trimmer(qual: Vec<u8>) -> (u16, u16) {
    let seq_len = qual.len();
    let mut l_found = false;
    let mut r_found = false;
    let mut lower_bound_index = 0_usize;
    let mut upper_bound_index = seq_len;
    for i in 0..seq_len - WINDOW_SIZE {
        let left_slice = &qual[i..i + WINDOW_SIZE];
        let left_window_sum: usize = left_slice.iter().map(|&x| x as usize).sum();

        let right_slice = &qual[seq_len - WINDOW_SIZE - i..seq_len - i];
        let right_window_sum: usize = right_slice.iter().map(|&x| x as usize).sum();

        // println!("{}, {}", left_window_sum, right_window_sum);
        if left_window_sum > THRESHOLD && !l_found {
            lower_bound_index = i + (WINDOW_SIZE as usize / 2);
            l_found = true;
            if r_found {
                break;
            }
        }
        if right_window_sum > THRESHOLD && !r_found {
            upper_bound_index = seq_len - i - (WINDOW_SIZE as usize / 2);
            r_found = true;
            if l_found {
                break;
            }
        }
    }
    return (lower_bound_index as u16, upper_bound_index as u16);
}
