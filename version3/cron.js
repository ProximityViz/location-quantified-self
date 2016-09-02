var CronJob = require('cron').CronJob;
// var getNewTracks = require('./get-new-tracks.js');
// var prepMap = require('./prep-map.js');
new CronJob('00 00 * * * *', function() {
  console.log('You will see this message every hour');
  // TODO: wait until getNewTracks completes before running prepMap
}, null, true, 'America/Los_Angeles');
