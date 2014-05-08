require 'json'
require 'socket'

module ActiveSupport
  module Cache
    class DiceCache < Store

      def read_entry(key, options)
        op({"op" => "get", "key" => key})
      end

      def write_entry(key, value, options)
        op({"op" => "put", "key" => key, "value" => value})
      end

      def delete_entry(key, options)
        op({"op" => "remove", "key" => key})
      end 

      private

        def op(data)
          @socket = TCPSocket.new(options[:host], options[:port])
          @socket.write(JSON.generate(data))
          @socket.read.to_json
        end

    end
  end
end
