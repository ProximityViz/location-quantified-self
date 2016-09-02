console.log(layersData); // from layers/layers.js

var layersOnMap = [];

var selectedTimePeriod = 'All';
function changeSelectedTimePeriod(timePeriod) {
  selectedTimePeriod = timePeriod;
  console.log(timePeriod);
  // remove all existing tracks
  for (var i in layersOnMap) {
    if (layersOnMap.hasOwnProperty(i)) {
      var layer = layersOnMap[i];
      console.log(layer);
      map.removeLayer(layer);
    }
  }
  addALayerToTheMap();
  // TODO: change button classes
}

var selectedMode = 'Walking';
function changeSelectedMode(mode) {
  selectedMode = mode;
}

var timePeriodsDiv = document.getElementById('time-periods');
for (var i in layersData) {
  if (layersData.hasOwnProperty(i)) {
    var timePeriod = layersData[i];
    var timePeriodString = "'" + i + "'";
    var classes = i === selectedTimePeriod ? 'class="selected"' : '';
    timePeriodsDiv.innerHTML = timePeriodsDiv.innerHTML + '<button onclick="changeSelectedTimePeriod(' + timePeriodString + ')"' + classes + '>' + i + '</button>';
  }
}

var modesDiv = document.getElementById('modes');
var modes = [];
var colors = ["#494846", "#0c7229", "#f07300", "#633301"];
// TODO: change this to not be dependent on there being a 'Year' layer
for (var i in layersData['Year']) {
  if (layersData['Year'].hasOwnProperty(i)) {
    var mode = layersData['Year'][i];
    modeString = "'" + i + "'";
    modesDiv.innerHTML = modesDiv.innerHTML + '<button onclick="changeSelectedMode(' + modeString + ')">' + i + '</button>';
    modes.push(mode);
  }
}

// MAP
// TODO: consider moving other stuff into another file
var map = L.map('map').setView([33.8, -84.4], 10);


L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpandmbXliNDBjZWd2M2x6bDk3c2ZtOTkifQ._QA7i5Mpkd_m30IGElHziw', {
  maxZoom: 18,
  attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
    '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    'Imagery © <a href="http://mapbox.com">Mapbox</a>',
  id: 'mapbox.light'
}).addTo(map);

var bikingStyle = {
  "color": colors[2],
  "weight": 5,
  "opacity": 0.5
};

function addALayerToTheMap() {
  var aLayer = L.geoJson(layersData[selectedTimePeriod][selectedMode], {
    style: bikingStyle
  });
  layersOnMap.push(aLayer);
  aLayer.addTo(map);
}
addALayerToTheMap();

// TODO: map default (day or all and all)
// TODO: give those buttons a "selected" class
// TODO: activate buttons
// TODO: color map by mode
// TODO: color mode buttons by mode colors
