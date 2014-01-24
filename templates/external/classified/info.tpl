{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="classified{$classified.id}">
<dt>{$classified->getTitleFromDisplayPattern()|notifyfilters:'classifieds.filter_hooks.classifieds.filter'|htmlentities}</dt>
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
{if $classified.description ne ''}<dd>{$classified.description}</dd>{/if}
<dd>{assignedcategorieslist categories=$classified.categories doctrine2=true}</dd>
</dl>
