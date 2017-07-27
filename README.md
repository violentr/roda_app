# Roda project

* PREPARATION

>gem install bundle

>bundle

>rake db:create_table

Will create db.sqlite3 database and :accounts table

>rake db:drop_table  (if necessary)

Will drop :accounts table

>rackup

Will start application

USAGE

GET request

>curl http://localhost:9393/account/show

-- Shows records from db in JSON format

POST request

>curl --data "ethernum=your_id_here" http://localhost:9393/account/create

please make sure port is set correctly, in this example it is 9393

-- Creates call to external API with ethernum id as a parameter,
responds with JSON data, balance for the eternum_id saved to local db.

```{
"status": 1,
"data": [
{
"address": "0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad",
"balance": 1989580000000000000,
"nonce": null,
"code": "0x",
"name": null,
"storage": null,
"firstSeen": "2016-12-01T11:46:23.000Z"
}
]
}
```


Enjoy & Have Fun!
