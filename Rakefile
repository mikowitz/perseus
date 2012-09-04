require 'sinatra/activerecord/rake'
require './perseus'

require 'curb'
require 'nokogiri'

task :import_latin do
  curl = Curl::Easy.new

  curl.url = "http://www.perseus.tufts.edu/hopper/vocablist?lang=la"
  puts "performing..."
  curl.perform
  puts "ok."
  
  puts "importing..."
  run_import(curl.body_str, 'latin')
  puts "done."
end

task :import_greek do
  curl = Curl::Easy.new

  curl.url = "http://www.perseus.tufts.edu/hopper/vocablist?lang=greek"
  puts "performing..."
  curl.perform
  puts "ok."
  
  puts "importing..."
  run_import(curl.body_str, 'greek')
  puts "done."
end

def run_import(content, language)
  puts language
  doc = Nokogiri::HTML(content)
  sels = doc.css('select[name=works] option')
  ret = {}
  sels.each do |sel|
    val = sel.values.first
    matches = sel.content.match(/^([^,]+),(.*)$/)
    if matches.nil?
      author = Author.find_or_create_by_name(name: "No Author recorded", language: language)
      name = sel.content
    else
      author, name = matches[1..-1]
      author = Author.find_or_create_by_name(name: author, language: language)
    end
    Work.create(author: author, title: name.strip, perseus_code: val, language: language)
  end
end
