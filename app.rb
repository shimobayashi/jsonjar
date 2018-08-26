require 'sinatra'
require 'mongoid'

require_relative 'models/jar'

Mongoid.load!('config/mongoid.yml')

get '/' do
  @jar = Jar.latest || Jar.new

  params.each {|k, v|
    value = v
    value = Time.now.to_i.to_s if value == '%TIMES' # Taskerと同じ書き方でUNIXTIMEを挿入できる
    @jar.data[k] = value
  }

  halt 503, "failed to save jar: #{jar.errors.full_messages.join(',')}" unless @jar.save

  @jar.to_json
end
