var fs = require('fs');
var pg = require('pg')
var QueryStream = require('pg-query-stream')
var JSONStream = require('JSONStream')

pg.connect(function(err, client, done) {
  if(err) throw err;
  var query = new QueryStream('SELECT * FROM generate_series(0, $1) num', [1000000])
  var stream = client.query(query)
  stream.on('end', done)
  stream.pipe(JSONStream.stringify()).pipe(process.stdout)
});
