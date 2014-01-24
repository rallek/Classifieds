{* Purpose of this template: Display classifieds in html mailings *}
{*
<ul>
{foreach item='classified' from=$items}
    <li>
        <a href="{modurl modname='Classifieds' type='user' func='display' ot=$objectType id=$classified.id fqurl=true}">{$classified->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No classifieds found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_classified_display_description.tpl'}
