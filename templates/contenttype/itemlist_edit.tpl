{* Purpose of this template: edit view of generic item list content type *}

<div class="z-formrow">
    {gt text='Object type' domain='module_classifieds' assign='objectTypeSelectorLabel'}
    {formlabel for='classifiedsObjectType' text=$objectTypeSelectorLabel}
        {classifiedsObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='classifiedsOjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
        <span class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.' domain='module_classifieds'}</span>
</div>

{formvolatile}
{if $properties ne null && is_array($properties)}
    {nocache}
    {foreach key='registryId' item='registryCid' from=$registries}
        {assign var='propName' value=''}
        {foreach key='propertyName' item='propertyId' from=$properties}
            {if $propertyId eq $registryId}
                {assign var='propName' value=$propertyName}
            {/if}
        {/foreach}
        <div class="z-formrow">
            {modapifunc modname='Classifieds' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' domain='module_classifieds' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' domain='module_classifieds' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="classifiedsCatIds`$propertyName`" text=$categorySelectorLabel}
                {formdropdownlist id="classifiedsCatIds`$propName`" items=$categories.$propName dataField="catids`$propName`" group='data' selectionMode=$selectionMode}
                <span class="z-sub z-formnote">{gt text='This is an optional filter.' domain='module_classifieds'}</span>
        </div>
    {/foreach}
    {/nocache}
{/if}
{/formvolatile}

<div class="z-formrow">
    {gt text='Sorting' domain='module_classifieds' assign='sortingLabel'}
    {formlabel text=$sortingLabel}
    <div>
        {formradiobutton id='classifiedsSortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='module_classifieds' assign='sortingRandomLabel'}
        {formlabel for='classifiedsSortRandom' text=$sortingRandomLabel}
        {formradiobutton id='classifiedsSortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='module_classifieds' assign='sortingNewestLabel'}
        {formlabel for='classifiedsSortNewest' text=$sortingNewestLabel}
        {formradiobutton id='classifiedsSortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='module_classifieds' assign='sortingDefaultLabel'}
        {formlabel for='classifiedsSortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="z-formrow">
    {gt text='Amount' domain='module_classifieds' assign='amountLabel'}
    {formlabel for='classifiedsAmount' text=$amountLabel}
        {formintinput id='classifiedsAmount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {gt text='Template' domain='module_classifieds' assign='templateLabel'}
    {formlabel for='classifiedsTemplate' text=$templateLabel}
        {classifiedsTemplateSelector assign='allTemplates'}
        {formdropdownlist id='classifiedsTemplate' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customTemplateArea" class="z-formrow z-hide">
    {gt text='Custom template' domain='module_classifieds' assign='customTemplateLabel'}
    {formlabel for='classifiedsCustomTemplate' text=$customTemplateLabel}
        {formtextinput id='classifiedsCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
        <span class="z-sub z-formnote">{gt text='Example' domain='module_classifieds'}: <em>itemlist_[objecttype]_display.tpl</em></span>
</div>

<div class="z-formrow z-hide">
    {gt text='Filter (expert option)' domain='module_classifieds' assign='filterLabel'}
    {formlabel for='classifiedsFilter' text=$filterLabel}
        {formtextinput id='classifiedsFilter' dataField='filter' group='data' mandatory=false maxLength=255}
        <span class="z-sub z-formnote">
            ({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)
        </span>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function clfsToggleCustomTemplate() {
        if ($F('classifiedsTemplate') == 'custom') {
            $('customTemplateArea').removeClassName('z-hide');
        } else {
            $('customTemplateArea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        clfsToggleCustomTemplate();
        $('classifiedsTemplate').observe('change', function(e) {
            clfsToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
