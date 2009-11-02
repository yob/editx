require 'tempfile'

module EDItX
  # A abstraction for creating and generating EDItX Trade Order messages
  #
  # == Generating a new order
  #
  # The fundamentals are fairly simple. You create a new Order object, set various 
  # attributes on it, then add 1 or more ItemDetail objects - 1 for each item you
  # would like to order.
  #
  #   msg = EDItX::Order.new
  #   msg.order_number = self.id
  #   msg.issue_date_time = self.created_at
  #   msg.fill_terms_code = "FillPartBackorderRemainderShipAsAvailable"
  #
  #   (1..10).each do |idx|
  #     item = EDItX::Order::ItemDetail.new
  #     item.line_number = idx
  #
  #     ean = EDItX::Order::ProductID.new$
  #     ean.type = "EAN13"$
  #     ean.identifier = "product code goes here"$
  #     item.identifiers << ean
  #
  #     p = EDItX::Order::Price.new
  #     p.monetary_amount = 10.00
  #     item.prices << p
  #
  #     item.title_detail = "Title and author here"
  #     item.order_quantity
  #     msg.items << item
  #   end
  #
  #   puts msg.to_s
  #
  # The challenge comes in making sure you output a VALID order file. Several elements are
  # compulsory - I reccommend having a copy of the spec open to check which elements you
  # need to include, and valid options for elements like fill_terms_code.
  #
  # To check the validity of your output, save it to a file and run xmllint on it, using
  # the schemas distributed with this gem:
  #
  #   xmllint --valid --nonet --schema schemas/order_1_2.xsd testfile.ord
  #
  # Continue testing with that command until you get output like "testfile.ord validates".
  #
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
    xml_accessor :dates, :in => "Header", :from => "DateCoded", :as => [EDItX::Order::DateCoded]
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

        system("xmllint --schema #{schema_path} #{tf.path} > /dev/null 2>&1")
        if $?.exitstatus == 0
          return true
        else
          return false
        end
      end
    end
  end

end
