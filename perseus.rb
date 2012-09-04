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

get '/vocabulist/?:lang?' do
  lang = params[:lang] || 'latin'
  @lang_param = lang == 'latin' ? 'la' : 'greek'
  @authors = Author.by_language(lang).order('name ASC')
  haml :vocabulist
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

class String
  def truncate(len=50)
    if self.length < len
      self
    else
      self[0..(len-3)] + "..."
    end
  end
end
