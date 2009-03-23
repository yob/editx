module EDItX
  class Order
    class Message
      include ROXML

      xml_name "Message"

      xml_accessor :type, :from => "MessageType"
      xml_accessor :lines, :from => "MessageLine", :as => []

      def initialize
        @lines = []
      end

    end
  end
end

