{* purpose of this template: classifieds delete confirmation view in admin area *}
{include file='admin/header.tpl'}
<div class="classifieds-classified classifieds-delete">
    {gt text='Delete classified' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='delete' size='small' __alt='Delete'}
        <h3>{$templateTitle}</h3>
    </div>

    <p class="z-warningmsg">{gt text='Do you really want to delete this classified ?'}</p>

    <form class="z-form" action="{modurl modname='Classifieds' type='admin' func='delete' ot='classified' id=$classified.id}" method="post">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" id="confirmation" name="confirmation" value="1" />
            <fieldset>
                <legend>{gt text='Confirmation prompt'}</legend>
                <div class="z-buttons z-formbuttons">
                    {gt text='Delete' assign='deleteTitle'}
                    {button src='14_layer_deletelayer.png' set='icons/small' text=$deleteTitle title=$deleteTitle class='z-btred'}
                    <a href="{modurl modname='Classifieds' type='admin' func='view' ot='classified'}">{icon type='cancel' size='small' __alt='Cancel' __title='Cancel'} {gt text='Cancel'}</a>
                </div>
            </fieldset>

            {notifydisplayhooks eventname='classifieds.ui_hooks.classifieds.form_delete' id="`$classified.id`" assign='hooks'}
            {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
                <legend>{$hookName}</legend>
                {$hook}
            </fieldset>
            {/foreach}
        </div>
    </form>
</div>
{include file='admin/footer.tpl'}
