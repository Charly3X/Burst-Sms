require 'rspec'
require 'nokogiri'
require 'webmock/rspec'
require 'coveralls'

Coveralls.wear!

require File.dirname(__FILE__) + '/../lib/burstsms'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

RSpec::Matchers.define :have_xml do |xpath, text|
  match do |body|
    doc = body
    nodes = doc.xpath(xpath)
    nodes.empty?.should be_false
    if text
      nodes.each do |node|
        node.content.should == text
      end
    end
    true
  end

  failure_message_for_should do |body|
    "expected to find xml tag #{xpath} in:\n#{body}"
  end

  failure_message_for_should_not do |response|
    "expected not to find xml tag #{xpath} in:\n#{body}"
  end

  description do
    "have xml tag #{xpath}"
  end
end