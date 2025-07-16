From MetaCoq.Utils Require Import bytestring MCString.
From Coq Require Import ZArith.

Open Scope bs.
Open Scope Z.


Definition compile (input : string) : option string :=
  if Z.of_nat (String.length input) <=? 100 then
     None
  else
     Some ("===============================" ++ nl ++
           "PREAMBLE INSERTED BY mycompiler" ++ nl ++
           "===============================" ++ nl ++ input
          ).