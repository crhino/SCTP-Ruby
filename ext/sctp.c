#include "sctp.h"

VALUE mSCTP;

void Init_sctp() {
  mSCTP = rb_define_module("SCTP");

  Init_sctp_socket();
}
