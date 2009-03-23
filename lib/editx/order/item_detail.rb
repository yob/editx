module EDItX
  class Order
    class ItemDetail
      include ROXML

      xml_name "ItemDetail"

      xml_accessor :line_number, :from => "LineNumber", :as => Fixnum
      xml_accessor :identifiers, :from => "ProductID", :as => [EDItX::Order::ProductID]
      xml_accessor :title_detail, :in => "ItemDescription", :from => "TitleDetail"
      xml_accessor :order_quantity, :from => "OrderQuantity", :as => Fixnum
      xml_accessor :references, :from => "ReferenceCoded", :as => [EDItX::Order::ReferenceCoded]
      xml_accessor :dates, :from => "DateCoded", :as => [EDItX::Order::DateCoded]
      xml_accessor :fill_terms_code, :from => "FillTermsCode"
      xml_accessor :qualifiers, :from => "OrderItemQualifierCoded", :as => [EDItX::Order::OrderItemQualifierCoded]
      xml_accessor :prices, :in => "PricingDetail", :from => "Price", :as => [EDItX::Order::Price]
      xml_accessor :discount_percentage, :in => "PricingDetail", :from => "DiscountPercentage", :as => BigDecimal
      xml_accessor :discount_detail, :in => "PricingDetail", :from => "DiscountDetail", :as => [EDItX::Order::DiscountDetail]
      xml_accessor :returns_conditions, :from => "ReturnsConditions", :as => [EDItX::Order::ReturnsConditions]
      xml_accessor :messages, :from => "Message", :as => [EDItX::Order::Message]

      def initialize
        @identifiers = []
        @references  = []
        @dates       = []
        @qualifiers  = []
        @prices      = []
        @returns_conditions = []
      end

    end
  end
end
