const watch = require('node-watch');
const zip = require('./zip');

zip();

watch('qbasic', { recursive: true }, function(evt, name) {
    console.log('%s changed.', name);
    zip();
});
