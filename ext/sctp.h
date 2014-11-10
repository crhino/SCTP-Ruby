#ifndef RUBY_SCTP
#define RUBY_SCTP

#include <ruby.h>
#include <netinet/sctp.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>

#include "sctp_socket.h"

extern VALUE mSCTP;

#endif
