require 'sinatra'
require 'mongoid'

require_relative 'models/jar'

Mongoid.load!('config/mongoid.yml')

get '/' do
  @jar = Jar.latest || Jar.new

  params.each {|k, v|
    @jar.data[k] = v
  }

  halt 503, "failed to save jar: #{jar.errors.full_messages.join(',')}" unless @jar.save

  @jar.to_json
end
