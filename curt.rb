# TODO:
# - add error handling
# - use option parser
# - turn into gem format
# coding: UTF-8

require 'open-uri'
require 'nokogiri'
require 'cgi'

class Curt
  def self.urban(word)
    url = "http://www.urbandictionary.com/define.php?term=#{CGI.escape(word)}"
    str = CGI.unescape_html Nokogiri::HTML(open(url)).at("div.definition").text.gsub(/\s+/, ' ')
    "#{word} : #{str}"
  end

  def self.wiki(word)
    query = word.gsub(" ", "_")
    url = "http://en.wikipedia.org/wiki/#{CGI.escape(query)}"
    str = CGI.unescape_html Nokogiri::HTML(open(url)).at("div#bodyContent p").text.gsub(/\s+/, ' ')
    "#{word} : #{str}"
  end

  def self.dict(word)
    url = URI.escape("http://www.google.com/dictionary?langpair=en|en&q=#{CGI.escape(word)}")
    str = CGI.unescape_html Nokogiri::HTML(open(url)).at("div.dct-em").text.gsub(/\s+/, ' ')
    "#{word} : #{str}"
  end
end


case ARGV.first
when "dict"
  puts Curt.dict(ARGV[1])
when "wiki"
  puts Curt.wiki(ARGV[1])
when "urban"
  puts Curt.urban(ARGV[1])
end
