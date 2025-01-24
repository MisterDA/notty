#include <caml/mlvalues.h>

#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 202311L
#define unused(x) [[maybe_unused]] (x)
#elif defined(__GNUC__)
#define unused(x) __attribute__((unused)) x
#else
#define unused(x)
#endif

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

CAMLprim value caml_notty_winsize (unused(value vfd))
{
  CONSOLE_SCREEN_BUFFER_INFO csbi;
  int ret = GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi);
  if (ret)
    return Val_int ((csbi.dwSize.X << 16) + ((csbi.dwSize.Y & 0x7fff) << 1));
  return Val_int(0);
}

CAMLprim value caml_notty_winch_number (unused(value vunit)) {
  return Val_int(0);
}

#else

#include <sys/ioctl.h>
#include <signal.h>

CAMLprim value caml_notty_winsize (value vfd) {
  int fd = Int_val (vfd);
  struct winsize w;
  if (ioctl (fd, TIOCGWINSZ, &w) >= 0)
    return Val_int ((w.ws_col << 16) + ((w.ws_row & 0x7fff) << 1));
  return Val_int (0);
}

CAMLprim value caml_notty_winch_number (unused(value vunit)) {
  return Val_int (SIGWINCH);
}

#endif
