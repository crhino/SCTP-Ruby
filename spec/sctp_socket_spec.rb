require 'socket'
require 'sctp'

describe SCTP::Socket do
  describe '::new' do
    it 'instantiates a SCTP::Socket object' do
      obj = SCTP::Socket.new(Socket::PF_INET, Socket::SOCK_STREAM)
      expect(obj).to be_instance_of(SCTP::Socket)
    end

    it 'returns an object with the superclass of IPSocket' do
      obj = SCTP::Socket.new(Socket::PF_INET, Socket::SOCK_STREAM)
      p obj.inspect
      expect(obj).to be_a_kind_of(IPSocket)
    end
 
    it 'can be instantiated with the SOCK_SEQPACKET flag' do
      obj = SCTP::Socket.new(Socket::PF_INET, Socket::SOCK_SEQPACKET)
      expect(obj).to be_a_kind_of(IPSocket)
    end

    context 'when passed a non-applicable connection type' do
      it 'raises an exception when the call to socket() fails' do
        expect {
          SCTP::Socket.new(Socket::PF_INET, Socket::SOCK_DGRAM)
        }.to raise_error
      end
    end
  end

  describe '#sctp_bindx' do
    it 'binds to given local addresses'
  end
end
