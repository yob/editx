module EDItX
  class Order
    class ReturnsConditions
      include ROXML

      xml_name "ReturnsConditions"

      xml_accessor :last_date_for_returns, :from => "LastDateForReturns", :as => DateTime, :to_xml => EDItX::Formatters.yyyymmdd
      xml_accessor :max_returns_percentage, :from => "MaximumReturnsPercentage"
      xml_accessor :max_returns_quantity, :from => "MaximumReturnsQuantity"
      xml_accessor :conditions, :from => "ReturnsConditionCoded", :as => [EDItX::Order::ReturnsConditionCoded]

      def initialize
        @conditions = []
      end

    end
  end
end
