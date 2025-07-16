Require Import Coq.extraction.Extraction.
Require mycompiler.pipeline.

Set Extraction Output Directory "theories/extraction".
Separate Extraction mycompiler.pipeline.compile.
