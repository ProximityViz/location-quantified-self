var moment = require('moment');
var fs = require('fs');
var tracks = require('./tracks/list-of-tracks.json');

var rightNow = moment();

// get all modes used in tracks
function getModes() {
  var modesObject = {};
  var modes = [];
  for (var i in tracks) {
    if (tracks.hasOwnProperty(i)) {
      var mode = tracks[i].mode;
      if (typeof(modesObject[tracks[i].mode]) === 'undefined') {
        modes.push(tracks[i].mode);
      }
      modesObject[tracks[i].mode] = 0;
    }
  }
  return modes;
}

// eventually this should be an option set by the user, not in this file
function renameModes(modes) {
  var modesObject = {};
  for (var i in modes) {
    if (modes.hasOwnProperty(i)) {
      var mode = modes[i];
      if (mode === 'Other') {
        modesObject[mode] = 'Car or Transit';
      } else {
        modesObject[mode] = mode;
      }
    }
  }
  return modesObject;
}

var modeRenameObject = renameModes(getModes());

var metaObject = {};
var timePeriods = ['Day', 'Month', 'Year', 'All'];
function createMetaObject() {
  for (var i in timePeriods) {
    if (timePeriods.hasOwnProperty(i)) {
      var timePeriod = timePeriods[i];
      metaObject[timePeriod] = {};
      for (var j in modeRenameObject) {
        if (modeRenameObject.hasOwnProperty(j)) {
          var mode = modeRenameObject[j];
          metaObject[timePeriod][mode] = [];
        }
      }
    }
  }
}
createMetaObject();

// categorize tracks
for (var i in tracks) {
  if (tracks.hasOwnProperty(i)) {
    var track = tracks[i];
    var time = track.start_time;
    var daysAgo = rightNow.diff(moment(time, 'ddd, D MMM YYYY HH:mm:ss'), 'days');
    var hoursAgo = rightNow.diff(moment(time, 'ddd, D MMM YYYY HH:mm:ss'), 'hours');
    var trackMode = modeRenameObject[track.mode];
    var trackCoords = getLine(fs.readFileSync('./tracks/' + track.name + '.json', 'utf8'));
    metaObject['All'][trackMode].push(trackCoords);
    if (daysAgo <= 1 && hoursAgo <= 24) {
      metaObject['Day'][trackMode].push(trackCoords);
      metaObject['Month'][trackMode].push(trackCoords);
      metaObject['Year'][trackMode].push(trackCoords);
    } else if (daysAgo <= 30) {
      metaObject['Month'][trackMode].push(trackCoords);
      metaObject['Year'][trackMode].push(trackCoords);
    } else if (daysAgo <= 365) {
      metaObject['Year'][trackMode].push(trackCoords);
    }
  }
}

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

function saveLayers() {
  fs.writeFile('./layers/layers.js', 'var layersData = ' + JSON.stringify(metaObject) + ';');
}
// function saveLayers() {
//   for (var i in metaObject) {
//     if (metaObject.hasOwnProperty(i)) {
//       var timePeriodData = metaObject[i];
//       var timePeriod = i;
//       for (var j in timePeriodData) {
//         if (timePeriodData.hasOwnProperty(j)) {
//           var modeData = timePeriodData[j];
//           var mode = j;
//           var fileName = timePeriod + ' ' + mode;
//           fs.writeFile('./layers/' + fileName + '.json', JSON.stringify(metaObject[timePeriod][mode]));
//           // TODO: maybe these should be JS instead of JSON for easier file reading
//         }
//       }
//     }
//   }
// }
saveLayers(); // TODO: this output should be mappable in Leaflet (see http://leafletjs.com/examples/geojson.html)

// the below aren't needed if we use layers.js
// TODO: write modeRenameObject to a file
// TODO: write timePeriods to a file (or maybe better, read it from a file)
