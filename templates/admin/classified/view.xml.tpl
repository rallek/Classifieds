{* purpose of this template: classifieds view xml view in admin area *}
{classifiedsTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<classifieds>
{foreach item='item' from=$items}
    {include file='admin/classified/include.xml'}
{foreachelse}
    <noClassified />
{/foreach}
</classifieds>
