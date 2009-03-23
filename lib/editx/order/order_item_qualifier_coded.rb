module EDItX
  class Order
    class OrderItemQualifierCoded
      include ROXML

      xml_name "OrderItemQualifierCoded"

      xml_accessor :code_type, :from => "OrderItemQualifierCodeType"
      xml_accessor :code, :from => "OrderItemQualifierCode"

    end
  end
end

