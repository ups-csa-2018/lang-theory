{
    let digit_of_char c = (int_of_char c - int_of_char '0')
    let printres number = begin
        print_string (
            "This is your number: " ^ (string_of_int number));
        print_newline ()
    end
}

rule l0 = parse
    | ['1' - '9'] as i   { l1 (digit_of_char i) lexbuf }
    | _                  { failwith "Syntax error" }
and l1 base = parse
    | ['0' - '9'] as i   { l1 (10 * base + (digit_of_char i)) lexbuf }
    | eof | '\n'         { printres base }
    | '$'                {
        if base < 2 || base > 10 then
            failwith "Unsupported base"
        else
            l2 base lexbuf
    }
    | _                  { failwith "Syntax error" }
and l2 base = parse
    | ['1' - '9'] as i   {
        let c = (digit_of_char i) in
        if c >= base then
            failwith ("Syntax error: invalid number: " ^ Char.escaped i)
        else
            l3 base c lexbuf
    }
    | _                  { failwith "Syntax error" }
and l3 base number = parse
    | ['0' - '9'] as i   {
        let c = (digit_of_char i) in
        if c >= base then
            failwith ("Syntax error: invalid number: " ^ Char.escaped i)
        else
            l3 base (number * base + c) lexbuf
    }
    | eof | '\n'         { printres number }
    | _                  { failwith "Syntax error" }
