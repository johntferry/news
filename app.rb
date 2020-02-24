require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "220801cf91d4be60ef407d58d2e5fe4c"

get "/" do
    view "ask"
end

get "/news" do
      results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat, long]
    @lat = "#{lat_long[0]}"
    @long = "#{lat_long[1]}"
    @lat_long = "#{@lat},#{@long}"
    view "news"
end