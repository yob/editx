module EDItX
  class Order
    class DateCoded
      include ROXML

      xml_name "DateCoded"

      xml_accessor :date, :from => "Date", :as => Date, :to_xml => EDItX::Formatters.yyyymmdd
      xml_accessor :qualifier_code, :from => "DateQualifierCode"
    end
  end

end
