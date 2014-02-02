<?php
/**
 * Classifieds.
 *
 * @copyright Ralf Koester (Rallek)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package Classifieds
 * @author Ralf Koester <ralf@familie-koester.de>.
 * @link http://support.zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de) at Sun Feb 02 09:25:59 CET 2014.
 */

/**
 * Version information base class.
 */
class Classifieds_Base_Version extends Zikula_AbstractVersion
{
    /**
     * Retrieves meta data information for this application.
     *
     * @return array List of meta data.
     */
    public function getMetaData()
    {
        $meta = array();
        // the current module version
        $meta['version']              = '0.2.5';
        // the displayed name of the module
        $meta['displayname']          = $this->__('Classifieds');
        // the module description
        $meta['description']          = $this->__('With classifieds you can manage your own market.');
        //! url version of name, should be in lowercase without space
        $meta['url']                  = $this->__('classifieds');
        // core requirement
        $meta['core_min']             = '1.3.5'; // requires minimum 1.3.5
        $meta['core_max']             = '1.3.6'; // not ready for 1.3.7 yet

        // define special capabilities of this module
        $meta['capabilities'] = array(
                          HookUtil::SUBSCRIBER_CAPABLE => array('enabled' => true)
/*,
                          HookUtil::PROVIDER_CAPABLE => array('enabled' => true), // TODO: see #15
                          'authentication' => array('version' => '1.0'),
                          'profile'        => array('version' => '1.0', 'anotherkey' => 'anothervalue'),
                          'message'        => array('version' => '1.0', 'anotherkey' => 'anothervalue')
*/
        );

        // permission schema
        $meta['securityschema'] = array(
            'Classifieds::' => '::',
            'Classifieds::Ajax' => '::',
            'Classifieds:ItemListBlock:' => 'Block title::',
            'Classifieds:Classified:' => 'Classified ID::',
        );
        // DEBUG: permission schema aspect ends


        return $meta;
    }

    /**
     * Define hook subscriber bundles.
     */
    protected function setupHookBundles()
    {
        
        $bundle = new Zikula_HookManager_SubscriberBundle($this->name, 'subscriber.classifieds.ui_hooks.classifieds', 'ui_hooks', __('classifieds Classifieds Display Hooks'));
        
        // Display hook for view/display templates.
        $bundle->addEvent('display_view', 'classifieds.ui_hooks.classifieds.display_view');
        // Display hook for create/edit forms.
        $bundle->addEvent('form_edit', 'classifieds.ui_hooks.classifieds.form_edit');
        // Display hook for delete dialogues.
        $bundle->addEvent('form_delete', 'classifieds.ui_hooks.classifieds.form_delete');
        // Validate input from an ui create/edit form.
        $bundle->addEvent('validate_edit', 'classifieds.ui_hooks.classifieds.validate_edit');
        // Validate input from an ui create/edit form (generally not used).
        $bundle->addEvent('validate_delete', 'classifieds.ui_hooks.classifieds.validate_delete');
        // Perform the final update actions for a ui create/edit form.
        $bundle->addEvent('process_edit', 'classifieds.ui_hooks.classifieds.process_edit');
        // Perform the final delete actions for a ui form.
        $bundle->addEvent('process_delete', 'classifieds.ui_hooks.classifieds.process_delete');
        $this->registerHookSubscriberBundle($bundle);

        $bundle = new Zikula_HookManager_SubscriberBundle($this->name, 'subscriber.classifieds.filter_hooks.classifieds', 'filter_hooks', __('classifieds Classifieds Filter Hooks'));
        // A filter applied to the given area.
        $bundle->addEvent('filter', 'classifieds.filter_hooks.classifieds.filter');
        $this->registerHookSubscriberBundle($bundle);

        
    }
}
