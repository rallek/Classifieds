{foreach item='classified' from=$items}
    <h3>{$classified->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='Classifieds' type='user' func='display' ot=$objectType id=$classified.id}">{gt text='Read more'}</a></br> mein Block
    </p>
{/foreach}