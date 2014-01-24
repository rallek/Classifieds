{* purpose of this template: classifieds view csv view in user area *}
{classifiedsTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Classifieds.csv'}
{strip}"{gt text='Title'}";"{gt text='Kind'}";"{gt text='Description'}";"{gt text='Price'}";"{gt text='Email'}";"{gt text='Fon'}";"{gt text='Picture'}";"{gt text='Startdate'}";"{gt text='Enddate'}";"{gt text='Terms'}";"{gt text='Workflow state'}"
{/strip}
{foreach item='classified' from=$items}
{strip}
    "{$classified.title}";"{$classified.kind|classifiedsGetListEntry:'classified':'kind'|safetext}";"{$classified.description}";"{$classified.price|formatcurrency}";"{$classified.email}";"{$classified.fon}";"{$classified.picture}";"{$classified.startdate|dateformat:'datetimebrief'}";"{$classified.enddate|dateformat:'datetimebrief'}";"{if !$classified.terms}0{else}1{/if}";"{$item.workflowState|classifiedsObjectState:false|lower}"
{/strip}
{/foreach}
