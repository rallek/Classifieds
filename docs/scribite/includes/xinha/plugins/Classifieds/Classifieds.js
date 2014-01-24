// Classifieds plugin for Xinha
// developed by Ralf Koester
//
// requires Classifieds module (http://support.zikula.de)
//
// Distributed under the same terms as xinha itself.
// This notice MUST stay intact for use (see license.txt).

'use strict';

function Classifieds(editor) {
    var cfg, self;

    this.editor = editor;
    cfg = editor.config;
    self = this;

    cfg.registerButton({
        id       : 'Classifieds',
        tooltip  : 'Insert Classifieds object',
     // image    : _editor_url + 'plugins/Classifieds/img/ed_Classifieds.gif',
        image    : '/images/icons/extrasmall/favorites.png',
        textMode : false,
        action   : function (editor) {
            var url = Zikula.Config.baseURL + 'index.php'/*Zikula.Config.entrypoint*/ + '?module=Classifieds&type=external&func=finder&editor=xinha';
            ClassifiedsFinderXinha(editor, url);
        }
    });
    cfg.addToolbarElement('Classifieds', 'insertimage', 1);
}

Classifieds._pluginInfo = {
    name          : 'Classifieds for xinha',
    version       : '0.2.0',
    developer     : 'Ralf Koester',
    developer_url : 'http://support.zikula.de',
    sponsor       : 'ModuleStudio 0.6.1',
    sponsor_url   : 'http://modulestudio.de',
    license       : 'htmlArea'
};
