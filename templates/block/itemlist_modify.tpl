{* Purpose of this template: Edit block for generic item list *}
<div class="z-formrow">
    <label for="classifiedsObjectType">{gt text='Object type'}:</label>
        <select id="classifiedsObjectType" name="objecttype" size="1">
            <option value="classified"{if $objectType eq 'classified'} selected="selected"{/if}>{gt text='Classifieds'}</option>
        </select>
        <span class="z-sub z-formnote">{gt text='If you change this please save the block once to reload the parameters below.'}</span>
</div>

{if $catIds ne null && is_array($catIds)}
    {gt text='All' assign='lblDefault'}
    {nocache}
    {foreach key='propertyName' item='propertyId' from=$catIds}
        <div class="z-formrow">
            {modapifunc modname='Classifieds' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' assign='categoryLabel'}
            {assign var='categorySelectorId' value='catid'}
            {assign var='categorySelectorName' value='catid'}
            {assign var='categorySelectorSize' value='1'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' assign='categoryLabel'}
                {assign var='categorySelectorName' value='catids'}
                {assign var='categorySelectorId' value='catids__'}
                {assign var='categorySelectorSize' value='8'}
            {/if}
            <label for="{$categorySelectorId}{$propertyName}">{$categoryLabel}</label>
            &nbsp;
                {selector_category name="`$categorySelectorName``$propertyName`" field='id' selectedValue=$catIds.$propertyName categoryRegistryModule='Classifieds' categoryRegistryTable=$objectType categoryRegistryProperty=$propertyName defaultText=$lblDefault editLink=false multipleSize=$categorySelectorSize}
                <span class="z-sub z-formnote">{gt text='This is an optional filter.'}</span>
        </div>
    {/foreach}
    {/nocache}
{/if}

<div class="z-formrow">
    <label for="classifiedsSorting">{gt text='Sorting'}:</label>
        <select id="classifiedsSorting" name="sorting">
            <option value="random"{if $sorting eq 'random'} selected="selected"{/if}>{gt text='Random'}</option>
            <option value="newest"{if $sorting eq 'newest'} selected="selected"{/if}>{gt text='Newest'}</option>
            <option value="alpha"{if $sorting eq 'default' || ($sorting != 'random' && $sorting != 'newest')} selected="selected"{/if}>{gt text='Default'}</option>
        </select>
</div>

<div class="z-formrow">
    <label for="classifiedsAmount">{gt text='Amount'}:</label>
        <input type="text" id="classifiedsAmount" name="amount" maxlength="2" size="10" value="{$amount|default:"5"}" />
</div>

<div class="z-formrow">
    <label for="classifiedsTemplate">{gt text='Template'}:</label>
        <select id="classifiedsTemplate" name="template">
            <option value="itemlist_display.tpl"{if $template eq 'itemlist_display.tpl'} selected="selected"{/if}>{gt text='Only item titles'}</option>
            <option value="itemlist_display_description.tpl"{if $template eq 'itemlist_display_description.tpl'} selected="selected"{/if}>{gt text='With description'}</option>
            <option value="custom"{if $template eq 'custom'} selected="selected"{/if}>{gt text='Custom template'}</option>
        </select>
</div>

<div id="customTemplateArea" class="z-formrow z-hide">
    <label for="classifiedsCustomTemplate">{gt text='Custom template'}:</label>
        <input type="text" id="classifiedsCustomTemplate" name="customtemplate" size="40" maxlength="80" value="{$customTemplate|default:''}" />
        <span class="z-sub z-formnote">{gt text='Example'}: <em>itemlist_{$objecttype}_display.tpl</em></span>
</div>

<div class="z-formrow z-hide">
    <label for="classifiedsFilter">{gt text='Filter (expert option)'}:</label>
        <input type="text" id="classifiedsFilter" name="filter" size="40" value="{$filterValue|default:''}" />
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
