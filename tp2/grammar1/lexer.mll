{
    open Parser
}

rule main = parse
      'a'      { A }
    | 'b'      { B }
    | '\n'|eof { EOF }
    | _        { failwith "bad character !" }
