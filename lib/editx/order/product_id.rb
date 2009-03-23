module EDItX
  class Order
    class ProductID
      include ROXML

      xml_name "ProductID"

      xml_accessor :type, :from => "ProductIDType"
      xml_accessor :type_name, :from => "ProductIDType"
      xml_accessor :identifier, :from => "Identifier"

    end
  end
end

