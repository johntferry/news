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

get "/newspaper" do
      results = Geocoder.search(params["q"])
        lat_long = results.first.coordinates # => [lat, long]
    @location = params["q"]
    @lat = "#{lat_long[0]}"
    @long = "#{lat_long[1]}"
    @lat_long = "#{@lat},#{@long}"
    
forecast = ForecastIO.forecast("#{lat_long[0]}","#{lat_long[1]}").to_hash

@current_temp = forecast["currently"]["temperature"]
@conditions = forecast["currently"]["summary"]

url = "http://newsapi.org/v2/top-headlines?country=us&apiKey=ff8a14f637a549a284639672b2ddddce"

@news = HTTParty.get(url).parsed_response.to_hash

for headline in news["articles"]
@top_headlines = "#{headline["title"]} by #{headline["author"]} by #{story["author"]}
end

# puts "#{story["title"]} by #{story["author"]}"

# @top_stories = news["articles"]

# for stories in news["articles"]
#     r "#{stories["title"]} by #{stories["url"]}."
# end
# @top_stories = stories
view "newspaper"
end