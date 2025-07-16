From MetaCoq.Utils Require Import bytestring MCString.

Open Scope bs.

Definition compile (input : string) : string :=
  "===============================" ++ nl ++
  "PREAMBLE INSERTED BY mycompiler" ++ nl ++
  "===============================" ++ nl ++ input.