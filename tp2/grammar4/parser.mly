// I don't see any conflict here to be honest.
// The whole branch U -> V W U is never reached because both V and W axioms
// are the empty word.
// If they were an actual letter instead of the empty word, there would be
// a conflict. But still, the parser library is able to know which axiom to use
// (for whatever implementation related reason).

%token A
%token EOF
%type <unit> sp
%start sp

%%
    sp:     s EOF   { };
    s:      u       { print_string "S -> U\n" };
    u:      v w u   { print_string "U -> V W U\n" }
          | A       { print_string "U -> a\n" };
    v:              { print_string "V -> {empty}\n" };
    w:              { print_string "W -> {empty}\n" };
%%
