module EDItX
  class Order
    class DiscountPart
      include ROXML

      xml_name "DiscountPart"

      xml_accessor :code, :from => "DiscountCode"
      xml_accessor :percentage, :from => "DiscountPercentage"

    end
  end
end

