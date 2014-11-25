require_relative '../lib/sctp_addr'
require 'sctp'

module SCTP
  describe SCTPAddr do
    describe '::new' do
      it 'instantiates a SCTPAddr object' do
        obj = SCTPAddr.new("127.0.0.0", 1234)
        expect(obj).to be_instance_of(SCTPAddr)
      end

      it 'has an IP address and port' do
        addr = SCTPAddr.new("127.0.0.0", 1234)
        expect(addr.to_s).to eq("127.0.0.0:1234")
        expect(addr.ip).to eq("127.0.0.0")
        expect(addr.port).to eq(1234)
      end
    end

    describe '#ipv4?' do
      it 'is true when IP address is IPv4' do
        addr = SCTPAddr.new("127.0.0.0", 1234)
        expect(addr.ipv4?).to be_truthy
      end

      it 'is false when IP address is IPv6' do
        addr = SCTPAddr.new("3ffe:505:2::1", 1234)
        expect(addr.ipv4?).to be_falsey
      end
    end

    describe '#ipv6?' do
      it 'is true when IP address is IPv6' do
        addr = SCTPAddr.new("3ffe:505:2::1", 1234)
        expect(addr.ipv6?).to be_truthy
      end

      it 'is false when IP address is IPv4' do
        addr = SCTPAddr.new("127.0.0.0", 1234)
        expect(addr.ipv6?).to be_falsey
      end
    end
  end
end
