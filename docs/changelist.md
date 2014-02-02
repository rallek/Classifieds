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

### Terms and Condition Link
add the line in the section of terms and conditions:
````
<a href="{$modvars.Classifieds.termsLink}" target="blank">{gt text="terms and conditions"}</a> 
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

* move Kind, description and enddate into column title and arrange with span the classes z-bold, z-sub and z-normal. Move pictures at the first column
* clean the headlines (Sorting of pictures makes no sence), make the Title Headine Classifieds
* chepermissionsblock around the action list with admin rights
* delete ``<p class="z-informationmsg">{gt text='a module for goods you want to sell or you want to buy'}</p>``

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

### watermark hide
via div class z-hide 

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

### Layout
several classes in style.css added and by div grouping managed (to many details for this documentation, see file)

## style.css
several classes for display.tpl added

## image.php
we make the picsices customizable. Copy from base ``Classifieds\lib\Classifieds\Util\Base\Image.php``
````
    public function getCustomPreset($objectType = '', $fieldName = '', $presetName = '', $context = '', $args = array())
    {
	...
	}
````
into the custom class ``Classifieds\lib\Classifieds\Util\Image.php`` and modify the settings:
````
	if ($args['action'] == 'view') {
		$presetData['width'] = ModUtil::getVar('Classifieds', 'thumbPictureWidth', 64); //32;
		$presetData['height'] = ModUtil::getVar('Classifieds', 'thumbPictureHeight', 64); //20;
	} elseif ($args['action'] == 'display') {
		$presetData['width'] = ModUtil::getVar('Classifieds', 'pictureWidth', 200); //250;
		$presetData['height'] = ModUtil::getVar('Classifieds', 'pictureHeight', 200); //150;
````

## user display.tpl
* delete Workflowstate
* delete dd/dt of state, kind, title and terms
*
 
