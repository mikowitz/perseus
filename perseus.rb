require 'sinatra'
require 'sinatra/content_for'
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

class Author < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :works

  scope :by_language, lambda { |lang| where(language: lang) }
end

class Work < ActiveRecord::Base
  validates_uniqueness_of :perseus_code

  belongs_to :author

  scope :by_name, order('title ASC')
end
end
