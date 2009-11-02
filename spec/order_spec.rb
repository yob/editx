# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper'

context "EDItX::Order" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"data")
    file1    = File.join(data_path, "order_1_2.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    order = EDItX::Order.from_xml(@root.to_s)
    order.to_s[0,6].should eql("<Order")
  end

  specify "should provide read access to version number" do
    order = EDItX::Order.from_xml(@root.to_s)

    order.version.should eql(BigDecimal.new("1.2"))
  end

  specify "should provide write access to version number" do
    order = EDItX::Order.from_xml(@root.to_s)

    order.version = BigDecimal.new("1.1")
    order.to_xml.to_s.include?("<Order version=\"1.1\">").should be_true
  end

  specify "should provide read access to header attibutes" do
    order = EDItX::Order.from_xml(@root.to_s)

    order.order_number.should eql("3594")
    order.issue_date_time.should eql(DateTime.civil(2008, 6, 24, 4, 14))
    order.references.should be_a_kind_of(Array)
    order.references.size.should eql(1)
    order.purpose_code.should eql("Original")
    order.currency_code.should eql("AUD")
    order.country_code.should eql("AU")
    order.dates.should be_a_kind_of(Array)
    order.dates.size.should eql(1)
    order.fill_terms_code.should eql("FillPartBackorderRemainderShipAsAvailable")
    order.buyer_party.should be_a_kind_of(EDItX::Order::Party)
    order.seller_party.should be_a_kind_of(EDItX::Order::Party)
    order.ship_to_party.should be_a_kind_of(EDItX::Order::Party)
    order.bill_to_party.should be_a_kind_of(EDItX::Order::Party)
    # TODO: ship_from
    # TODO: qualifiers
    # TODO: delivery
    order.shipping_instructions_code.should eql("ShipCombined")
    order.invoice_instructions_code.should eql("InvoiceCombined")
    # TODO: payment_terms
    # TODO: payment_terms_coded
    order.discount_percentage.should eql(BigDecimal.new("30"))
    # TODO: additional_service
    # TODO: messages
  end

  specify "should provide write access to header attibutes" do
    order = EDItX::Order.new

    order.order_number = "1234"
    order.to_xml.to_s.include?("<OrderNumber>1234</OrderNumber>").should be_true

    order.issue_date_time = DateTime.civil(2009, 3, 10, 00, 15)
    order.to_xml.to_s.include?("<IssueDateTime>20090310</IssueDateTime>").should be_true

  end

  specify "should provide read access to order lines" do
    order = EDItX::Order.from_xml(@root.to_s)

    order.items.should be_a_kind_of(Array)
    order.items.size.should eql(178)
  end

  specify "should provide write access to order lines"

  specify "should provide read access to summary values" do
    order = EDItX::Order.from_xml(@root.to_s)

    order.number_of_lines.should eql(179)
    order.units_ordered.should eql(25)
  end

  specify "should provide write access to summary values"

  specify "should be invalid if missing required fields" do
    order = EDItX::Order.new
    order.valid?.should be_false
  end

end
