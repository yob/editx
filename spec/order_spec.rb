# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'editx'

context "EDItX::Order" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"data")
    file1    = File.join(data_path, "order.xml")
    @doc = LibXML::XML::Document.file(file1)
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    order = EDItX::Order.from_xml(@root.to_s)
    order.to_xml.to_s[0,7].should eql("<Order>")
  end

  specify "should provide read access to header attibutes" do
    order = EDItX::Order.from_xml(@root.to_s)

    order.order_number.should eql("3594")
    order.issue_date_time.should eql(DateTime.civil(2008, 6, 24, 4, 14))
  end

  specify "should provide write access to first level attibutes" do
    order = EDItX::Order.new

    order.order_number = "1234"
    order.to_xml.to_s.include?("<OrderNumber>1234</OrderNumber>").should be_true

    order.issue_date_time = DateTime.civil(2009, 3, 10, 00, 15)
    order.to_xml.to_s.include?("<IssueDateTime>20090310</IssueDateTime>").should be_true

  end

end
