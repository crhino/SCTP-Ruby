require 'mkmf'

LIBDIR      = RbConfig::CONFIG['libdir']
INCLUDEDIR  = RbConfig::CONFIG['includedir']

HEADER_DIRS = ['/usr/local/include', INCLUDEDIR, '/usr/include']

LIB_DIRS = ['/usr/local/lib', LIBDIR, '/usr/lib']

dir_config('sctp', HEADER_DIRS, LIB_DIRS)

unless find_header('netinet/sctp.h')
  abort "libsctp is missing. please install libsctp"
end

unless find_library('sctp', 'sctp_connectx')
  abort "libsctp is missing. please install libsctp"
end

create_makefile('sctp')
