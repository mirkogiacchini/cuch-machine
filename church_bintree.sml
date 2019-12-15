use "dynamic_lazy.sml";

(* church numbers *) 

(* zero = fn x => fn y => y *)
val zero = Fn(Name "x", Fn(Name "y", Var(Name "y")));

(* one = fn x => fn y => x y *)
val one = Fn(Name "x", Fn(Name "y", App(Var(Name "x"), Var(Name "y"))));

(* sum = fn w => fn z => fn x => fn y => w x(z x y) *)
val sum = Fn(Name "w", Fn(Name "z", Fn(Name "x", Fn(Name "y", 
 App(App(Var(Name "w"), Var(Name "x")), 
  App(App(Var(Name "z"), Var(Name "x")),Var(Name "y"))
 )))));

(* church booleans *) 

(* false = fn x => fn y => y *)
val False = Fn(Name "x", Fn(Name "y", Var(Name "y")));

(* true = fn x => fn y => x *)
val True = Fn(Name "x", Fn(Name "y", Var(Name "x")));

(* church binary trees *)

(* non possiamo usare unit quindi mi creo un surrogato *)
val env = Concat(Name "void", Const 0, Empty, Empty);

(* empty tree = fn t => fn l => fn => r => true () () () *)
val empty = Fn(Name "t", Fn(Name "l", Fn(Name "r", 
 App(App(App(True, Var(Name "void")), Var(Name "void")), Var(Name "void")))));

(* non-empty tree = fn t => fn l => fn r => false t l r *)
val node = Fn(Name "t", Fn(Name "l", Fn(Name "r", 
 App(App(App(False, Var(Name "t")), Var(Name "l")), Var(Name "r")))));

(* fun leaves empty = 1 
 *   | leaves node = (leaves (getLeft node)) + (leaves (getRight node)) *)

(* ricorsore per leaves *)

val leaves = Fn(Name "b", Fn(Name "t", Fn(Name "l", Fn(Name "r",
 App(App(Var(Name "b"), one), 
  App(App(sum, App(leaves, Var(Name "l"))), App(leaves, Var(Name "r"))))))));
