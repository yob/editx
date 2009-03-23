module EDItX
  class Order
    class Price
      include ROXML

      xml_name "Price"

      xml_accessor :monetary_amount, :from => "MonetaryAmount", :as => BigDecimal
      xml_accessor :currency_code, :from => "CurrencyCode"
      xml_accessor :country_code, :from => "CountryCode"
      xml_accessor :qualifier_code, :from => "PriceQualifierCode"

    end
  end
end

