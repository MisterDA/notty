(lang dune 3.7)

(generate_opam_files true)
(formatting disabled)

(source (github pqwy/notty))
(authors "David Kaloper <dk505@cam.ac.uk>")
(maintainers "David Kaloper <dk505@cam.ac.uk>")
(documentation "https://pqwy.github.io/notty/doc")
(license "ISC")

(package
 (name notty)
 (synopsis "Declaring terminals")
 (description "\
Notty is a declarative terminal library for OCaml structured around a notion of composable images. It tries to abstract away the basic terminal programming model, providing something simpler and more expressive.")
 (depends
  (ocaml (>= 4.08))
  (cppo (and (>= 1.1.0) :build))
  (uutf (>= 1.0.0)))
 (depopts
  (lwt (>= 5.6.1)))
 (conflicts
  (lwt (< 2.5.2))))

(package
 (name notty-bench)
 (synopsis "Benchmarks for notty")
 (depends
  notty
  unmark))
