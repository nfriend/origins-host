var dosbox = new Dosbox({
    id: 'dosbox',
    onload: function(dosbox) {
        dosbox.run('qb11.zip', './QBASIC.EXE');
    },
    onrun: function(dosbox, app) {
        document
            .querySelector('#fullscreen-button')
            .removeAttribute('disabled');
    }
});

window.files.forEach(function(f) {
    var fileHtml = '<div class="file-name">&gt; ' + f + '</div>'
    document.querySelector('.file-name-container').innerHTML += fileHtml;
});

//document.querySelector('.dosbox-start').click();
