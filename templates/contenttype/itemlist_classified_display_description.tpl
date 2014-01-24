{* Purpose of this template: Display classifieds within an external context *}
<dl>
    {foreach item='classified' from=$items}
        <dt>{$classified->getTitleFromDisplayPattern()}</dt>
        {if $classified.description}
            <dd>{$classified.description|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='Classifieds' type='user' func='display' ot=$objectType id=$classified.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
