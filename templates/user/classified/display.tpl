{* purpose of this template: classifieds display view in user area *}
{include file='user/header.tpl'}
<div class="classifieds-classified classifieds-display">
    {gt text='Classified' assign='templateTitle'}
    {assign var='templateTitle' value=$classified->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'classifieds.filter_hooks.classifieds.filter'} <small>({$classified.workflowState|classifiedsObjectState:false|lower})</small>{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    <dl>
        <dt>{gt text='State'}</dt>
        <dd>{$classified.workflowState|classifiedsGetListEntry:'classified':'workflowState'|safetext}</dd>
        <dt>{gt text='Title'}</dt>
        <dd>{$classified.title}</dd>
        <dt>{gt text='Kind'}</dt>
        <dd>{$classified.kind|classifiedsGetListEntry:'classified':'kind'|safetext}</dd>
        <dt>{gt text='Description'}</dt>
        <dd>{$classified.description}</dd>
        <dt>{gt text='Price'}</dt>
        <dd>{$classified.price|formatcurrency}</dd>
        <dt>{gt text='Email'}</dt>
        <dd>{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <a href="mailto:{$classified.email}" title="{gt text='Send an email'}">{icon type='mail' size='extrasmall' __alt='Email'}</a>
        {else}
          {$classified.email}
        {/if}
        </dd>
        <dt>{gt text='Fon'}</dt>
        <dd>{$classified.fon}</dd>
        <dt>{gt text='Picture'}</dt>
        <dd>{if $classified.picture ne ''}
          <a href="{$classified.pictureFullPathURL}" title="{$classified->getTitleFromDisplayPattern()|replace:"\"":""}"{if $classified.pictureMeta.isImage} rel="imageviewer[classified]"{/if}>
          {if $classified.pictureMeta.isImage}
              {thumb image=$classified.pictureFullPath objectid="classified-`$classified.id`" preset=$classifiedThumbPresetPicture tag=true img_alt=$classified->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$classified.pictureMeta.size|classifiedsGetFileSize:$classified.pictureFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
        </dd>
        <dt>{gt text='Picture2'}</dt>
        <dd>{if $classified.picture2 ne ''}
          <a href="{$classified.picture2FullPathURL}" title="{$classified->getTitleFromDisplayPattern()|replace:"\"":""}"{if $classified.picture2Meta.isImage} rel="imageviewer[classified]"{/if}>
          {if $classified.picture2Meta.isImage}
              {thumb image=$classified.picture2FullPath objectid="classified-`$classified.id`" preset=$classifiedThumbPresetPicture2 tag=true img_alt=$classified->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$classified.picture2Meta.size|classifiedsGetFileSize:$classified.picture2FullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
        </dd>
        <dt>{gt text='Classified start'}</dt>
        <dd>{$classified.classifiedStart|dateformat:'datetimebrief'}</dd>
        <dt>{gt text='Classified end'}</dt>
        <dd>{$classified.classifiedEnd|dateformat:'datetimebrief'}</dd>
        <dt>{gt text='Terms'}</dt>
        <dd>{assign var='itemid' value=$classified.id}
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
        </dd>
        
    </dl>
    {include file='user/include_categories_display.tpl' obj=$classified}
    {include file='user/include_standardfields_display.tpl' obj=$classified}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='classifieds.ui_hooks.classifieds.display_view' id=$classified.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($classified._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$classified._actions}
                <a href="{$option.url.type|classifiedsActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    clfsInitItemActions('classified', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file='user/footer.tpl'}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            {{assign var='itemid' value=$classified.id}}
                clfsInitToggle('classified', 'terms', '{{$itemid}}');
        });
    /* ]]> */
    </script>
{/if}
