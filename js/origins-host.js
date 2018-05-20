$(function() {
    var fileToRun = '';
    var selectedIndex = 0;
    var windowBounds = {
        start: 0,
        end: 12
    };

    window.dosbox = new Dosbox({
        id: 'dosbox',
        onload: function(dosbox) {
            dosbox.run('qbasic.zip', './' + window.files[selectedIndex].command);
        },
        onrun: function(dosbox, app) {
            $('#fullscreen-button').prop('disabled', false);
        }
    });

    function renderList(selectedIndex) {
        var $fileNameContainer = $('.file-name-container');
        var newInnerHTML = '';

        // window.files is populated in files.js
        window.files.forEach(function(file, index) {
            if (index < windowBounds.start) return;
            if (index > windowBounds.end) return;

            var isSelected = selectedIndex === index;
            var text = isSelected
                ? '&gt;&nbsp;' + file.name + '&nbsp;&lt;'
                : '&nbsp;&nbsp;' + file.name + '&nbsp;&nbsp;';
            var fileHtml =
                '<div class="file-name' +
                (isSelected ? ' selected' : '') +
                '">' +
                text +
                '</div>';
            newInnerHTML += fileHtml;
        });

        $fileNameContainer.html(newInnerHTML);
    }

    renderList(selectedIndex);

    var jumpTimer;
    var jumpPhrase = '';

    var $window = $(window);

    function handleKeydowns(ev) {
        if (ev.which === 40) {
            // down
            selectedIndex = Math.min(
                window.files.length - 1,
                selectedIndex + 1
            );
            if (windowBounds.end <= selectedIndex) {
                windowBounds.start++;
                windowBounds.end++;
            }

            renderList(selectedIndex);
        } else if (ev.which === 38) {
            // up
            selectedIndex = Math.max(0, selectedIndex - 1);
            if (windowBounds.start > selectedIndex) {
                windowBounds.start--;
                windowBounds.end--;
            }

            renderList(selectedIndex);
        } else if (ev.which === 13) {
            selectCurrentFile();
        } else if (ev.which >= 65 && ev.which <= 90) {
            clearTimeout(jumpTimer);

            jumpPhrase += String.fromCharCode(ev.which);

            var filesClone = window.files.map(function(f) {
                return f.name;
            });
            filesClone.push(jumpPhrase);
            filesClone = filesClone.sort();
            selectedIndex = filesClone.indexOf(jumpPhrase);

            if (
                selectedIndex < windowBounds.start ||
                selectedIndex > windowBounds.end
            ) {
                windowBounds.start = Math.min(window.files.length - 12, selectedIndex - 1);
                windowBounds.end = windowBounds.start + 12;


            }
            renderList(selectedIndex);

            jumpTimer = setTimeout(function() {
                jumpPhrase = '';
            }, 1000);
        }
    }

    function selectCurrentFile() {
        $('.dosbox-start').click();
        $('#origins-overlay').hide();
        $window.off('keydown', handleKeydowns);
    }

    $window.on('keydown', handleKeydowns);

    // if a filename was passed through a query parameter,
    // i.e. https://nathanfriend.io/subpath/another?file=advnture.bas
    // then auto-load that file if it exists.
    var initialFileName = getQueryParameterByName('file');
    if (initialFileName) {
        var initialFile = window.files.filter(function(f) {
            return f.name.toLowerCase() === initialFileName.toLowerCase();
        })[0];

        console.log('initialFile:', initialFile);
        if (initialFile) {
            selectedIndex = window.files.indexOf(initialFile);
            selectCurrentFile();
        }
    }

    function getQueryParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, '\\$&');
        var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }

    window.reloadPage = function() {
        console.log(window.location.href);
        window.location.href = window.location.href.replace(/\?.*$/, '');
        //window.location.reload();
    };
});
