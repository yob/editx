module EDItX
  class Order
    class ItemDetail
      include ROXML

      xml_name "ItemDetail"

      xml_accessor :line_number, :from => "LineNumber", :as => Fixnum
      xml_accessor :quantity, :from => "Quantity", :as => Fixnum

    end
  end
end
