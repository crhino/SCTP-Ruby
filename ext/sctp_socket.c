#include "sctp_socket.h"
#include <stdio.h>

typedef struct _sctp_socket {
  int fd;
} sctp_socket;

typedef struct _sctp_args {
  VALUE sock;
  int domain, type;
} sctp_args;

static void sctp_socket_free(void *obj) {
  sctp_socket *sock = (sctp_socket *) obj;
  close(sock->fd);
  free(sock);
}

static VALUE sctp_create_socket(sctp_args *arg) {
  int fd = 0;
  int domain = arg->domain;
  int type = arg->type;
  sctp_socket *sock;

  fd = socket(domain, type, IPPROTO_SCTP);
  if (fd < 0) {
    rb_sys_fail("socket(2)");
  }

  Data_Get_Struct(arg->sock, sctp_socket, sock);
  sock->fd = fd;

  return arg->sock;
}

static VALUE sctp_socket_allocate(VALUE klass) {
  sctp_socket *sock = malloc(sizeof(sctp_socket));

  return Data_Wrap_Struct(klass, NULL, sctp_socket_free, sock);
}

static VALUE sctp_socket_initialize(int argc, VALUE *argv, VALUE self) {
  VALUE domain, type;
  sctp_args arg;

  rb_scan_args(argc, argv, "2", &domain, &type);

  arg.sock = self;
  arg.domain = FIX2INT(domain);
  arg.type =  FIX2INT(type);

  return sctp_create_socket(&arg);
}

void Init_sctp_socket() {
  VALUE rb_cIPSocket, cSCTPSocket;

  rb_require("socket");
  rb_cIPSocket = rb_const_get(rb_cObject, rb_intern("IPSocket"));
  cSCTPSocket = rb_define_class_under(mSCTP, "Socket", rb_cIPSocket);

  rb_define_alloc_func(cSCTPSocket, sctp_socket_allocate);
  rb_define_method(cSCTPSocket, "initialize", sctp_socket_initialize, -1);
}

/* static VALUE sctp_cleanup_socket(sctp_args *arg) { */
/*   sctp_socket *socket; */
/*   Data_Get_Struct(args->sock, sctp_socket, socket); */

/*   close(socket->fd); */
/*   return Qnil; */
/* } */
