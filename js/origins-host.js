$(function() {
    var dosbox = new Dosbox({
        id: 'dosbox',
        onload: function(dosbox) {
            dosbox.run('qb11.zip', './QBASIC.EXE');
        },
        onrun: function(dosbox, app) {
            $('#fullscreen-button').prop('disabled', false);
        }
    });

    var selectedIndex = 0;
    var windowBounds = {
        start: 0,
        end: 12
    };

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

    var $window = $(window);

    $window.on('keydown', function(ev) {
        if (ev.which === 40) {
            // down
            selectedIndex = Math.min(window.files.length - 1, selectedIndex + 1);
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
            alert(selectedIndex);
        }
    });

    //document.querySelector('.dosbox-start').click();
});
