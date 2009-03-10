module EDItX
  class Order
    class ReferenceCoded

      include ROXML

      xml_name "ReferenceCoded"

      xml_accessor :type_code, :from => "ReferenceTypeCode"
      xml_accessor :number, :from => "ReferenceNumber"
      xml_accessor :date, :from => "ReferenceDate", :as => Date, :to_xml => EDItX::Formatters.yyyymmdd

    end
  end
end
