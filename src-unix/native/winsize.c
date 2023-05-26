#include <sys/ioctl.h>
#include <signal.h>
#include <caml/mlvalues.h>

CAMLprim value caml_notty_winsize (value vfd) {
  int fd = Int_val (vfd);
  struct winsize w;
  if (ioctl (fd, TIOCGWINSZ, &w) >= 0)
    return Val_int ((w.ws_col << 16) + ((w.ws_row & 0x7fff) << 1));
  return Val_int (0);
}

CAMLprim value caml_notty_winch_number (value unit __attribute__((unused))) {
  return Val_int (SIGWINCH);
}
