var fs = require('fs');
var pg = require('pg')
var geojsonStream = require('geojson-stream');
var QueryStream = require('pg-query-stream')
var stream = require('stream');
var JSONStream = require('JSONStream');
var turf = require('turf');

BezierCurve = new stream.Transform({
  objectMode: true,
  transform: function(chunk, encoding, callback) {
    var feature  = {
        type: "Feature",
        geometry: JSON.parse(chunk.geom),
        properties: {},
    };

    var curvedFeature = turf.bezier(feature);
    curvedFeature.properties = feature.properties;
    callback(null, curvedFeature);
  }
});

pg.connect(function(err, client, done) {
  if(err) throw err;
  var query = new QueryStream('SELECT osm_id AS osmId, ST_AsGeoJSON(ST_Transform(geometry,4326)) AS geom FROM lake_label LIMIT 10')
  var pgStream = client.query(query)
  pgStream.on('end', done);

  pgStream.pipe(BezierCurve)
          .pipe(geojsonStream.stringify())
          .pipe(process.stdout);
});
