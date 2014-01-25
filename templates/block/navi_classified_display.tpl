{* purpose of this template: classifieds navigation block *}
{checkpermissionblock component='Classifieds:Classified:' instance='::' level='ACCESS_OVERVIEW'}

{assign var='objectType' value='classified'}
<form action="{$modvars.ZConfig.entrypoint|default:'index.php'}" method="get" id="classifiedsClassifiedQuickNavForm" class="classifieds-quicknav">
    <fieldset>
        <input type="hidden" name="module" value="{modgetinfo modname='Classifieds' info='url'}" />
        <input type="hidden" name="type" value="user" />
        <input type="hidden" name="func" value="view" />
        <input type="hidden" name="ot" value="classified" />
        <input type="hidden" name="all" value="{$all|default:0}" />
        <input type="hidden" name="own" value="{$own|default:0}" />
        {gt text='All' assign='lblDefault'}
		{if !isset($searchFilter) || $searchFilter eq true}
			<div class="z-formrow">
                <label for="searchTerm">{gt text='Search'}</label>
                <input type="text" id="searchTerm" name="searchterm" value="{$searchterm}" />
			</div>
        {/if}
		
        {if !isset($categoryFilter) || $categoryFilter eq true}
			<div class="z-formrow">
            {modapifunc modname='Classifieds' type='category' func='getAllProperties' ot=$objectType assign='properties'}
            {if $properties ne null && is_array($properties)}
                {gt text='All' assign='lblDefault'}
                {nocache}
                {foreach key='propertyName' item='propertyId' from=$properties}
                    {modapifunc modname='Classifieds' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
                    {gt text='Category' assign='categoryLabel'}
                    {assign var='categorySelectorId' value='catid'}
                    {assign var='categorySelectorName' value='catid'}
                    {assign var='categorySelectorSize' value='1'}
                    {if $hasMultiSelection eq true}
                        {gt text='Categories' assign='categoryLabel'}
                        {assign var='categorySelectorName' value='catids'}
                        {assign var='categorySelectorId' value='catids__'}
                        {assign var='categorySelectorSize' value='1'}
                    {/if}
                        <label for="{$categorySelectorId}{$propertyName}">{$categoryLabel}</label>
                        {selector_category name="`$categorySelectorName``$propertyName`" field='id' selectedValue=$catIdList.$propertyName categoryRegistryModule='Classifieds' categoryRegistryTable=$objectType categoryRegistryProperty=$propertyName defaultText=$lblDefault editLink=false multipleSize=$categorySelectorSize} 
						
                {/foreach}
                {/nocache}
            {/if}
			</div>
        {/if}
		
<!--         {if !isset($workflowStateFilter) || $workflowStateFilter eq true}
                <label for="workflowState">{gt text='Workflow state'}</label>
                <select id="workflowState" name="workflowState">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$workflowStateItems}
                <option value="{$option.value}"{if $option.title ne ''} title="{$option.title|safetext}"{/if}{if $option.value eq $workflowState} selected="selected"{/if}>{$option.text|safetext}</option>
                {/foreach}
                </select>
        {/if} -->
        {if !isset($kindFilter) || $kindFilter eq true}
			<div class="z-formrow">
                <label for="kind">{gt text='Kind'}</label>
                <select id="kind" name="kind">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$kindItems}
                <option value="{$option.value}"{if $option.title ne ''} title="{$option.title|safetext}"{/if}{if $option.value eq $kind} selected="selected"{/if}>{$option.text|safetext}</option>
                {/foreach}
                </select>
			</div>
        {/if}
		

<!--         {if !isset($sorting) || $sorting eq true}
                <label for="sortBy">{gt text='Sort by'}</label>
                &nbsp;
                <select id="sortBy" name="sort">
                    <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                    <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option>
                    <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
                    <option value="kind"{if $sort eq 'kind'} selected="selected"{/if}>{gt text='Kind'}</option>
                    <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
                    <option value="price"{if $sort eq 'price'} selected="selected"{/if}>{gt text='Price'}</option>
                    <option value="email"{if $sort eq 'email'} selected="selected"{/if}>{gt text='Email'}</option>
                    <option value="fon"{if $sort eq 'fon'} selected="selected"{/if}>{gt text='Fon'}</option>
                    <option value="picture"{if $sort eq 'picture'} selected="selected"{/if}>{gt text='Picture'}</option>
                    <option value="startdate"{if $sort eq 'startdate'} selected="selected"{/if}>{gt text='Startdate'}</option>
                    <option value="enddate"{if $sort eq 'enddate'} selected="selected"{/if}>{gt text='Enddate'}</option>
                    <option value="terms"{if $sort eq 'terms'} selected="selected"{/if}>{gt text='Terms'}</option>
                    <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                    <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                    <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
                </select>
                <select id="sortDir" name="sortdir">
                    <option value="asc"{if $sdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                    <option value="desc"{if $sdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
                </select>
        {else}
            <input type="hidden" name="sort" value="{$sort}" />
            <input type="hidden" name="sdir" value="{if $sdir eq 'desc'}asc{else}desc{/if}" />
        {/if} -->
        {if !isset($pageSizeSelector) || $pageSizeSelector eq true}
			<div class="z-formrow">
                <label for="num">{gt text='Page size'}</label>
                <select id="num" name="num">
                    <option value="5"{if $pageSize eq 5} selected="selected"{/if}>5</option>
                    <option value="10"{if $pageSize eq 10} selected="selected"{/if}>10</option>
                    <option value="15"{if $pageSize eq 15} selected="selected"{/if}>15</option>
                    <option value="20"{if $pageSize eq 20} selected="selected"{/if}>20</option>
                    <option value="30"{if $pageSize eq 30} selected="selected"{/if}>30</option>
                    <option value="50"{if $pageSize eq 50} selected="selected"{/if}>50</option>
                    <option value="100"{if $pageSize eq 100} selected="selected"{/if}>100</option>
                </select>
			</div>
        {/if}
		
<!--         {if !isset($termsFilter) || $termsFilter eq true}
                <label for="terms">{gt text='Terms'}</label>
                <select id="terms" name="terms">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$termsItems}
                    <option value="{$option.value}"{if $option.value eq $terms} selected="selected"{/if}>{$option.text|safetext}</option>
                {/foreach}
                </select>
        {/if} -->
        <input type="submit" name="updateview" id="quicknavSubmit" value="{gt text='OK'}" />
    </fieldset>
</form>

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        clfsInitQuickNavigation('classified', 'user');
        {{if isset($searchFilter) && $searchFilter eq false}}
            {{* we can hide the submit button if we have no quick search field *}}
            $('quicknavSubmit').addClassName('z-hide');
        {{/if}}
    });
/* ]]> */
</script>
{/checkpermissionblock}

{* hier sind die beiden Links aus dem View.tpl *}

{if $canBeCreated}
	{checkpermissionblock component='Classifieds:Classified:' instance='::' level='ACCESS_EDIT'}
		{gt text='Create classified' assign='createTitle'}
		<a href="{modurl modname='Classifieds' type='user' func='edit' ot='classified'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
	{/checkpermissionblock}
	</br>
{/if}
{assign var='own' value=0}
{if isset($showOwnEntries) && $showOwnEntries eq 1}
	{assign var='own' value=1}
{/if}
{assign var='all' value=0}
{if isset($showAllEntries) && $showAllEntries eq 1}
	{gt text='Back to paginated view' assign='linkTitle'}
	<a href="{modurl modname='Classifieds' type='user' func='view' ot='classified'}" title="{$linkTitle}" class="z-icon-es-view">
		{$linkTitle}
	</a>
	{assign var='all' value=1}
{else}
	{gt text='Show all entries' assign='linkTitle'}
	<a href="{modurl modname='Classifieds' type='user' func='view' ot='classified' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
{/if}