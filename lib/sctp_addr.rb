require 'forwardable'
require 'ipaddr'

module SCTP
  class SCTPAddr
    extend Forwardable
    attr_reader :port

    def_delegators(:@ip_addr, :ipv4?, :ipv6?)

    def initialize(ip, port)
      @ip_addr = IPAddr.new(ip)
      @port = port
    end

    def to_s
      "#{@ip_addr}:#{@port}"
    end

    def ip
      "#{@ip_addr}"
    end
  end
end
