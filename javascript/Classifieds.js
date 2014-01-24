'use strict';

var clfsContextMenu;

clfsContextMenu = Class.create(Zikula.UI.ContextMenu, {
    selectMenuItem: function ($super, event, item, item_container) {
        // open in new tab / window when right-clicked
        if (event.isRightClick()) {
            item.callback(this.clicked, true);
            event.stop(); // close the menu
            return;
        }
        // open in current window when left-clicked
        return $super(event, item, item_container);
    }
});

/**
 * Initialises the context menu for item actions.
 */
function clfsInitItemActions(objectType, func, containerId)
{
    var triggerId, contextMenu, icon;

    triggerId = containerId + 'Trigger';

    // attach context menu
    contextMenu = new clfsContextMenu(triggerId, { leftClick: true, animation: false });

    // process normal links
    $$('#' + containerId + ' a').each(function (elem) {
        // hide it
        elem.addClassName('z-hide');
        // determine the link text
        var linkText = '';
        if (func === 'display') {
            linkText = elem.innerHTML;
        } else if (func === 'view') {
            elem.select('img').each(function (imgElem) {
                linkText = imgElem.readAttribute('alt');
            });
        }

        // determine the icon
        icon = '';
        if (func === 'display') {
            if (elem.hasClassName('z-icon-es-preview')) {
                icon = 'xeyes.png';
            } else if (elem.hasClassName('z-icon-es-display')) {
                icon = 'kview.png';
            } else if (elem.hasClassName('z-icon-es-edit')) {
                icon = 'edit';
            } else if (elem.hasClassName('z-icon-es-saveas')) {
                icon = 'filesaveas';
            } else if (elem.hasClassName('z-icon-es-delete')) {
                icon = '14_layer_deletelayer';
            } else if (elem.hasClassName('z-icon-es-back')) {
                icon = 'agt_back';
            }
            if (icon !== '') {
                icon = Zikula.Config.baseURL + 'images/icons/extrasmall/' + icon + '.png';
            }
        } else if (func === 'view') {
            elem.select('img').each(function (imgElem) {
                icon = imgElem.readAttribute('src');
            });
        }
        if (icon !== '') {
            icon = '<img src="' + icon + '" width="16" height="16" alt="' + linkText + '" /> ';
        }

        contextMenu.addItem({
            label: icon + linkText,
            callback: function (selectedMenuItem, isRightClick) {
                var url;

                url = elem.readAttribute('href');
                if (isRightClick) {
                    window.open(url);
                } else {
                    window.location = url;
                }
            }
        });
    });
    $(triggerId).removeClassName('z-hide');
}

function clfsCapitaliseFirstLetter(string)
{
    return string.charAt(0).toUpperCase() + string.slice(1);
}

/**
 * Submits a quick navigation form.
 */
function clfsSubmitQuickNavForm(objectType)
{
    $('classifieds' + clfsCapitaliseFirstLetter(objectType) + 'QuickNavForm').submit();
}

/**
 * Initialise the quick navigation panel in list views.
 */
function clfsInitQuickNavigation(objectType, controller)
{
    if ($('classifieds' + clfsCapitaliseFirstLetter(objectType) + 'QuickNavForm') == undefined) {
        return;
    }

    if ($('catid') != undefined) {
        $('catid').observe('change', function () { clfsSubmitQuickNavForm(objectType); });
    }
    if ($('sortby') != undefined) {
        $('sortby').observe('change', function () { clfsSubmitQuickNavForm(objectType); });
    }
    if ($('sortdir') != undefined) {
        $('sortdir').observe('change', function () { clfsSubmitQuickNavForm(objectType); });
    }
    if ($('num') != undefined) {
        $('num').observe('change', function () { clfsSubmitQuickNavForm(objectType); });
    }

    switch (objectType) {
    case 'classified':
        if ($('workflowState') != undefined) {
            $('workflowState').observe('change', function () { clfsSubmitQuickNavForm(objectType); });
        }
        if ($('kind') != undefined) {
            $('kind').observe('change', function () { clfsSubmitQuickNavForm(objectType); });
        }
        if ($('terms') != undefined) {
            $('terms').observe('change', function () { clfsSubmitQuickNavForm(objectType); });
        }
        break;
    default:
        break;
    }
}

/**
 * Initialise ajax-based toggle for boolean fields.
 */
function clfsInitToggle(objectType, fieldName, itemId)
{
    var idSuffix = fieldName + itemId;
    if ($('toggle' + idSuffix) == undefined) {
        return;
    }
    $('toggle' + idSuffix).observe('click', function() {
        clfsToggleFlag(objectType, fieldName, itemId);
    }).removeClassName('z-hide');
}


/**
 * Toggle a certain flag for a given item.
 */
function clfsToggleFlag(objectType, fieldName, itemId)
{
    var pars = 'ot=' + objectType + '&field=' + fieldName + '&id=' + itemId;

    new Zikula.Ajax.Request(
        Zikula.Config.baseURL + 'ajax.php?module=Classifieds&func=toggleFlag',
        {
            method: 'post',
            parameters: pars,
            onComplete: function(req) {
                if (!req.isSuccess()) {
                    Zikula.UI.Alert(req.getMessage(), Zikula.__('Error', 'module_Classifieds'));
                    return;
                }
                var data = req.getData();
                /*if (data.message) {
                    Zikula.UI.Alert(data.message, Zikula.__('Success', 'module_Classifieds'));
                }*/

                var idSuffix = fieldName + '_' + itemId;
                var state = data.state;
                if (state === true) {
                    $('no' + idSuffix).addClassName('z-hide');
                    $('yes' + idSuffix).removeClassName('z-hide');
                } else {
                    $('yes' + idSuffix).addClassName('z-hide');
                    $('no' + idSuffix).removeClassName('z-hide');
                }
            }
        }
    );
}
