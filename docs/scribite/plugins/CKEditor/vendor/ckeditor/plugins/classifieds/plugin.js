CKEDITOR.plugins.add('Classifieds', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertClassifieds', {
            exec: function (editor) {
                var url = Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=Classifieds&type=external&func=finder&editor=ckeditor';
                // call method in Classifieds_Finder.js and also give current editor
                ClassifiedsFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('classifieds', {
            label: 'Insert Classifieds object',
            command: 'insertClassifieds',
         // icon: this.path + 'images/ed_classifieds.png'
            icon: '/images/icons/extrasmall/favorites.png'
        });
    }
});
