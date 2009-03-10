require 'rubygems'
require 'bigdecimal'

# ensure we load the correct gem versions
gem 'roxml', '2.5.1'
gem 'andand'

# and now load the actual gems
require 'roxml'
require 'andand'

module EDItX
  module Version #:nodoc:
    Major = 0
    Minor = 0
    Tiny  = 1

    String = [Major, Minor, Tiny].join('.')
  end

  class Formatters
    def self.decimal
      lambda do |val|
        if val.kind_of?(BigDecimal)
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
ROXML::SILENCE_XML_NAME_WARNING = true

# core files
# - ordering is important, classes need to be defined before any
#   other class can use them
require File.join(File.dirname(__FILE__), "editx", "order", "reference_coded")
require File.join(File.dirname(__FILE__), "editx", "order", "date_coded")
require File.join(File.dirname(__FILE__), "editx", "order", "party")
require File.join(File.dirname(__FILE__), "editx", "order")
