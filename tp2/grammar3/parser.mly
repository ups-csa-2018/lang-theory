// There was a conflict between `b U c` and `b V a`.  The simplest solution to get
// rid of this ambiguity is to merge the axioms U and V, and that's easy because
// they're strictly the same (ie. `d`).  We could even go deeper and delete the U
// axiom, but it's not necessary to fix this ambiguity.

%token A
%token B
%token C
%token D
%token EOF
%type <unit> sp
%start sp
%%
    sp:     s EOF   { };
    s:      u A     { print_string "S -> U a\n" }
          | B u C   { print_string "S -> b U c\n" }
          | u C     { print_string "S -> U c\n" }
          | B u A   { print_string "S -> b U a\n" };
    u:      D       { print_string "U -> d\n" };
%%
