{* Purpose of this template: Display classifieds in text mailings *}
{foreach item='classified' from=$items}
{$classified->getTitleFromDisplayPattern()}
{modurl modname='Classifieds' type='user' func='display' ot=$objectType id=$classified.id fqurl=true}
-----
{foreachelse}
{gt text='No classifieds found.'}
{/foreach}
