module Database

  def self.start
    database = File.join(Dir.pwd, 'db', name.to_s)
    Sequel.sqlite(database)
  end

  def self.name
    'blockchain.sqlite3'
  end
end
