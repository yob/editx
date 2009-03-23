module EDItX
  class Order
    class DiscountDetail
      include ROXML

      xml_name "DiscountDetail"

      xml_accessor :code_type, :from => "DiscountCodeType"
      xml_accessor :parts, :from => "DiscountPart", :as => [EDItX::Order::DiscountPart]

      def initialize
        @parts = []
      end

    end
  end
end

