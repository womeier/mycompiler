(* taken from CertiCoq, MIT license *)
open Byte
open Caml_byte

val caml_bytestring_length : Bytestring.String.t -> int
val bytestring_of_caml_string : string -> Bytestring.String.t
val caml_string_of_bytestring : Bytestring.String.t -> string
