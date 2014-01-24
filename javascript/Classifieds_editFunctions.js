'use strict';


/**
 * Resets the value of an upload / file input field.
 */
function clfsResetUploadField(fieldName)
{
    if ($(fieldName) != undefined) {
        $(fieldName).setAttribute('type', 'input');
        $(fieldName).setAttribute('type', 'file');
    }
}

/**
 * Initialises the reset button for a certain upload input.
 */
function clfsInitUploadField(fieldName)
{
    if ($('reset' + fieldName.capitalize() + 'Val') != undefined) {
        $('reset' + fieldName.capitalize() + 'Val').observe('click', function (evt) {
            evt.preventDefault();
            clfsResetUploadField(fieldName);
        }).removeClassName('z-hide');
    }
}

/**
 * Resets the value of a date or datetime input field.
 */
function clfsResetDateField(fieldName)
{
    if ($(fieldName) != undefined) {
        $(fieldName).value = '';
    }
    if ($(fieldName + 'cal') != undefined) {
        $(fieldName + 'cal').update(Zikula.__('No date set.', 'module_Classifieds'));
    }
}

/**
 * Initialises the reset button for a certain date input.
 */
function clfsInitDateField(fieldName)
{
    if ($('reset' + fieldName.capitalize() + 'Val') != undefined) {
        $('reset' + fieldName.capitalize() + 'Val').observe('click', function (evt) {
            evt.preventDefault();
            clfsResetDateField(fieldName);
        }).removeClassName('z-hide');
    }
}

