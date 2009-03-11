require 'tempfile'

module EDItX
  class Order
    include ROXML

    xml_name "Order"

    # header values
    xml_accessor :version, :from => "@version", :as => BigDecimal, :to_xml => EDItX::Formatters.decimal
    xml_accessor :order_number, :in => "Header", :from => "OrderNumber"
    xml_accessor :issue_date_time, :in => "Header", :from => "IssueDateTime", :as => DateTime, :to_xml => EDItX::Formatters.yyyymmdd
    xml_accessor :references, :in => "Header", :from => "ReferenceCoded", :as => [EDItX::Order::ReferenceCoded]
    xml_accessor :purpose_code, :in => "Header", :from => "PurposeCode"
    xml_accessor :currency_code, :in => "Header", :from => "CurrencyCode"
    xml_accessor :country_code, :in => "Header", :from => "CountryCode"
    xml_accessor :dates, :in => "Header", :from => "ReferenceCoded", :as => [EDItX::Order::DateCoded]
    xml_accessor :fill_terms_code, :in => "Header", :from => "FillTermsCode"
    xml_accessor :buyer_party, :in => "Header", :from => "BuyerParty", :as => EDItX::Order::Party
    xml_accessor :seller_party, :in => "Header", :from => "SellerParty", :as => EDItX::Order::Party
    xml_accessor :ship_to_party, :in => "Header", :from => "ShipToParty", :as => EDItX::Order::Party
    xml_accessor :bill_to_party, :in => "Header", :from => "BillToParty", :as => EDItX::Order::Party
    xml_accessor :shipping_instructions_code, :in => "Header", :from => "ShippingInstructionsCode"
    xml_accessor :invoice_instructions_code, :in => "Header", :from => "InvoiceInstructionsCode"
    xml_accessor :discount_percentage, :in => "Header", :from => "DiscountPercentage", :as => BigDecimal, :to_xml => EDItX::Formatters.decimal

    # detail
    xml_accessor :items, :from => "ItemDetail", :as => [EDItX::Order::ItemDetail]

    # footer / summary
    xml_accessor :number_of_lines, :in => "Summary", :from => "NumberOfLines", :as => Fixnum
    xml_accessor :units_ordered, :in => "Summary", :from => "UnitsOrdered", :as => Fixnum

    def initialize
      self.version = BigDecimal.new("1.2")
      self.references = []
      self.dates = []
      self.items = []
    end

    def to_s
      self.to_xml.to_s
    end

    def valid?
      schema_path = File.join(File.dirname(__FILE__), "..", "..", "schemas")
      case self.version
      when BigDecimal.new("1.0")
        schema_path << "/order_1_0.xsd"
      when BigDecimal.new("1.1")
        schema_path << "/order_1_1.xsd"
      when BigDecimal.new("1.2")
        schema_path << "/order_1_2.xsd"
      else
        raise ArgumentError, "version #{self.version} is invalid"
      end

      Tempfile.open("editx") do |tf|
        tf.write self.to_s
        tf.close

        system("xmllint --schema #{schema_path} #{tf.path} &> /dev/null")
        if $?.exitstatus == 0
          return true
        else
          return false
        end
      end
    end
  end

end
