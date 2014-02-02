{* Purpose of this template: Display a popup selector for Forms and Content integration *}
{assign var='baseID' value='classified'}
<div id="{$baseID}Preview" style="float: right; width: 300px; border: 1px dotted #a3a3a3; padding: .2em .5em; margin-right: 1em">
    <p><strong>{gt text='Classified information'}</strong></p>
    {img id='ajax_indicator' modname='core' set='ajax' src='indicator_circle.gif' alt='' class='z-hide'}
    <div id="{$baseID}PreviewContainer">&nbsp;</div>
</div>
<br />
<br />
{assign var='leftSide' value=' style="float: left; width: 10em"'}
{assign var='rightSide' value=' style="float: left"'}
{assign var='break' value=' style="clear: left"'}

{if $properties ne null && is_array($properties)}
    {gt text='All' assign='lblDefault'}
    {nocache}
    {foreach key='propertyName' item='propertyId' from=$properties}
        <p>
            {modapifunc modname='Classifieds' type='category' func='hasMultipleSelection' ot='classified' registry=$propertyName assign='hasMultiSelection'}
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
            <label for="{$baseID}_{$categorySelectorId}{$propertyName}"{$leftSide}>{$categoryLabel}:</label>
            &nbsp;
            {selector_category name="`$baseID`_`$categorySelectorName``$propertyName`" field='id' selectedValue=$catIds.$propertyName categoryRegistryModule='Classifieds' categoryRegistryTable=$objectType categoryRegistryProperty=$propertyName defaultText=$lblDefault editLink=false multipleSize=$categorySelectorSize}
            <br{$break} />
        </p>
    {/foreach}
    {/nocache}
{/if}
<p>
    <label for="{$baseID}Id"{$leftSide}>{gt text='Classified'}:</label>
    <select id="{$baseID}Id" name="id"{$rightSide}>
        {foreach item='classified' from=$items}
            <option value="{$classified.id}"{if $selectedId eq $classified.id} selected="selected"{/if}>{$classified->getTitleFromDisplayPattern()}</option>
        {foreachelse}
            <option value="0">{gt text='No entries found.'}</option>
        {/foreach}
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}Sort"{$leftSide}>{gt text='Sort by'}:</label>
    <select id="{$baseID}Sort" name="sort"{$rightSide}>
        <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
        <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option>
        <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
        <option value="kind"{if $sort eq 'kind'} selected="selected"{/if}>{gt text='Kind'}</option>
        <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
        <option value="price"{if $sort eq 'price'} selected="selected"{/if}>{gt text='Price'}</option>
        <option value="email"{if $sort eq 'email'} selected="selected"{/if}>{gt text='Email'}</option>
        <option value="fon"{if $sort eq 'fon'} selected="selected"{/if}>{gt text='Fon'}</option>
        <option value="picture"{if $sort eq 'picture'} selected="selected"{/if}>{gt text='Picture'}</option>
        <option value="picture2"{if $sort eq 'picture2'} selected="selected"{/if}>{gt text='Picture2'}</option>
        <option value="classifiedStart"{if $sort eq 'classifiedStart'} selected="selected"{/if}>{gt text='Classified start'}</option>
        <option value="classifiedEnd"{if $sort eq 'classifiedEnd'} selected="selected"{/if}>{gt text='Classified end'}</option>
        <option value="terms"{if $sort eq 'terms'} selected="selected"{/if}>{gt text='Terms'}</option>
        <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
        <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
        <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
    </select>
    <select id="{$baseID}SortDir" name="sortdir">
        <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
        <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}SearchTerm"{$leftSide}>{gt text='Search for'}:</label>
    <input type="text" id="{$baseID}SearchTerm" name="searchterm"{$rightSide} />
    <input type="button" id="classifiedsSearchGo" name="gosearch" value="{gt text='Filter'}" />
    <br{$break} />
</p>
<br />
<br />

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        classifieds.itemSelector.onLoad('{{$baseID}}', {{$selectedId|default:0}});
    });
/* ]]> */
</script>
