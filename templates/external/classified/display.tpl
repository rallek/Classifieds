{* Purpose of this template: Display one certain classified within an external context *}
<div id="classified{$classified.id}" class="classifieds-external-classified">
{if $displayMode eq 'link'}
    <p class="classifieds-external-link">
    <a href="{modurl modname='Classifieds' type='user' func='display' ot='classified' id=$classified.id}" title="{$classified->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$classified->getTitleFromDisplayPattern()|notifyfilters:'classifieds.filter_hooks.classifieds.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='Classifieds::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="classifieds-external-title">
            <strong>{$classified->getTitleFromDisplayPattern()|notifyfilters:'classifieds.filter_hooks.classifieds.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="classifieds-external-snippet">
        {if $classified.picture ne ''}
          <a href="{$classified.pictureFullPathURL}" title="{$classified->getTitleFromDisplayPattern()|replace:"\"":""}"{if $classified.pictureMeta.isImage} rel="imageviewer[classified]"{/if}>
          {if $classified.pictureMeta.isImage}
              {thumb image=$classified.pictureFullPath objectid="classified-`$classified.id`" preset=$classifiedThumbPresetPicture tag=true img_alt=$classified->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$classified.pictureMeta.size|classifiedsGetFileSize:$classified.pictureFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
    </div>

    {* you can distinguish the context like this: *}
    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}

    {* you can enable more details about the item: *}
    {*
        <p class="classifieds-external-description">
            {if $classified.description ne ''}{$classified.description}<br />{/if}
            {assignedcategorieslist categories=$classified.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
