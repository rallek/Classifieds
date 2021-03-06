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
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de).
 */

/**
 * Item selector plugin base class.
 */
class Classifieds_Form_Plugin_Base_ItemSelector extends Zikula_Form_Plugin_TextInput
{
    /**
     * The treated object type.
     *
     * @var string
     */
    public $objectType = '';

    /**
     * Identifier of selected object.
     *
     * @var integer
     */
    public $selectedItemId = 0;

    /**
     * Get filename of this file.
     * The information is used to re-establish the plugins on postback.
     *
     * @return string
     */
    public function getFilename()
    {
        return __FILE__;
    }

    /**
     * Create event handler.
     *
     * @param Zikula_Form_View $view    Reference to Zikula_Form_View object.
     * @param array            &$params Parameters passed from the Smarty plugin function.
     *
     * @see    Zikula_Form_AbstractPlugin
     * @return void
     */
    public function create(Zikula_Form_View $view, &$params)
    {
        $params['maxLength'] = 11;
        /*$params['width'] = '8em';*/

        // let parent plugin do the work in detail
        parent::create($view, $params);
    }

    /**
     * Helper method to determine css class.
     *
     * @see    Zikula_Form_Plugin_TextInput
     *
     * @return string the list of css classes to apply
     */
    protected function getStyleClass()
    {
        $class = parent::getStyleClass();
        return str_replace('z-form-text', 'z-form-itemlist ' . strtolower($this->objectType), $class);
    }

    /**
     * Render event handler.
     *
     * @param Zikula_Form_View $view Reference to Zikula_Form_View object.
     *
     * @return string The rendered output
     */
    public function render(Zikula_Form_View $view)
    {
        static $firstTime = true;
        if ($firstTime) {
            PageUtil::addVar('javascript', 'prototype');
            PageUtil::addVar('javascript', 'Zikula.UI'); // imageviewer
            PageUtil::addVar('javascript', 'modules/Classifieds/javascript/Classifieds_finder.js');
            PageUtil::addVar('stylesheet', ThemeUtil::getModuleStylesheet('Classifieds'));
        }
        $firstTime = false;

        if (!SecurityUtil::checkPermission('Classifieds:' . ucwords($this->objectType) . ':', '::', ACCESS_COMMENT)) {
            return false;
        }

        $categorisableObjectTypes = array('classified');
        $catIds = array();
        if (in_array($this->objectType, $categorisableObjectTypes)) {
            // fetch selected categories to reselect them in the output
            // the actual filtering is done inside the repository class
            $catIds = ModUtil::apiFunc('Classifieds', 'category', 'retrieveCategoriesFromRequest', array('ot' => $this->objectType));
        }

        $this->selectedItemId = $this->text;

        $entityClass = 'Classifieds_Entity_' . ucwords($this->objectType);
        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository($entityClass);

        $sort = $repository->getDefaultSortingField();
        $sdir = 'asc';

        // convenience vars to make code clearer
        $where = '';
        $sortParam = $sort . ' ' . $sdir;

        $entities = $repository->selectWhere($where, $sortParam);

        $view = Zikula_View::getInstance('Classifieds', false);
        $view->assign('objectType', $this->objectType)
             ->assign('items', $entities)
             ->assign('selectedId', $this->selectedItemId);

        // assign category properties
        $properties = null;
        if (in_array($this->objectType, $categorisableObjectTypes)) {
            $properties = ModUtil::apiFunc('Classifieds', 'category', 'getAllProperties', array('ot' => $this->objectType));
        }
        $view->assign('properties', $properties)
             ->assign('catIds', $catIds);

        return $view->fetch('external/' . $this->objectType . '/select.tpl');
    }

    /**
     * Decode event handler.
     *
     * @param Zikula_Form_View $view Zikula_Form_View object.
     *
     * @return void
     */
    public function decode(Zikula_Form_View $view)
    {
        parent::decode($view);
        $this->objectType = FormUtil::getPassedValue('Classifieds_objecttype', 'classified', 'POST');
        $this->selectedItemId = $this->text;
    }
}
