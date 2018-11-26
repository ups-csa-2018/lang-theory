{
    open Parser
}

rule main = parse
      'a'      { A }
    | '\n'|eof { EOF }
    | _        { failwith "bad character !" }
