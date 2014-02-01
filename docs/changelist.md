documentation of my changes
======
I try to record all my changes to be able to update easily if MOST generates a newer code.

## user/edit.tpl:

### calculate the future date default

change 
````formdateinput group='classified' id='classifiedEnd' mandatory=true __title='Enter the classified end of the classified' includeTime=true defaultValue='now' cssClass='required validate-DateTime-future validate-daterange-classified' }````
into 
````{formdateinput group='classified' id='classifiedEnd' mandatory=true __title='Enter the classified end of the classified' includeTime=true defaultValue='custom' cssClass='required validate-DateTime-future' initDate="+`$modvars.Classifieds.defaultPeriod` day" }````

### implement the file size check

``$modvars.Classifieds.pictureFileSize`` instead of ``'102400'``


 