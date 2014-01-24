{* purpose of this template: classifieds view view in admin area *}
{include file='admin/header.tpl'}
<div class="classifieds-classified classifieds-view">
    {gt text='Classified list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    <p class="z-informationmsg">a module for goods you want to sell or you want to buy like a small version of ebay</p>

    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='Classifieds' type='admin' func='view' ot='classified'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='Classifieds' type='admin' func='view' ot='classified' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='admin/classified/view_quickNav.tpl' all=$all own=$own}{* see template file for available options *}

    <form action="{modurl modname='Classifieds' type='admin' func='handleSelectedEntries'}" method="post" id="classifiedsViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="classified" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cWorkflowState" />
                    <col id="cTitle" />
                    <col id="cKind" />
                    <col id="cDescription" />
                    <col id="cPrice" />
                    <col id="cEmail" />
                    <col id="cFon" />
                    <col id="cPicture" />
                    <col id="cStartdate" />
                    <col id="cEnddate" />
                    <col id="cTerms" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleClassifieds" />
                    </th>
                    <th id="hWorkflowState" scope="col" class="z-left">
                        {sortlink __linktext='State' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='workflowState' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hTitle" scope="col" class="z-left">
                        {sortlink __linktext='Title' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='title' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hKind" scope="col" class="z-left">
                        {sortlink __linktext='Kind' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='kind' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hDescription" scope="col" class="z-left">
                        {sortlink __linktext='Description' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='description' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hPrice" scope="col" class="z-right">
                        {sortlink __linktext='Price' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='price' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hEmail" scope="col" class="z-left">
                        {sortlink __linktext='Email' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='email' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hFon" scope="col" class="z-left">
                        {sortlink __linktext='Fon' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='fon' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hPicture" scope="col" class="z-left">
                        {sortlink __linktext='Picture' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='picture' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hStartdate" scope="col" class="z-left">
                        {sortlink __linktext='Startdate' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='startdate' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hEnddate" scope="col" class="z-left">
                        {sortlink __linktext='Enddate' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='enddate' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hTerms" scope="col" class="z-center">
                        {sortlink __linktext='Terms' currentsort=$sort modname='Classifieds' type='admin' func='view' ot='classified' sort='terms' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState kind=$kind searchterm=$searchterm pageSize=$pageSize terms=$terms}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='classified' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$classified.id}" class="classifieds-checkbox" />
                    </td>
                    <td headers="hWorkflowState" class="z-left z-nowrap">
                        {$classified.workflowState|classifiedsObjectState}
                    </td>
                    <td headers="hTitle" class="z-left">
                        <a href="{modurl modname='Classifieds' type='admin' func='display' ot='classified' id=$classified.id}" title="{gt text='View detail page'}">{$classified.title|notifyfilters:'classifieds.filterhook.classifieds'}</a>
                    </td>
                    <td headers="hKind" class="z-left">
                        {$classified.kind|classifiedsGetListEntry:'classified':'kind'|safetext}
                    </td>
                    <td headers="hDescription" class="z-left">
                        {$classified.description}
                    </td>
                    <td headers="hPrice" class="z-right">
                        {$classified.price|formatcurrency}
                    </td>
                    <td headers="hEmail" class="z-left">
                        <a href="mailto:{$classified.email}" title="{gt text='Send an email'}">{icon type='mail' size='extrasmall' __alt='Email'}</a>
                    </td>
                    <td headers="hFon" class="z-left">
                        {$classified.fon}
                    </td>
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
                    <td headers="hStartdate" class="z-left">
                        {$classified.startdate|dateformat:'datetimebrief'}
                    </td>
                    <td headers="hEnddate" class="z-left">
                        {$classified.enddate|dateformat:'datetimebrief'}
                    </td>
                    <td headers="hTerms" class="z-center">
                        {assign var='itemid' value=$classified.id}
                        <a id="toggleTerms{$itemid}" href="javascript:void(0);" class="z-hide">
                        {if $classified.terms}
                            {icon type='ok' size='extrasmall' __alt='Yes' id="yesterms_`$itemid`" __title='This setting is enabled. Click here to disable it.'}
                            {icon type='cancel' size='extrasmall' __alt='No' id="noterms_`$itemid`" __title='This setting is disabled. Click here to enable it.' class='z-hide'}
                        {else}
                            {icon type='ok' size='extrasmall' __alt='Yes' id="yesterms_`$itemid`" __title='This setting is enabled. Click here to disable it.' class='z-hide'}
                            {icon type='cancel' size='extrasmall' __alt='No' id="noterms_`$itemid`" __title='This setting is disabled. Click here to enable it.'}
                        {/if}
                        </a>
                        <noscript><div id="noscriptTerms{$itemid}">
                            {$classified.terms|yesno:true}
                        </div></noscript>
                    </td>
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
                </tr>
            {foreachelse}
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="13">
                {gt text='No classifieds found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Classifieds' type='admin' func='view' ot='classified'}
            {/if}
            <fieldset>
                <label for="classifiedsAction">{gt text='With selected classifieds'}</label>
                <select id="classifiedsAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                <option value="unpublish" title="{gt text='Hide content temporarily.'}">{gt text='Unpublish'}</option>
                <option value="publish" title="{gt text='Make content available again.'}">{gt text='Publish'}</option>
                <option value="archive" title="{gt text='Move content into the archive.' comment='this is the verb, not the noun'}">{gt text='Archive'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{foreach item='classified' from=$items}}
        {{assign var='itemid' value=$classified.id}}
        clfsInitToggle('classified', 'terms', '{{$itemid}}');
    {{/foreach}}
    {{* init the "toggle all" functionality *}}
    if ($('toggleClassifieds') != undefined) {
        $('toggleClassifieds').observe('click', function (e) {
            Zikula.toggleInput('classifiedsViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
