require 'sinatra'
require 'json'

helpers do
  def json_filename
    base_dir = File.expand_path(File.dirname(__FILE__))
    base_dir + '/jsonjar.json'
  end
end

before do
  if File.exist?(json_filename)
    open(json_filename) {|f|
      @json = JSON.parse(f.read)
    }
  else
    @json = {}
  end
end

get '/' do
  params.each {|k, v|
    @json[k] = v
  }
  @json.to_json
end

after do
  open(json_filename, 'w') {|f|
    f.write(@json.to_json)
  }
end
