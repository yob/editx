module EDItX
  class Order
    include ROXML

    xml_name "Order"

    xml_accessor :order_number, :in => "Header", :from => "OrderNumber"
    xml_accessor :issue_date_time, :in => "Header", :from => "IssueDateTime", :as => DateTime, :to_xml => EDItX::Formatters.yyyymmdd

    #def initialize
    #end
  end

end
