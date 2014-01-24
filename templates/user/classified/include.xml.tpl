{* purpose of this template: classifieds xml inclusion template in user area *}
<classified id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <title><![CDATA[{$item.title}]]></title>
    <kind>{$item.kind|classifiedsGetListEntry:'classified':'kind'|safetext}</kind>
    <description><![CDATA[{$item.description}]]></description>
    <price>{$item.price|formatcurrency}</price>
    <email>{$item.email}</email>
    <fon><![CDATA[{$item.fon}]]></fon>
    <picture{if $item.picture ne ''} extension="{$item.pictureMeta.extension}" size="{$item.pictureMeta.size}" isImage="{if $item.pictureMeta.isImage}true{else}false{/if}"{if $item.pictureMeta.isImage} width="{$item.pictureMeta.width}" height="{$item.pictureMeta.height}" format="{$item.pictureMeta.format}"{/if}{/if}>{$item.picture}</picture>
    <startdate>{$item.startdate|dateformat:'datetimebrief'}</startdate>
    <enddate>{$item.enddate|dateformat:'datetimebrief'}</enddate>
    <terms>{if !$item.terms}0{else}1{/if}</terms>
    <workflowState>{$item.workflowState|classifiedsObjectState:false|lower}</workflowState>
</classified>
