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
#get the location
      results = Geocoder.search(params["q"])
        lat_long = results.first.coordinates
    @location = params["q"]
    @lat = "#{lat_long[0]}"
    @long = "#{lat_long[1]}"
    @lat_long = "#{@lat},#{@long}"
    
#get the weather

@forecast = ForecastIO.forecast("#{lat_long[0]}","#{lat_long[1]}").to_hash

@current_temp = @forecast["currently"]["temperature"]
@conditions = @forecast["currently"]["summary"]

    #get the news
url = "http://newsapi.org/v2/top-headlines?country=us&apiKey=ff8a14f637a549a284639672b2ddddce"

@news = HTTParty.get(url).parsed_response.to_hash

    headline_url = []
    for headlines in @news["articles"]
        headline_url << "#{headlines["url"]}"
    end
    @topurls = headline_url

    headline_title = []
    for headlinetitles in @news["articles"]
        headline_title << "#{headlinetitles["title"]}"
    end
    @toptitles = headline_title

# @article_title = news["title"]
# @article_author = news["author"]
# @article_url = news["url"]


# for headline in @news["articles"]
#     << "#{headline["title"]} by #{headline["author"]}"
# end

# puts "#{story["title"]} by #{story["author"]}"

# @top_stories = news["articles"]

# for stories in news["articles"]
#     r "#{stories["title"]} by #{stories["url"]}."
# end
# @top_stories = stories
view "newspaper"
end