{* purpose of this template: classifieds view json view in admin area *}
{classifiedsTemplateHeaders contentType='application/json'}
[
{foreach item='item' from=$items name='classifieds'}
    {if not $smarty.foreach.classifieds.first},{/if}
    {$item->toJson()}
{/foreach}
]
