require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "YOUR-API-KEY"

get "/" do
    view "ask" # show a view that asks for the location
end

get "/news" do
      results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat, long]
    "#{lat_long[0]} #{lat_long[1]}"
    # do everything else
end