{* purpose of this template: build the Form to edit an instance of classified *}
{include file='user/header.tpl'}
{pageaddvar name='javascript' value='modules/Classifieds/javascript/Classifieds_editFunctions.js'}
{pageaddvar name='javascript' value='modules/Classifieds/javascript/Classifieds_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit classified' assign='templateTitle'}
{elseif $mode eq 'create'}
    {gt text='Create classified' assign='templateTitle'}
{else}
    {gt text='Edit classified' assign='templateTitle'}
{/if}
<div class="classifieds-classified classifieds-edit">
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {classifiedsFormFrame}
    {formsetinitialfocus inputId='title'}

    <fieldset>
        <legend>{gt text='Content++'}</legend>
        
        <div class="z-formrow">
            {formlabel for='title' __text='Title' mandatorysym='1' cssClass=''}
            {formtextinput group='classified' id='title' mandatory=true readOnly=false __title='Enter the title of the classified' textMode='singleline' maxLength=255 cssClass='required' }
            {classifiedsValidationError id='title' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='kind' __text='Kind' mandatorysym='1' cssClass=''}
            {formdropdownlist group='classified' id='kind' mandatory=true __title='Choose the kind' selectionMode='single'}
        </div>
        
        <div class="z-formrow">
            {gt text='the description of your offer or what you are looking for' assign='toolTip'}
            {formlabel for='description' __text='Description' mandatorysym='1' cssClass='classifieds-form-tooltips' title=$toolTip}
            {formtextinput group='classified' id='description' mandatory=true __title='Enter the description of the classified' textMode='multiline' rows='6' cols='50' cssClass='required' }
            {classifiedsValidationError id='description' class='required'}
        </div>
        
        <div class="z-formrow">
            {gt text='The price you are willing to pay or what you want to get for your offer' assign='toolTip'}
            {formlabel for='price' __text='Price' cssClass='classifieds-form-tooltips' title=$toolTip}
                {formfloatinput group='classified' id='price' mandatory=false __title='Enter the price of the classified' maxLength=15 cssClass=' validate-number' }
            {classifiedsValidationError id='price' class='validate-number'}
        </div>
        
        <div class="z-formrow">
            {gt text='the contact to your classified' assign='toolTip'}
            {formlabel for='email' __text='Email' mandatorysym='1' cssClass='classifieds-form-tooltips' title=$toolTip}
                {formemailinput group='classified' id='email' mandatory=true readOnly=false __title='Enter the email of the classified' textMode='singleline' maxLength=255 cssClass='required validate-email' }
            {classifiedsValidationError id='email' class='required'}
            {classifiedsValidationError id='email' class='validate-email'}
        </div>
        
        <div class="z-formrow">
            {gt text='your phone number for requests. It will be shown public.' assign='toolTip'}
            {formlabel for='fon' __text='Fon' cssClass='classifieds-form-tooltips' title=$toolTip}
            {formtextinput group='classified' id='fon' mandatory=false readOnly=false __title='Enter the fon of the classified' textMode='singleline' maxLength=255 cssClass='' }
        </div>
        
        <div class="z-formrow">
            {gt text='a picture oft your classified' assign='toolTip'}
            {formlabel for='picture' __text='Picture' cssClass='classifieds-form-tooltips' title=$toolTip}<br />{* break required for Google Chrome *}
            {formuploadinput group='classified' id='picture' mandatory=false readOnly=false cssClass=' validate-upload' }
            <span class="z-formnote"><a id="resetPictureVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
            
                <span class="z-formnote">{gt text='Allowed file extensions:'} <span id="pictureFileExtensions">gif, jpeg, jpg, png</span></span>
            <span class="z-formnote">{gt text='Allowed file size:'} {$modvars.Classifieds.picmaxfilesize|classifiedsGetFileSize:'':false:false}</span>
            {if $mode ne 'create'}
                {if $classified.picture ne ''}
                    <span class="z-formnote">
                        {gt text='Current file'}:
                        <a href="{$classified.pictureFullPathUrl}" {if $classified.pictureMeta.isImage} rel="imageviewer[classified]"{/if}>
                        {if $classified.pictureMeta.isImage}
                            {thumb image=$classified.pictureFullPath objectid="classified-`$classified.id`" preset=$classifiedThumbPresetPicture tag=true}
                        {else}
                            {gt text='Download'} ({$classified.pictureMeta.size|classifiedsGetFileSize:$classified.pictureFullPath:false:false})
                        {/if}
                        </a>
                    </span>
                    <span class="z-formnote">
                        {formcheckbox group='classified' id='pictureDeleteFile' readOnly=false __title='Delete picture ?'}
                        {formlabel for='pictureDeleteFile' __text='Delete existing file'}
                    </span>
                {/if}
            {/if}
            {classifiedsValidationError id='picture' class='validate-upload'}
        </div>
        
        <div class="z-formrow">
            {gt text='the date when your classified should appear. Normaly right now.' assign='toolTip'}
            {formlabel for='startdate' __text='Startdate' cssClass='classifieds-form-tooltips' title=$toolTip}
            {if $mode ne 'create'}
                {formdateinput group='classified' id='startdate' mandatory=false __title='Enter the startdate of the classified' includeTime=true cssClass='' }
            {else}
                {formdateinput group='classified' id='startdate' mandatory=false __title='Enter the startdate of the classified' includeTime=true defaultValue='now' cssClass='' }
            {/if}
            
            {classifiedsValidationError id='startdate' class='validate-daterange-classified'}
        </div>
        
        <div class="z-formrow">
            {gt text='the date when the classified shoud stop. This will be set automatically.' assign='toolTip'}
            {formlabel for='enddate' __text='Enddate' mandatorysym='1' cssClass='classifieds-form-tooltips' title=$toolTip}
            {if $mode ne 'create'}
                {formdateinput group='classified' id='enddate' mandatory=true __title='Enter the enddate of the classified' includeTime=true cssClass='required validate-DateTime-future' }
            {else}
                {formdateinput group='classified' id='enddate' mandatory=true __title='Enter the enddate of the classified' includeTime=true defaultValue='custom' cssClass='required validate-DateTime-future' initDate="+`$modvars.Classifieds.defaultperiod` day" }
            {/if}
            
            <span class="z-formnote">{gt text='Note: this value must be in the future.'}</span>
            {classifiedsValidationError id='enddate' class='required'}
            {classifiedsValidationError id='enddate' class='validate-DateTime-past'}
            {classifiedsValidationError id='enddate' class='validate-daterange-classified'}
        </div>
        
        <div class="z-formrow">
            {gt text='You have to accept the terms and conditions. Otherwhise your classified will not published.' assign='toolTip'}
            {formlabel for='terms' __text='Terms' mandatorysym='1' cssClass='classifieds-form-tooltips' title=$toolTip}
            {formcheckbox group='classified' id='terms' readOnly=false __title='terms ?' cssClass='required' }
            {classifiedsValidationError id='terms' class='required'}
        </div>
    </fieldset>
    
    {include file='user/include_categories_edit.tpl' obj=$classified groupName='classifiedObj'}
    {if $mode ne 'create'}
        {include file='user/include_standardfields_edit.tpl' obj=$classified}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$classified.id}
        {notifydisplayhooks eventname='classifieds.ui_hooks.classifieds.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='classifieds.ui_hooks.classifieds.form_edit' id=null assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
                {$hook}
            </fieldset>
        {/foreach}
    {/if}
    
    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatCreation' __text='Create another item after save'}
                    {formcheckbox group='classified' id='repeatCreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {foreach item='action' from=$actions}
        {assign var='actionIdCapital' value=$action.id|@ucwords}
        {gt text=$action.title assign='actionTitle'}
        {*gt text=$action.description assign='actionDescription'*}{* TODO: formbutton could support title attributes *}
        {if $action.id eq 'delete'}
            {gt text='Really delete this classified?' assign='deleteConfirmMsg'}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass confirmMessage=$deleteConfirmMsg}
        {else}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass}
        {/if}
    {/foreach}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    {/classifiedsFormFrame}
{/form}
</div>
{include file='user/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='removeImageArray'}


<script type="text/javascript">
/* <![CDATA[ */

    var formButtons, formValidator;

    function handleFormButton (event) {
        var result = formValidator.validate();
        if (!result) {
            // validation error, abort form submit
            Event.stop(event);
        } else {
            // hide form buttons to prevent double submits by accident
            formButtons.each(function (btn) {
                btn.addClassName('z-hide');
            });
        }

        return result;
    }

    document.observe('dom:loaded', function() {

        clfsAddCommonValidationRules('classified', '{{if $mode ne 'create'}}{{$classified.id}}{{/if}}');
        {{* observe validation on button events instead of form submit to exclude the cancel command *}}
        formValidator = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = formValidator.validate();
        {{/if}}

        formButtons = $('{{$__formid}}').select('div.z-formbuttons input');

        formButtons.each(function (elem) {
            if (elem.id != 'btnCancel') {
                elem.observe('click', handleFormButton);
            }
        });

        Zikula.UI.Tooltips($$('.classifieds-form-tooltips'));
        clfsInitUploadField('picture');
    });

/* ]]> */
</script>
