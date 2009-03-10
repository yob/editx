# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'editx'

context "spec/data/order_1_1.xml" do

  before(:each) do
    @schema_dir  = File.join(File.dirname(__FILE__),"..", "schemas")
    @schema_path = File.join(@schema_dir, "order_1_1.xsd")
    @data_dir    = File.join(File.dirname(__FILE__),"data")
    @file_path   = File.join(@data_dir, "order_1_1.xml")
  end

  specify "should be a valid EDItX Trade Order 1.1 file" do
    system("xmllint --schema #{@schema_path} #{@file_path} &> /dev/null")
    $?.exitstatus.should eql(0)
  end

end

context "spec/data/order_1_2.xml" do

  before(:each) do
    @schema_dir  = File.join(File.dirname(__FILE__),"..", "schemas")
    @schema_path = File.join(@schema_dir, "order_1_2.xsd")
    @data_dir    = File.join(File.dirname(__FILE__),"data")
    @file_path   = File.join(@data_dir, "order_1_2.xml")
  end

  specify "should be a valid EDItX Trade Order 1.2 file" do
    system("xmllint --schema #{@schema_path} #{@file_path} &> /dev/null")
    $?.exitstatus.should eql(0)
  end

end
