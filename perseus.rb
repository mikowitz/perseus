require 'sinatra'
require 'sinatra/content_for'
require 'nokogiri'
require 'haml'
require 'sass'
require 'coffee-script'

require 'sinatra/activerecord'

set :database, 'sqlite:///perseus.db'

get '/' do
  redirect to '/vocabulist'
end

get '/vocabulist' do
  haml :vocabulist, locals: { works: latin_works }
end

get '/stylesheets/*.css' do
  filename = '/stylesheets/' + params[:splat].first
  sass filename.to_sym
end

get '/javascripts/*.js' do
  filename = '/javascripts/' + params[:splat].first
  coffee filename.to_sym
end



def latin_works
  doc = Nokogiri::HTML(File.read('body.txt'))
  sels = doc.css('select[name=works] option')
  ret = {}
  sels.each do |sel|
    val = sel.values.first
    author, name = sel.content.match(/^([^,]+),(.*)$/)[1..-1]
    ret[author] ||= []
    ret[author] << [name.strip, val]
  end

  ret
end
