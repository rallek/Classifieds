documentation of my changes
======
I try to record all my changes to be able to update easily if MOST generates a newer code.

## user/edit.tpl:

### calculate the future date default

change 
````formdateinput group='classified' id='classifiedEnd' mandatory=true __title='Enter the classified end of the classified' includeTime=true defaultValue='now' cssClass='required validate-DateTime-future ' }````
into 
````{formdateinput group='classified' id='classifiedEnd' mandatory=true __title='Enter the classified end of the classified' includeTime=true defaultValue='custom' cssClass='required validate-DateTime-future' initDate="+`$modvars.Classifieds.defaultPeriod` day" }````

### implement the file size check

``$modvars.Classifieds.pictureFileSize`` instead of ``'102400'``

copy from ``Classifieds\lib\Classifieds\Base\UploadHandler.php``

to ``Classifieds\lib\Classifieds\UploadHandler.php``

the section: 

````
public function __construct()
{...
}
````
change

````$this->allowedFileSizes = array('classified' => array('picture' => 102400, 'picture2' => 0));````

into

````
$this->allowedFileSizes['picture'] = ModUtil::getVar('Classifieds', 'pictureFileSize', 102400);
$this->allowedFileSizes['picture2'] = ModUtil::getVar('Classifieds', 'pictureFileSize', 102400);
````

## user view.tpl

### Access Level changes

change the access-level from ACCESS_EDIT to ACCESS_READ

### Table changes
deleting following colgroups th and td:
* WorkflowState
* Email
* Fon
* Picture2
* ClassifiedStart
* Terms

extend the description ``{$classified.description|truncate:30:"..."}``

make a link of the title:

``<a href="{modurl modname='Classifieds' type='user' func='display' ot='classified' id=$classified.id}" title="{gt text='View detail page'}">{$classified.title}</a>
 ``

**ToDo** in a next step we will arrange all the table items propperly in one column

### quickNav adjustments
````{include file='user/classified/view_quickNav.tpl' all=$all own=$own}{* see template file for available options *}````
change to
````{include file='user/classified/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false termsFilter=false pageSizeSelector=false}{* see template file for available options *}````

## view_quickNav.tpl
Template work:
* clear the search selection for usefull content
* set multicategories from 5 to 1
* add a br behind kind and search

## config.tpl
to show the watermark and dummy pictures we include the following code:
````
	{if $modvars.Classifieds.watermarkPicture ne ''}
	  {thumb image=$modvars.Classifieds.watermarkPicture width=50 height=50 mode='inset' tag=true}
	{/if}
````
and
````
	{if $modvars.Classifieds.pictureDummy ne ''}
	  {thumb image=$modvars.Classifieds.pictureDummy width=100 height=100 mode='inset' tag=true}
	{/if}
````

## user display.tpl
includig dummy.png

inside the dd of the pictures we include the pictures:
````
	{else}
		{thumb image=$modvars.Classifieds.pictureDummy preset=$classifiedThumbPresetPicture mode='inset' tag=true}
	{/if}
````
and
````
	{else}
		{thumb image=$modvars.Classifieds.pictureDummy preset=$classifiedThumbPresetPicture2 mode='inset' tag=true}
	{/if}
````


 
