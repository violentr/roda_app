module Database

  def self.start
    database = Dir.pwd + "/db/#{name}"
    Sequel.connect(adapter: "sqlite", database: database, host: "127.0.0.1")
  end
  def self.name
    'blockchain.sqlite3'
  end
end
