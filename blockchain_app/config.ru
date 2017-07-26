#!/usr/bin/env ruby
require 'rest_client'
require 'json'
require "roda"

class BlockChainApp < Roda

  require "roda"
  require "sequel"
  database = "blockchain_db"
  DB = Sequel.connect(adapter: "sqlite", database: database, host: "127.0.0.1")

  route do |r|
    # GET / request
    r.root do
      r.redirect "/show"
    end

    # /hello branch
    r.on "show" do
      # Set variable for all routes in /hello branch
      ethernum = request.params["ethernum"]
      url = 'https://etherchain.org/api/account/'+ethernum.to_s
      response = ::RestClient.get(url)
      output = ::JSON.parse(response.body)
      account = OpenStruct.new(output['data'].first)
      @balance = account.balance || "Nothing found for: " + ethernum.to_s

      # GET /hello/world request
      r.get "world" do
        "#{@greeting} world!"
      end
      # /hello request

      r.is do
        # GET /hello request
        r.get do
          "#{@balance}"
        end

        # POST /hello request
        r.post do
          puts "Someone said #{@greeting}!"
          r.redirect
        end
      end
    end
  end
end

run BlockChainApp.freeze.app
