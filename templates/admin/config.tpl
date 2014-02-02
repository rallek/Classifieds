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
            {formsetinitialfocus inputId='pageSize'}
            {gt text='Variables' assign='tabTitle'}
            <fieldset>
                <legend>{$tabTitle}</legend>
            
                <p class="z-confirmationmsg">{gt text='Here you can manage all basic settings for this application.'}</p>
            
                <div class="z-formrow">
                    {gt text='default of items per page' assign='toolTip'}
                    {formlabel for='pageSize' __text='Page size' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formintinput id='pageSize' group='config' maxLength=255 __title='Enter the page size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Standardtage für die Laufzeit der Kleinanzeige' assign='toolTip'}
                    {formlabel for='defaultPeriod' __text='Default period' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formintinput id='defaultPeriod' group='config' maxLength=255 __title='Enter the default period. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='here we need a link to the terms and conditions' assign='toolTip'}
                    {formlabel for='termsLink' __text='Terms link' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formtextinput id='termsLink' group='config' maxLength=255 __title='Enter the terms link.'}
                </div>
                <div class="z-formrow">
                    {gt text='the maximum filesize of the uploaded pictures (in byte, e.g. 102400 for 100kb)' assign='toolTip'}
                    {formlabel for='pictureFileSize' __text='Picture file size' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formintinput id='pictureFileSize' group='config' maxLength=255 __title='Enter the picture file size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='maximal height of the picture' assign='toolTip'}
                    {formlabel for='pictureHeight' __text='Picture height' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formintinput id='pictureHeight' group='config' maxLength=255 __title='Enter the picture height. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='maximal width of the picture' assign='toolTip'}
                    {formlabel for='pictureWidth' __text='Picture width' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formintinput id='pictureWidth' group='config' maxLength=255 __title='Enter the picture width. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='maximal height of the picture thumbnail' assign='toolTip'}
                    {formlabel for='thumbPictureHeight' __text='Thumb picture height' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formintinput id='thumbPictureHeight' group='config' maxLength=255 __title='Enter the thumb picture height. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='maximal width of the picture thumbnail' assign='toolTip'}
                    {formlabel for='thumbPictureWidth' __text='Thumb picture width' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formintinput id='thumbPictureWidth' group='config' maxLength=255 __title='Enter the thumb picture width. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='a dummy picture if the user is not uploading one' assign='toolTip'}
                    {formlabel for='pictureDummy' __text='Picture dummy' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formtextinput id='pictureDummy' group='config' maxLength=255 __title='Enter the picture dummy.'}
                </div>
                <div class="z-formrow">
                    {gt text='you can use the wartermark option for pictures' assign='toolTip'}
                    {formlabel for='useWatermark' __text='Use watermark' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formcheckbox id='useWatermark' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='choose the kind of watermark' assign='toolTip'}
                    {formlabel for='typWatermark' __text='Typ watermark' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formdropdownlist id='typWatermark' group='config' __title='Choose the typ watermark'}
                </div>
                <div class="z-formrow">
                    {gt text='the picture for the overlay as a watermark' assign='toolTip'}
                    {formlabel for='watermarkPicture' __text='Watermark picture' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formtextinput id='watermarkPicture' group='config' maxLength=255 __title='Enter the watermark picture.'}
                </div>
                <div class="z-formrow">
                    {gt text='text for watermarking (max 15 characters)' assign='toolTip'}
                    {formlabel for='textWatermark' __text='Text watermark' cssClass='classifieds-form-tooltips ' title=$toolTip}
                        {formtextinput id='textWatermark' group='config' maxLength=255 __title='Enter the text watermark.'}
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
