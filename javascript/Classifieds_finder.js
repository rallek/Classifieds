'use strict';

var currentClassifiedsEditor = null;
var currentClassifiedsInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getPopupAttributes()
{
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;
    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function ClassifiedsFinderXinha(editor, clfsURL)
{
    var popupAttributes;

    // Save editor for access in selector window
    currentClassifiedsEditor = editor;

    popupAttributes = getPopupAttributes();
    window.open(clfsURL, '', popupAttributes);
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function ClassifiedsFinderCKEditor(editor, clfsURL)
{
    // Save editor for access in selector window
    currentClassifiedsEditor = editor;

    editor.popup(
        Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=Classifieds&type=external&func=finder&editor=ckeditor',
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}



var classifieds = {};

classifieds.finder = {};

classifieds.finder.onLoad = function (baseId, selectedId)
{
    $$('div.categoryselector select').invoke('observe', 'change', classifieds.finder.onParamChanged);
    $('classifiedsSort').observe('change', classifieds.finder.onParamChanged);
    $('classifiedsSortDir').observe('change', classifieds.finder.onParamChanged);
    $('classifiedsPageSize').observe('change', classifieds.finder.onParamChanged);
    $('classifiedsSearchGo').observe('click', classifieds.finder.onParamChanged);
    $('classifiedsSearchGo').observe('keypress', classifieds.finder.onParamChanged);
    $('classifiedsSubmit').addClassName('z-hide');
    $('classifiedsCancel').observe('click', classifieds.finder.handleCancel);
};

classifieds.finder.onParamChanged = function ()
{
    $('classifiedsSelectorForm').submit();
};

classifieds.finder.handleCancel = function ()
{
    var editor, w;

    editor = $F('editorName');
    if (editor === 'xinha') {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        clfsClosePopup();
    } else if (editor === 'ckeditor') {
        clfsClosePopup();
    } else {
        alert('Close Editor: ' + editor);
    }
};


function getPasteSnippet(mode, itemId)
{
    var itemUrl, itemTitle, itemDescription, pasteMode;

    itemUrl = $F('url' + itemId);
    itemTitle = $F('title' + itemId);
    itemDescription = $F('desc' + itemId);
    pasteMode = $F('classifiedsPasteAs');

    if (pasteMode === '2' || pasteMode !== '1') {
        return itemId;
    }

    // return link to item
    if (mode === 'url') {
        // plugin mode
        return itemUrl;
    } else {
        // editor mode
        return '<a href="' + itemUrl + '" title="' + itemDescription + '">' + itemTitle + '</a>';
    }
}


// User clicks on "select item" button
classifieds.finder.selectItem = function (itemId)
{
    var editor, html;

    editor = $F('editorName');
    if (editor === 'xinha') {
        if (window.opener.currentClassifiedsEditor !== null) {
            html = getPasteSnippet('html', itemId);

            window.opener.currentClassifiedsEditor.focusEditor();
            window.opener.currentClassifiedsEditor.insertHTML(html);
        } else {
            html = getPasteSnippet('url', itemId);
            var currentInput = window.opener.currentClassifiedsInput;

            if (currentInput.tagName === 'INPUT') {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if (currentInput.tagName === 'TEXTAREA') {
                // Try to paste into textarea - technique depends on environment
                if (typeof document.selection !== 'undefined') {
                    // IE: Move focus to textarea (which fortunately keeps its current selection) and overwrite selection
                    currentInput.focus();
                    window.opener.document.selection.createRange().text = html;
                } else if (typeof currentInput.selectionStart !== 'undefined') {
                    // Firefox: Get start and end points of selection and create new value based on old value
                    var startPos = currentInput.selectionStart;
                    var endPos = currentInput.selectionEnd;
                    currentInput.value = currentInput.value.substring(0, startPos)
                                        + html
                                        + currentInput.value.substring(endPos, currentInput.value.length);
                } else {
                    // Others: just append to the current value
                    currentInput.value += html;
                }
            }
        }
    } else if (editor === 'tinymce') {
        html = getPasteSnippet('html', itemId);
        window.opener.tinyMCE.activeEditor.execCommand('mceInsertContent', false, html);
        // other tinymce commands: mceImage, mceInsertLink, mceReplaceContent, see http://www.tinymce.com/wiki.php/Command_identifiers
    } else if (editor === 'ckeditor') {
        /** to be done*/
    } else {
        alert('Insert into Editor: ' + editor);
    }
    clfsClosePopup();
};


function clfsClosePopup()
{
    window.opener.focus();
    window.close();
}




//=============================================================================
// Classifieds item selector for Forms
//=============================================================================

classifieds.itemSelector = {};
classifieds.itemSelector.items = {};
classifieds.itemSelector.baseId = 0;
classifieds.itemSelector.selectedId = 0;

classifieds.itemSelector.onLoad = function (baseId, selectedId)
{
    classifieds.itemSelector.baseId = baseId;
    classifieds.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $('classifiedsObjectType').observe('change', classifieds.itemSelector.onParamChanged);

    if ($(baseId + '_catidMain') != undefined) {
        $(baseId + '_catidMain').observe('change', classifieds.itemSelector.onParamChanged);
    } else if ($(baseId + '_catidsMain') != undefined) {
        $(baseId + '_catidsMain').observe('change', classifieds.itemSelector.onParamChanged);
    }
    $(baseId + 'Id').observe('change', classifieds.itemSelector.onItemChanged);
    $(baseId + 'Sort').observe('change', classifieds.itemSelector.onParamChanged);
    $(baseId + 'SortDir').observe('change', classifieds.itemSelector.onParamChanged);
    $('classifiedsSearchGo').observe('click', classifieds.itemSelector.onParamChanged);
    $('classifiedsSearchGo').observe('keypress', classifieds.itemSelector.onParamChanged);

    classifieds.itemSelector.getItemList();
};

classifieds.itemSelector.onParamChanged = function ()
{
    $('ajax_indicator').removeClassName('z-hide');

    classifieds.itemSelector.getItemList();
};

classifieds.itemSelector.getItemList = function ()
{
    var baseId, pars, request;

    baseId = classifieds.itemSelector.baseId;
    pars = 'ot=' + baseId + '&';
    if ($(baseId + '_catidMain') != undefined) {
        pars += 'catidMain=' + $F(baseId + '_catidMain') + '&';
    } else if ($(baseId + '_catidsMain') != undefined) {
        pars += 'catidsMain=' + $F(baseId + '_catidsMain') + '&';
    }
    pars += 'sort=' + $F(baseId + 'Sort') + '&' +
            'sortdir=' + $F(baseId + 'SortDir') + '&' +
            'searchterm=' + $F(baseId + 'SearchTerm');

    request = new Zikula.Ajax.Request('ajax.php?module=Classifieds&func=getItemListFinder', {
        method: 'post',
        parameters: pars,
        onFailure: function(req) {
            Zikula.showajaxerror(req.getMessage());
        },
        onSuccess: function(req) {
            var baseId;
            baseId = classifieds.itemSelector.baseId;
            classifieds.itemSelector.items[baseId] = req.getData();
            $('ajax_indicator').addClassName('z-hide');
            classifieds.itemSelector.updateItemDropdownEntries();
            classifieds.itemSelector.updatePreview();
        }
    });
};

classifieds.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = classifieds.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    itemSelector.length = 0;

    items = classifieds.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (classifieds.itemSelector.selectedId > 0) {
        $(baseId + 'Id').value = classifieds.itemSelector.selectedId;
    }
};

classifieds.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = classifieds.itemSelector.baseId;
    items = classifieds.itemSelector.items[baseId];

    $(baseId + 'PreviewContainer').addClassName('z-hide');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (classifieds.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === classifieds.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (selectedElement !== null) {
        $(baseId + 'PreviewContainer').update(window.atob(selectedElement.previewInfo))
                                      .removeClassName('z-hide');
    }
};

classifieds.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = classifieds.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    preview = window.atob(classifieds.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + 'PreviewContainer').update(preview);
    classifieds.itemSelector.selectedId = $F(baseId + 'Id');
};
