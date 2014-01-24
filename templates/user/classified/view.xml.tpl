{* purpose of this template: classifieds view xml view in user area *}
{classifiedsTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<classifieds>
{foreach item='item' from=$items}
    {include file='user/classified/include.xml'}
{foreachelse}
    <noClassified />
{/foreach}
</classifieds>
