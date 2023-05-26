include module type of Common

val simpleterm_lwt :
  imgf:(int * int -> 'a -> Notty.image) ->
  f:('a -> [> Notty.Unescape.event ] -> 'a option) -> s:'a -> unit

val timer : float option -> [> `Timer ] Lwt.t

val event :
  Notty_lwt.Term.t ->
  [> `End
  | `Key of Notty.Unescape.key
  | `Mouse of Notty.Unescape.mouse
  | `Paste of Notty.Unescape.paste
  | `Resize of int * int ]
    Lwt.t

val simpleterm_lwt_timed :
  ?delay:float ->
  f:(int * int ->
     'a ->
     [> `Key of Notty.Unescape.key
     | `Mouse of Notty.Unescape.mouse
     | `Paste of Notty.Unescape.paste
     | `Resize of int * int
     | `Timer ] ->
     [< `Continue of 'a | `Redraw of 'a * Notty.image | `Stop ]) ->
  'a -> unit Lwt.t
