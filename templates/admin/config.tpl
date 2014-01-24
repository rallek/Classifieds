{* purpose of this template: module configuration *}
{include file='admin/header.tpl'}
<div class="classifieds-config">
    {gt text='Settings' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='config' size='small' __alt='Settings'}
        <h3>{$templateTitle}</h3>
    </div>

    {form cssClass='z-form'}
        {* add validation summary and a <div> element for styling the form *}
        {classifiedsFormFrame}
            {formsetinitialfocus inputId='defaultperiod'}
            {gt text='Variables' assign='tabTitle'}
            <fieldset>
                <legend>{$tabTitle}</legend>
            
                <p class="z-confirmationmsg">{gt text='Here you can manage all basic settings for this application.'}</p>
            
                <div class="z-formrow">
                    {gt text='Standardtage für die Laufzeit der Kleinanzeige' assign='toolTip'}
                    {formlabel for='defaultperiod' __text='Defaultperiod' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formintinput id='defaultperiod' group='config' maxLength=255 __title='Enter the defaultperiod. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='erlaubte maximalgröße von Bildern in Byte (z.B. 102400 für 100kb)' assign='toolTip'}
                    {formlabel for='picmaxfilesize' __text='Picmaxfilesize' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formintinput id='picmaxfilesize' group='config' maxLength=255 __title='Enter the picmaxfilesize. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='allowedextension' __text='Allowedextension' cssClass=''}
                        {formtextinput id='allowedextension' group='config' maxLength=255 __title='Enter the allowedextension.'}
                </div>
                <div class="z-formrow">
                    {gt text='here we need a link to the terms and conditions' assign='toolTip'}
                    {formlabel for='terms_link' __text='Terms_link' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formtextinput id='terms_link' group='config' maxLength=255 __title='Enter the terms_link.'}
                </div>
            </fieldset>

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='save' __text='Update configuration' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/classifiedsFormFrame}
    {/form}
</div>
{include file='admin/footer.tpl'}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        Zikula.UI.Tooltips($$('.classifieds-form-tooltips'));
    });
/* ]]> */
</script>
