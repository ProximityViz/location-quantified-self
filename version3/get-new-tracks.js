var request = require('request');
var fs = require('fs');
var tokens = require('./tokens.js');
var tracks = require('./tracks/list-of-tracks.json');

// see what the last track was that we pulled
var lastSavedTrack;
if (tracks[tracks.length - 1].status === 'saved') {
  lastSavedTrack = tracks[tracks.length - 1].name
} else {
  // TODO: handle unsaved track
}

// get recent runkeeper tracks
function downloadUndownloadedTracks() {
  request({
    url: 'http://api.runkeeper.com/fitnessActivities',
    headers: {
      'Authorization': 'Bearer ' + tokens.runkeeper
    }
  }, function (error, response, body) {
    if (!error && response.statusCode == 200) {
      var items = JSON.parse(body).items;
      for (var i in items) {
        if (items.hasOwnProperty(i)) {
          var item = items[i];
          if (item.uri.substr(item.uri.lastIndexOf("/") + 1) === lastSavedTrack) {
            break;
          } else {
            // save track to list to download
            downloadNewTrack(item);
          }
        }
      }
    }
  });
}

downloadUndownloadedTracks();

function downloadNewTrack(item) {
  var trackURI = item.uri;
  console.log(trackURI);
  var trackName = trackURI.substr(trackURI.lastIndexOf("/") + 1);
  // download track
  request({
    url: 'http://api.runkeeper.com' + trackURI,
    headers : {
      'Authorization': 'Bearer ' + tokens.runkeeper
    }
  }, function (error, response, body) {
    if (!error && response.statusCode == 200) {
      // write body to file
      fs.writeFile('./tracks/' + trackName + '.json', body, function(error) {
        if(error) {
          return console.log(error);
        }
      });
    }
  });

  // save to list-of-tracks.json
  // TODO: save start_time
  tracks.push({
    "utc_offset": item.utc_offset,
    "duration": item.duration,
    "start_time": item.start_time,
    "total_calories": item.total_calories,
    "tracking_mode": item.tracking_mode,
    "total_distance": item.total_distance,
    "entry_mode": item.entry_mode,
    "has_path": item.has_path,
    "source": item.source,
    "mode": item.type,
    "name": trackName,
    "status": "saved"
  });
  fs.writeFile('./tracks/list-of-tracks.json', JSON.stringify(tracks));
}

