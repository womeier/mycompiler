(****** CMDLINE PARSING *******)

let debug = ref false
let input_file = ref ""
let output_file = ref ""

let speclist =
  [
    ("-output", Arg.Set_string output_file, "Set output file name");
    ("-input", Arg.Set_string input_file, "Set input file name");
    ("-debug", Arg.Set debug, "Debug printing");
  ]

let usage_msg = {|
  =========================================
    EXAMPLE:

      ./main.exe -input test.txt -output test2.txt
  =========================================
|}


(****** IO Helpers *******)
let read_text_from_file filename =
  try
    In_channel.with_open_text
      filename
      In_channel.input_all
  with Sys_error msg ->
    failwith ("Failed to read from file: " ^ msg)

let write_text_to_file filename text =
  Out_channel.with_open_text
    filename
    (fun out_channel ->
      Out_channel.output_string out_channel text)


let debug_print msg =
  if !debug then (Printf.fprintf stdout msg)

open Pipeline

(****** MAIN *******)

let () =
  Arg.parse speclist (fun _ -> ()) usage_msg;
  if (String.equal !output_file "") then (
    Printf.fprintf stdout "Expected -output flag. See also -help.\n";
    exit 0
  ) else
    if (String.equal !input_file "") then (
      Printf.fprintf stdout "Expected -input flag. See also -help\n";
      exit 0
    ) else
      debug_print "Reading input file...\n";
      let input = read_text_from_file !input_file in
      let input_bytestring = Caml_bytestring.bytestring_of_caml_string input in
      debug_print "Calling extracted Rocq pipeline...\n";
      let output_bytestring = Pipeline.compile input_bytestring in
      let output = Caml_bytestring.caml_string_of_bytestring output_bytestring in
      debug_print "Writing output file...\n";
      write_text_to_file !output_file output
