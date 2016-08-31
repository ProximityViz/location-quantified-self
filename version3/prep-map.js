var moment = require('moment');
var fs = require('fs');
var tracks = require('./tracks/list-of-tracks.json');

var rightNow = moment();

var lastYear = []; // TODO: might not need these; just build geojson files in original for loop
var lastMonth = [];
var lastDay = [];
var allTracks = [];

for (var i in tracks) {
  if (tracks.hasOwnProperty(i)) {
    var track = tracks[i];
    var time = track.start_time;
    var daysAgo = rightNow.diff(moment(time, 'ddd, D MMM YYYY HH:mm:ss'), 'days');
    var hoursAgo = rightNow.diff(moment(time, 'ddd, D MMM YYYY HH:mm:ss'), 'hours');
    allTracks.push(track.name);
    var trackCoords = getLine(fs.readFileSync('./tracks/' + track.name + '.json', 'utf8'));
    if (daysAgo <= 1 && hoursAgo <= 24) {
      lastDay.push(trackCoords);
      lastMonth.push(trackCoords);
      lastYear.push(trackCoords);
    } else if (daysAgo <= 30) {
      lastMonth.push(trackCoords);
      lastYear.push(trackCoords);
    } else if (daysAgo <= 365) {
      lastYear.push(trackCoords);
    }
  }
}

console.log(JSON.stringify(lastDay)); // TODO: this output should be mappable in Leaflet (see http://leafletjs.com/examples/geojson.html)
// console.log(lastMonth);

function getLine(file) {
  var coordinates = [];
  var path = JSON.parse(file).path;
  for (var i in path) {
    if (path.hasOwnProperty(i)) {
      var point = path[i];
      coordinates.push([point.longitude, point.latitude]);
    }
  }

  return {"type": "LineString", "coordinates": coordinates};
}


// this file should output one geojson file per relevant time period
