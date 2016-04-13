require 'sinatra'

require 'nokogiri'
require 'open-uri'
   
def h(text)
  Rack::Utils.escape_html(text)
end

get '/' do
  # TODO cache response
  page = Nokogiri::HTML(open("https://www.fitbit.com/user/25BHT6/weight"))   
  weight = page.css('#curWeight').text

  <<-EOS
    <!doctype html>
    <html>
    <head>
      <title>How fat is Ryan?</title>
      <style>
        html, body {
          margin: 0;
          font-family: helvetica, sans-serif;
        }
        #container {
          box-sizing: border-box;
          margin: auto 0;
          margin-bottom: auto;
          height: 100%;
          width: 100%;
          position: fixed;
          vertical-align: 50%;
          padding-top: 10%;
          background-color: #00a;
          color: #aaa;
        }
        h1 {
          text-align: center;
          font-size: 2rem;
        }
        .weight {
          text-align: center;
          font-size: 1.7rem;
        }
      </style>
    </head>
    <body>
      <div id="container">
        <h1>How fat is Ryan?</h1>
        <div class="weight">
          #{h weight}
        </div>
      </div>
    </body>
    </html>
  EOS
end
