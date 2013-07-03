require 'sinatra'
require 'net/http'
require 'uri'

get '/:username/:type' do
  uri = URI.parse "http://www.readability.com/#{params[:username]}/#{params[:type]}/feed"
  response = Net::HTTP.get_response(uri)
  if response.code.to_i == 200
    headers['Content-Type'] = 'application/rss+xml'
    response.body.gsub %r[http://www.readability.com/read\?url=], ''
  else
    response.code
  end
end
