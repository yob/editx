require 'rubygems'
require 'bigdecimal'

# ensure we load the correct gem versions
gem 'roxml', '2.5.3'
gem 'andand'

# and now load the actual gems
require 'roxml'
require 'andand'

module EDItX
  module Version #:nodoc:
    Major = 0
    Minor = 1
    Tiny  = 1

    String = [Major, Minor, Tiny].join('.')
  end

  class Formatters
    def self.decimal
      lambda do |val|
        if val.nil?
          nil
        elsif val.kind_of?(BigDecimal)
          val.to_s("F")
        else
          val.to_s
        end
      end
    end

    def self.yyyymmdd
      lambda do |val|
        if val.nil? || !val.respond_to?(:strftime)
          nil
        else
          val.strftime("%Y%m%d")
        end
      end
    end

    def self.two_digit
      lambda do |val|
        if val.nil?
          nil
        elsif val < 10
          "0#{val}"
        elsif val > 99
          val.to_s[-2,2]
        else
          val.to_s
        end
      end
    end
  end
end

# silence some warnings from ROXML
unless ROXML.const_defined?("SILENCE_XML_NAME_WARNING")
  ROXML::SILENCE_XML_NAME_WARNING = true
end

# core files
# - ordering is important, classes need to be defined before any
#   other class can use them
require File.join(File.dirname(__FILE__), "editx", "order", "reference_coded")
require File.join(File.dirname(__FILE__), "editx", "order", "date_coded")
require File.join(File.dirname(__FILE__), "editx", "order", "party")
require File.join(File.dirname(__FILE__), "editx", "order", "product_id")
require File.join(File.dirname(__FILE__), "editx", "order", "order_item_qualifier_coded")
require File.join(File.dirname(__FILE__), "editx", "order", "price")
require File.join(File.dirname(__FILE__), "editx", "order", "discount_part")
require File.join(File.dirname(__FILE__), "editx", "order", "discount_detail")
require File.join(File.dirname(__FILE__), "editx", "order", "returns_condition_coded")
require File.join(File.dirname(__FILE__), "editx", "order", "returns_conditions")
require File.join(File.dirname(__FILE__), "editx", "order", "message")
require File.join(File.dirname(__FILE__), "editx", "order", "item_detail")
require File.join(File.dirname(__FILE__), "editx", "order")
