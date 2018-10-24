{
    let digit_of_char c = (int_of_char c - int_of_char '0')
    let numbers = ref []

    let push_numbers number count = begin
        for i = 1 to count do
            numbers := List.append !numbers [number]
        done
    end
}

rule l0 = parse
    | ['1'-'9'] as i    { l1 (digit_of_char i) lexbuf }
    | _                 { failwith "Syntax error" }
and l1 base = parse
    | ['0'-'9'] as i    { l1 (base * 10 + (digit_of_char i)) lexbuf }
    | '$'               { l2 base lexbuf }
    | _                 { failwith "Syntax error" }
and l2 base = parse
    | '+'               { l3 base 1 lexbuf }
    | '-'               { l4 base 1 lexbuf }
    | '0'               { l5 base 1 lexbuf }
    | eof | '\n'        {
        print_string (String.concat " " (List.map string_of_int !numbers));
        print_newline ()
    }
    | _                 { failwith "SyntaxError" }
and l3 base count = parse
    | '+'               { l3 base (count + 1) lexbuf }
    | ['1'-'9'] as n    { l6 base count (digit_of_char n) 1 lexbuf }
    | _                 { failwith "SyntaxError" }
and l4 base count = parse
    | '-'               { l4 base (count + 1) lexbuf }
    | ['1'-'9'] as n    { l6 base count (digit_of_char n) (-1) lexbuf }
    | _                 { failwith "SyntaxError" }
and l5 base count = parse
    | '0'               { l5 base (count + 1) lexbuf }
    | 'b'               { push_numbers base count; l2 base lexbuf }
    | _                 { failwith "SyntaxError" }
and l6 base count num otype = parse
    | ['0'-'9'] as n    { l6 base count (num * 10 + (digit_of_char n)) otype lexbuf }
    | 'b'               { push_numbers (base + num * otype) count; l2 base lexbuf }
    | _                 { failwith "SyntaxError" }
