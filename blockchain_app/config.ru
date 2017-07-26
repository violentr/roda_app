#!/usr/bin/env ruby
require 'rest_client'
require 'json'
require "roda"
require "sequel"

class BlockChainApp < Roda

  database = Dir.pwd + '/db/blockchain.sqlite3'
  DB = Sequel.connect(adapter: "sqlite", database: database, host: "127.0.0.1")

  route do |r|
    r.root do
      r.redirect "/account/show"
    end

    r.on "account" do
      @accounts = DB[:accounts]
      @accounts.all.each do |_account|
        puts "Address #{_account[:address]} Balance: #{_account[:balance]}"
      end

      r.get "show" do
        "#{@accounts.all.to_json}"
      end

      r.post "create" do
        ethernum = r.params["ethernum"]
        url = 'https://etherchain.org/api/account/'+ethernum.to_s
        response = ::RestClient.get(url)
        output = ::JSON.parse(response.body)
        account = OpenStruct.new(output['data']&.first)
        return {} if output["data"].empty?
        @accounts.insert(address: account.address, balance: account.balance)
        r.redirect '/accounts/show'
      end
    end
  end
end

run BlockChainApp.freeze.app
