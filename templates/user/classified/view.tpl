{* purpose of this template: classifieds view view in user area *}
{include file='user/header.tpl'}
<div class="classifieds-classified classifieds-view">
    {gt text='Classified list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    

    {if $canBeCreated}
        {checkpermissionblock component='Classifieds:Classified:' instance='::' level='ACCESS_READ'}
            {gt text='Create classified' assign='createTitle'}
            <a href="{modurl modname='Classifieds' type='user' func='edit' ot='classified'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
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

    {include file='user/classified/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false termsFilter=false pageSizeSelector=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cPicture" /> 			
			<col id="cTitle" />
            <col id="cPrice" />           
			{checkpermissionblock component='Classifieds:Classified:' instance='::' level='ACCESS_ADMIN'}
			<col id="cItemActions" />
			{/checkpermissionblock}
        </colgroup>
        <thead>
        <tr>
            {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
             <th id="hPicture" scope="col" class="z-left z-order-unsorted">
                {gt text='Picture'}
            </th>           
			<th id="hTitle" scope="col" class="z-left">
                {sortlink __linktext='Classifieds' currentsort=$sort modname='Classifieds' type='user' func='view' ot='classified' sort='title' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
            </th>
            <th id="hPrice" scope="col" class="z-right">
                {sortlink __linktext='Price' currentsort=$sort modname='Classifieds' type='user' func='view' ot='classified' sort='price' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
            </th>
			{checkpermissionblock component='Classifieds:Classified:' instance='::' level='ACCESS_ADMIN'}
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
			{/checkpermissionblock}
        </tr>
        </thead>
        <tbody>
    
    {foreach item='classified' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hPicture" class="z-left">
                {if $classified.picture ne ''}
                  <a href="{$classified.pictureFullPathURL}" title="{$classified->getTitleFromDisplayPattern()|replace:"\"":""}"{if $classified.pictureMeta.isImage} rel="imageviewer[classified]"{/if}>
                  {if $classified.pictureMeta.isImage}
                      {thumb image=$classified.pictureFullPath objectid="classified-`$classified.id`" preset=$classifiedThumbPresetPicture tag=true img_alt=$classified->getTitleFromDisplayPattern()}
                  {else}
                      {gt text='Download'} ({$classified.pictureMeta.size|classifiedsGetFileSize:$classified.pictureFullPath:false:false})
                  {/if}
                  </a>
                {else}&nbsp;{/if}
            </td>            
			<td headers="hTitle" class="z-left">
                <span class="z-bold"><a href="{modurl modname='Classifieds' type='user' func='display' ot='classified' id=$classified.id}" title="{gt text='View detail page'}">{$classified.title}</a></span>
				<span <span class="z-sub">({$classified.kind|classifiedsGetListEntry:'classified':'kind'|safetext})</span></br>
				{$classified.description|truncate:30:"..."}</br>
				<span <span class="z-sub">{gt text='ending'}: {$classified.classifiedEnd|dateformat:'datetimebrief'}</span>
            </td>

            <td headers="hPrice" class="z-right">
                {$classified.price|formatcurrency}
            </td>
			{checkpermissionblock component='Classifieds:Classified:' instance='::' level='ACCESS_ADMIN'}
            <td id="itemActions{$classified.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                {if count($classified._actions) gt 0}
                    {foreach item='option' from=$classified._actions}
                        <a href="{$option.url.type|classifiedsActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                    {icon id="itemActions`$classified.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            clfsInitItemActions('classified', 'view', 'itemActions{{$classified.id}}');
                        });
                    /* ]]> */
                    </script>
                {/if}
            </td>
			{/checkpermissionblock}
        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="13">
        {gt text='No classifieds found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Classifieds' type='user' func='view' ot='classified'}
    {/if}

    
    {notifydisplayhooks eventname='classifieds.ui_hooks.classifieds.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{foreach item='classified' from=$items}}
        {{assign var='itemid' value=$classified.id}}
        clfsInitToggle('classified', 'terms', '{{$itemid}}');
    {{/foreach}}
    });
/* ]]> */
</script>
