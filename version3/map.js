console.log(layersData); // from layers/layers.js

var selectedTimePeriod = 'Day';
function changeSelectedTimePeriod(timePeriod) {
  selectedTimePeriod = timePeriod;
  console.log(timePeriod);
}

var selectedMode = 'All';
function changeSelectedMode(mode) {
  selectedMode = mode;
}

var timePeriodsDiv = document.getElementById('time-periods');
var modesDiv = document.getElementById('modes');
for (var i in layersData) {
  if (layersData.hasOwnProperty(i)) {
    var timePeriod = layersData[i];
    timePeriodString = "'" + i + "'";
    timePeriodsDiv.innerHTML = timePeriodsDiv.innerHTML + '<button onclick="changeSelectedTimePeriod(' + timePeriodString + ')">' + i + '</button>';
  }
}

// TODO: change this to not be dependent on there being a 'Year' layer
for (var i in layersData['Year']) {
  if (layersData['Year'].hasOwnProperty(i)) {
    var mode = layersData['Year'][i];
    modeString = "'" + i + "'";
    modesDiv.innerHTML = modesDiv.innerHTML + '<button onclick="changeSelectedMode(' + modeString + ')">' + i + '</button>';
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

L.geoJson(layersData['Year']['Hiking']).addTo(map);
// TODO: map default (day or all and all)
// TODO: give those buttons a "selected" class
// TODO: activate buttons
// TODO: color map by mode
// TODO: color mode buttons by mode colors
