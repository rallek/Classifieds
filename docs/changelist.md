user/edit.tpl:
======

Use modVars

``$modvars.Classifieds.pictureFileSize`` instead of ``'102400'``

change 
````formdateinput group='classified' id='classifiedEnd' mandatory=true __title='Enter the classified end of the classified' includeTime=true defaultValue='now' cssClass='required validate-DateTime-future validate-daterange-classified' }````
into 
````{formdateinput group='classified' id='classifiedEnd' mandatory=true __title='Enter the classified end of the classified' includeTime=true defaultValue='custom' cssClass='required validate-DateTime-future' initDate="+`$modvars.Classifieds.defaultPeriod` day" }````
 