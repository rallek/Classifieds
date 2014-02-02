{* purpose of this template: classifieds display view in user area *}
{include file='user/header.tpl'}
<div>
    {gt text='Classified' assign='templateTitle'}
    {assign var='templateTitle' value=$classified->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'classifieds.filter_hooks.classifieds.filter'} {icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>
	<div class="clfs-display-all">
		<div class="clfs-display">
			<div class="clfs-display-picture">
				{if $classified.picture ne ''}
				  <a href="{$classified.pictureFullPathURL}" title="{$classified->getTitleFromDisplayPattern()|replace:"\"":""}"{if $classified.pictureMeta.isImage} rel="imageviewer[classified]"{/if}>
				  {if $classified.pictureMeta.isImage}
					  {thumb image=$classified.pictureFullPath objectid="classified-`$classified.id`" preset=$classifiedThumbPresetPicture tag=true img_alt=$classified->getTitleFromDisplayPattern()}
				  {else}
					  {gt text='Download'} ({$classified.pictureMeta.size|classifiedsGetFileSize:$classified.pictureFullPath:false:false})
				  {/if}
				  </a>
				{else}
					{thumb image=$modvars.Classifieds.pictureDummy preset=$classifiedThumbPresetPicture mode='inset' tag=true}
				{/if}
				
				{if $classified.picture2 ne ''}
				  <a href="{$classified.picture2FullPathURL}" title="{$classified->getTitleFromDisplayPattern()|replace:"\"":""}"{if $classified.picture2Meta.isImage} rel="imageviewer[classified]"{/if}>
				  {if $classified.picture2Meta.isImage}
					  {thumb image=$classified.picture2FullPath objectid="classified-`$classified.id`" preset=$classifiedThumbPresetPicture2 tag=true img_alt=$classified->getTitleFromDisplayPattern()}
				  {else}
					  {gt text='Download'} ({$classified.picture2Meta.size|classifiedsGetFileSize:$classified.picture2FullPath:false:false})
				  {/if}
				  </a>
				{else}				
					{thumb image=$modvars.Classifieds.pictureDummy preset=$classifiedThumbPresetPicture2 mode='inset' tag=true}
				{/if}	
			</div>
			<div class="clfs-display-description">
				<dt>{gt text='Description'}</dt>
				<dd>{$classified.description}</dd>     
			</div>    
		</div>
		<div class="clfs-display-details">
			<dl>
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
			
			<dt>{gt text='Classified start'}</dt>
			<dd>{$classified.classifiedStart|dateformat:'datetimebrief'}</dd>
			<dt>{gt text='Classified end'}</dt>
			<dd>{$classified.classifiedEnd|dateformat:'datetimebrief'}</dd>
		

			
		</dl>
		
		{include file='user/include_categories_display.tpl' obj=$classified}
		{include file='user/include_standardfields_display.tpl' obj=$classified}
		</div>
<!-- 		<div class="clfs-display-creation z-clearer ">
		{include file='user/include_standardfields_display.tpl' obj=$classified}
		</div> -->
	</div>
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
<div class="z-clearer ">{include file='user/footer.tpl'}</div>

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
