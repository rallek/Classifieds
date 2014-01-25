<?php
/**
 * Classifieds.
 *
 * @copyright Ralf Koester (RK)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package Classifieds
 * @author Ralf Koester <ralf@familie-koester.de>.
 * @link http://support.zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de).
 */

/**
 * Generic item list content plugin base class.
 */
class Classifieds_ContentType_Base_ItemList extends Content_AbstractContentType
{
    /**
     * The treated object type.
     *
     * @var string
     */
    protected $objectType;
    
    /**
     * The sorting criteria.
     *
     * @var string
     */
    protected $sorting;
    
    /**
     * The amount of desired items.
     *
     * @var integer
     */
    protected $amount;
    
    /**
     * Name of template file.
     *
     * @var string
     */
    protected $template;
    
    /**
     * Name of custom template file.
     *
     * @var string
     */
    protected $customTemplate;
    
    /**
     * Optional filters.
     *
     * @var string
     */
    protected $filter;
    
    /**
     * List of object types allowing categorisation.
     *
     * @var array
     */
    protected $categorisableObjectTypes;
    
    /**
     * List of category registries for different trees.
     *
     * @var array
     */
    protected $catRegistries;
    
    /**
     * List of category properties for different trees.
     *
     * @var array
     */
    protected $catProperties;
    
    /**
     * List of category ids with sub arrays for each registry.
     *
     * @var array
     */
    protected $catIds;
    
    /**
     * Returns the module providing this content type.
     *
     * @return string The module name.
     */
    public function getModule()
    {
        return 'Classifieds';
    }
    
    /**
     * Returns the name of this content type.
     *
     * @return string The content type name.
     */
    public function getName()
    {
        return 'ItemList';
    }
    
    /**
     * Returns the title of this content type.
     *
     * @return string The content type title.
     */
    public function getTitle()
    {
        $dom = ZLanguage::getModuleDomain('Classifieds');
    
        return __('Classifieds list view', $dom);
    }
    
    /**
     * Returns the description of this content type.
     *
     * @return string The content type description.
     */
    public function getDescription()
    {
        $dom = ZLanguage::getModuleDomain('Classifieds');
    
        return __('Display list of Classifieds objects.', $dom);
    }
    
    /**
     * Loads the data.
     *
     * @param array $data Data array with parameters.
     */
    public function loadData(&$data)
    {
        $serviceManager = ServiceUtil::getManager();
        $controllerHelper = new Classifieds_Util_Controller($serviceManager);
    
        $utilArgs = array('name' => 'list');
        if (!isset($data['objectType']) || !in_array($data['objectType'], $controllerHelper->getObjectTypes('contentType', $utilArgs))) {
            $data['objectType'] = $controllerHelper->getDefaultObjectType('contentType', $utilArgs);
        }
    
        $this->objectType = $data['objectType'];
    
        if (!isset($data['sorting'])) {
            $data['sorting'] = 'default';
        }
        if (!isset($data['amount'])) {
            $data['amount'] = 1;
        }
        if (!isset($data['template'])) {
            $data['template'] = 'itemlist_' . $this->objectType . '_display.tpl';
        }
        if (!isset($data['customTemplate'])) {
            $data['customTemplate'] = '';
        }
        if (!isset($data['filter'])) {
            $data['filter'] = '';
        }
    
        $this->sorting = $data['sorting'];
        $this->amount = $data['amount'];
        $this->template = $data['template'];
        $this->customTemplate = $data['customTemplate'];
        $this->filter = $data['filter'];
        $this->categorisableObjectTypes = array('classified');
    
        // fetch category properties
        $this->catRegistries = array();
        $this->catProperties = array();
        if (in_array($this->objectType, $this->categorisableObjectTypes)) {
            $idFields = ModUtil::apiFunc('Classifieds', 'selection', 'getIdFields', array('ot' => $this->objectType));
            $this->catRegistries = ModUtil::apiFunc('Classifieds', 'category', 'getAllPropertiesWithMainCat', array('ot' => $this->objectType, 'arraykey' => $idFields[0]));
            $this->catProperties = ModUtil::apiFunc('Classifieds', 'category', 'getAllProperties', array('ot' => $this->objectType));
        }
    
        if (!isset($data['catIds'])) {
            $primaryRegistry = ModUtil::apiFunc('Classifieds', 'category', 'getPrimaryProperty', array('ot' => $this->objectType));
            $data['catIds'] = array($primaryRegistry => array());
            // backwards compatibility
            if (isset($data['catId'])) {
                $data['catIds'][$primaryRegistry][] = $data['catId'];
                unset($data['catId']);
            }
        } elseif (!is_array($data['catIds'])) {
            $data['catIds'] = explode(',', $data['catIds']);
        }
    
        foreach ($this->catRegistries as $registryId => $registryCid) {
            $propName = '';
            foreach ($this->catProperties as $propertyName => $propertyId) {
                if ($propertyId == $registryId) {
                    $propName = $propertyName;
                    break;
                }
            }
            if (isset($data['catids' . $propName])) {
                $data['catIds'][$propName] = $data['catids' . $propName];
            }
            if (!is_array($data['catIds'][$propName])) {
                if ($data['catIds'][$propName]) {
                    $data['catIds'][$propName] = array($data['catIds'][$propName]);
                } else {
                    $data['catIds'][$propName] = array();
                }
            }
        }
    
        $this->catIds = $data['catIds'];
    }
    
    /**
     * Displays the data.
     *
     * @return string The returned output.
     */
    public function display()
    {
        $dom = ZLanguage::getModuleDomain('Classifieds');
        ModUtil::initOOModule('Classifieds');
    
        $entityClass = 'Classifieds_Entity_' . ucwords($this->objectType);
        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository($entityClass);
    
        // ensure that the view does not look for templates in the Content module (#218)
        $this->view->toplevelmodule = 'Classifieds';
    
        $this->view->setCaching(Zikula_View::CACHE_ENABLED);
        // set cache id
        $component = 'Classifieds:' . ucwords($this->objectType) . ':';
        $instance = '::';
        $accessLevel = ACCESS_READ;
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_COMMENT)) {
            $accessLevel = ACCESS_COMMENT;
        }
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) {
            $accessLevel = ACCESS_EDIT;
        }
        $this->view->setCacheId('view|ot_' . $this->objectType . '_sort_' . $this->sorting . '_amount_' . $this->amount . '_' . $accessLevel);
    
        $template = $this->getDisplayTemplate();
    
        // if page is cached return cached content
        if ($this->view->is_cached($template)) {
            return $this->view->fetch($template);
        }
    
        // create query
        $where = $this->filter;
        $orderBy = $this->getSortParam($repository);
        $qb = $repository->genericBaseQuery($where, $orderBy);
    
        // apply category filters
        if (in_array($this->objectType, $this->categorisableObjectTypes)) {
            if (is_array($this->catIds) && count($this->catIds) > 0) {
                $qb = ModUtil::apiFunc('Classifieds', 'category', 'buildFilterClauses', array('qb' => $qb, 'ot' => $this->objectType, 'catids' => $this->catIds));
            }
        }
    
        // get objects from database
        $currentPage = 1;
        $resultsPerPage = (isset($this->amount) ? $this->amount : 1);
        list($query, $count) = $repository->getSelectWherePaginatedQuery($qb, $currentPage, $resultsPerPage);
        $entities = $query->getResult();
    
        $data = array('objectType' => $this->objectType,
                      'catids' => $this->catIds,
                      'sorting' => $this->sorting,
                      'amount' => $this->amount,
                      'template' => $this->template,
                      'customTemplate' => $this->customTemplate,
                      'filter' => $this->filter);
    
        // assign block vars and fetched data
        $this->view->assign('vars', $data)
                   ->assign('objectType', $this->objectType)
                   ->assign('items', $entities)
                   ->assign($repository->getAdditionalTemplateParameters('contentType'));
    
        // assign category data
        $this->view->assign('registries', $this->catRegistries);
        $this->view->assign('properties', $this->catProperties);
    
        $output = $this->view->fetch($template);
    
        return $output;
    }
    
    /**
     * Returns the template used for output.
     *
     * @return string the template path.
     */
    protected function getDisplayTemplate()
    {
        $templateFile = $this->template;
        if ($templateFile == 'custom') {
            $templateFile = $this->customTemplate;
        }
    
        $templateForObjectType = str_replace('itemlist_', 'itemlist_' . $this->objectType . '_', $templateFile);
    
        $template = '';
        if ($this->view->template_exists('contenttype/' . $templateForObjectType)) {
            $template = 'contenttype/' . $templateForObjectType;
        } elseif ($this->view->template_exists('contenttype/' . $templateFile)) {
            $template = 'contenttype/' . $templateFile;
        } else {
            $template = 'contenttype/itemlist_display.tpl';
        }
    
        return $template;
    }
    
    /**
     * Determines the order by parameter for item selection.
     *
     * @param Doctrine_Repository $repository The repository used for data fetching.
     *
     * @return string the sorting clause.
     */
    protected function getSortParam($repository)
    {
        if ($this->sorting == 'random') {
            return 'RAND()';
        }
    
        $sortParam = '';
        if ($this->sorting == 'newest') {
            $idFields = ModUtil::apiFunc('Classifieds', 'selection', 'getIdFields', array('ot' => $this->objectType));
            if (count($idFields) == 1) {
                $sortParam = $idFields[0] . ' DESC';
            } else {
                foreach ($idFields as $idField) {
                    if (!empty($sortParam)) {
                        $sortParam .= ', ';
                    }
                    $sortParam .= $idField . ' ASC';
                }
            }
        } elseif ($this->sorting == 'default') {
            $sortParam = $repository->getDefaultSortingField() . ' ASC';
        }
    
        return $sortParam;
    }
    
    /**
     * Displays the data for editing.
     */
    public function displayEditing()
    {
        return $this->display();
    }
    
    /**
     * Returns the default data.
     *
     * @return array Default data and parameters.
     */
    public function getDefaultData()
    {
        return array('objectType' => 'classified',
                     'sorting' => 'default',
                     'amount' => 1,
                     'template' => 'itemlist_display.tpl',
                     'customTemplate' => '',
                     'filter' => '');
    }
    
    /**
     * Executes additional actions for the editing mode.
     */
    public function startEditing()
    {
        // ensure that the view does not look for templates in the Content module (#218)
        $this->view->toplevelmodule = 'Classifieds';
    
        // ensure our custom plugins are loaded
        array_push($this->view->plugins_dir, 'modules/Classifieds/templates/plugins');
    
        // assign category data
        $this->view->assign('registries', $this->catRegistries);
        $this->view->assign('properties', $this->catProperties);
    
        // assign categories lists for simulating category selectors
        $dom = ZLanguage::getModuleDomain('Classifieds');
        $locale = ZLanguage::getLanguageCode();
        $categories = array();
        foreach ($this->catRegistries as $registryId => $registryCid) {
            $propName = '';
            foreach ($this->catProperties as $propertyName => $propertyId) {
                if ($propertyId == $registryId) {
                    $propName = $propertyName;
                    break;
                }
            }
    
            //$mainCategory = CategoryUtil::getCategoryByID($registryCid);
            $cats = CategoryUtil::getSubCategories($registryCid, true, true, false, true, false, null, '', null, 'sort_value');
            $catsForDropdown = array(
                array('value' => '', 'text' => __('All', $dom))
            );
            foreach ($cats as $cat) {
                $catName = isset($cat['display_name'][$locale]) ? $cat['display_name'][$locale] : $cat['name'];
                $catsForDropdown[] = array('value' => $cat['id'], 'text' => $catName);
            }
            $categories[$propName] = $catsForDropdown;
        }
    
        $this->view->assign('categories', $categories);
    }
}