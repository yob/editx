module EDItX
  class Order
    class ReturnsConditionCoded
      include ROXML

      xml_name "ReturnsConditionCoded"

      xml_accessor :type, :from => "ReturnsConditionCodeType"
      xml_accessor :code, :from => "ReturnsConditionCode"

    end
  end
end

