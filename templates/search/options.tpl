{* Purpose of this template: Display search options *}
<input type="hidden" id="classifiedsActive" name="active[Classifieds]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="active_classifiedsClassifieds" name="classifiedsSearchTypes[]" value="classified"{if $active_classified} checked="checked"{/if} />
    <label for="active_classifiedsClassifieds">{gt text='Classifieds' domain='module_classifieds'}</label>
</div>
