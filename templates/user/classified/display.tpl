{* purpose of this template: classifieds display view in user area *}
{include file='user/header.tpl'}
<div class="classifieds-classified classifieds-display">
    {gt text='Classified' assign='templateTitle'}
    {assign var='templateTitle' value=$classified->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$classified.kind|classifiedsGetListEntry:'classified':'kind'|safetext} : {$templateTitle|notifyfilters:'classifieds.filter_hooks.classifieds.filter'}  {icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'} </h2>
	<h3>{gt text='Price'}: {$classified.price|formatcurrency}</h3>
    <dl>
		<div><form class="z-form">
		
		<div class="classifieds-form">
			<fieldset class="classifieds-picturebox">
			<legend>&nbsp;Bild</legend>
				<dd>{if $classified.picture ne ''}
				  <a href="{$classified.pictureFullPathURL}" title="{$classified->getTitleFromDisplayPattern()|replace:"\"":""}"{if $classified.pictureMeta.isImage} rel="imageviewer[classified]"{/if}>
				  {if $classified.pictureMeta.isImage}
					  {thumb image=$classified.pictureFullPath objectid="classified-`$classified.id`" preset=$classifiedThumbPresetPicture tag=true img_alt=$classified->getTitleFromDisplayPattern()}
				  {else}
					  {gt text='Download'} ({$classified.pictureMeta.size|classifiedsGetFileSize:$classified.pictureFullPath:false:false})
				  {/if}
				  </a>
				{else}&nbsp;kein Bild{/if} <!-- hier einen Platzhalter einbauen -->
				</dd>
			</fieldset>
			<fieldset class="classifieds-contactbox ">
			<legend>{gt text='Kontakt'}</legend>
			
				<dt>{gt text='Email'}</dt>
				<dd>{if $classified.email ne ''}
				{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
				<a href="mailto:{$classified.email}" title="{gt text='Send an email'}">{icon type='mail' size='extrasmall' __alt='Email'}</a>
				{else}
				  {$classified.email}
				{/if}
				{else}&nbsp;{/if}
				</dd>
				<dt>{gt text='Fon'}</dt>
				<dd>{$classified.fon}</dd>
			</fieldset>
			
			<fieldset class="classifieds-contactbox ">
			<legend>{gt text='Details'}</legend>
				<dt>{gt text='Kind'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</dt>
				<dd>{$classified.kind|classifiedsGetListEntry:'classified':'kind'|safetext}</dd> 
				<dt>{gt text='Anzeigennummer'}</dt>
				<dd> {$classified.id}</dd>
				
				    {include file='user/classified/include_info_standardfields_display.tpl' obj=$classified}

				
			</fieldset>

			<fieldset class="classifieds-descriptionbox">
				<legend>{gt text='Description'}</legend>
				<dt>{$classified.kind|classifiedsGetListEntry:'classified':'kind'|safetext}</dt>
				<dd>{$classified.description}</dd>
				{include file='user/classified/include_info_categories_display.tpl' obj=$classified}
				<dt>{gt text='Startdate'}</dt>
				<dd>{$classified.startdate|dateformat:'datetimebrief'}</dd>
				<dt>{gt text='Enddate'}</dt>
				<dd>{$classified.enddate|dateformat:'datetimebrief'}</dd>
			</fieldset>

			</form></div>
		</div>    
		</dl>



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
