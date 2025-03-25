#include <caml/mlvalues.h>

#ifdef _WIN32
#define _WIN32_LEAN_AND_MEAN
#include <windows.h>
#else
#include <sys/ioctl.h>
#include <signal.h>
#endif

CAMLprim value caml_notty_winsize (value vfd) {
#ifdef _WIN32
  (void) vfd;
  HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
  if (hConsole == INVALID_HANDLE_VALUE) return Val_int (0);

  CONSOLE_SCREEN_BUFFER_INFO csbi;
  if (GetConsoleScreenBufferInfo(hConsole, &csbi)) {
    int columns = csbi.srWindow.Right - csbi.srWindow.Left + 1;
    int rows = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;
    return Val_int ((columns << 16) + ((rows & 0x7fff) << 1));
  }
  return Val_int (0);
#else
  int fd = Int_val (vfd);
  struct winsize w;
  if (ioctl (fd, TIOCGWINSZ, &w) >= 0)
    return Val_int ((w.ws_col << 16) + ((w.ws_row & 0x7fff) << 1));
  return Val_int (0);
#endif
}

CAMLprim value caml_notty_winch_number (value vunit) {
  (void) vunit;
#ifdef _WIN32
  return Val_int (0);
#else
  return Val_int (SIGWINCH);
#endif
}
