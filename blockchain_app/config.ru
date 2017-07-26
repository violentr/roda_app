#!/usr/bin/env ruby
require 'rest_client'
require_relative 'lib/database'
require 'json'
require "roda"
require "sequel"

class BlockChainApp < Roda

  database = ::Database.start

  route do |r|
    r.root do
      r.redirect "/account/show"
    end

    r.on "account" do
      @accounts = database[:accounts]
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
