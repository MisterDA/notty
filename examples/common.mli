module List : sig
  include module type of List

  val replicate : int -> 'a -> 'a list
  val range : int -> int -> int list
  val intersperse : 'a -> 'a list -> 'a list
  val take : int -> 'a list -> 'a list
  val splitat : int -> 'a list -> 'a list * 'a list
  val chunks : int -> 'a list -> 'a list list
  val zip : 'a list -> 'b list -> ('a * 'b) list
end

module String : sig
  include module type of String

  val repeat : int -> string -> string
end

val tile : int -> int -> Notty.image -> Notty.image

module Images : sig
  val i1 : Notty.image
  val i2 : Notty.image
  val i3 : Notty.image
  val i4 : Notty.image
  val i5 : Notty.image

  val c_gray_ramp : Notty.image
  val c_cube_ix : Notty.image
  val c_cube_rgb : Notty.image
  val c_rainbow : int -> int -> Notty.image
  val dot : Notty.A.color -> Notty.image
  val square : Notty.A.color -> Notty.image
  val cantor : int -> Notty.image
  val checker : int -> int -> Notty.image -> Notty.image
  val checker1 : Notty.image
  val sierp : Notty.A.color -> int -> Notty.image
  val grid : Notty.image list list -> Notty.image
  val outline : Notty.attr -> Notty.image -> Notty.image
end

val pxmatrix : int -> int -> (int -> int -> Notty.A.color) -> Notty.image

module Term : module type of Notty_unix.Term

val simpleterm : imgf:(int * int -> 'a -> Notty.image) ->
                 f:('a -> [> Notty.Unescape.event ] -> 'a option) -> s:'a -> unit
