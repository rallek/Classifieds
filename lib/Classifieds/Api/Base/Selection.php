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
 * Selection api base class.
 */
class Classifieds_Api_Base_Selection extends Zikula_AbstractApi
{
    /**
     * Gets the list of identifier fields for a given object type.
     *
     * @param string $args['ot'] The object type to be treated (optional).
     *
     * @return array List of identifier field names.
     */
    public function getIdFields(array $args = array())
    {
        $objectType = $this->determineObjectType($args, 'getIdFields');
        $entityClass = 'Classifieds_Entity_' . ucfirst($objectType);
    
        $meta = $this->entityManager->getClassMetadata($entityClass);
        if ($this->hasCompositeKeys($objectType)) {
            $idFields = $meta->getIdentifierFieldNames();
        } else {
            $idFields = array($meta->getSingleIdentifierFieldName());
        }
    
        return $idFields;
    }
    
    /**
     * Checks whether a certain entity type uses composite keys or not.
     *
     * @param string $objectType The object type to retrieve.
     *
     * @return boolean Whether composite keys are used or not.
     */
    protected function hasCompositeKeys($objectType)
    {
        $controllerHelper = new Classifieds_Util_Controller($this->serviceManager);
    
        return $controllerHelper->hasCompositeKeys($objectType);
    }
    
    /**
     * Selects a single entity.
     *
     * @param string  $args['ot']       The object type to retrieve (optional).
     * @param mixed   $args['id']       The id (or array of ids) to use to retrieve the object (default=null).
     * @param boolean $args['useJoins'] Whether to include joining related objects (optional) (default=true).
     * @param boolean $args['slimMode'] If activated only some basic fields are selected without using any joins (optional) (default=false).
     *
     * @return mixed Desired entity object or null.
     */
    public function getEntity(array $args = array())
    {
        if (!isset($args['id'])) {
            throw new \InvalidArgumentException(__('Invalid identifier received.'));
        }
        $objectType = $this->determineObjectType($args, 'getEntity');
        $repository = $this->getRepository($objectType);
    
        $idValues = $args['id'];
        $useJoins = isset($args['useJoins']) ? ((bool) $args['useJoins']) : true;
        $slimMode = isset($args['slimMode']) ? ((bool) $args['slimMode']) : false;
    
        $entity = $repository->selectById($idValues, $useJoins, $slimMode);
    
        return $entity;
    }
    
    /**
     * Selects a list of entities by different criteria.
     *
     * @param string  $args['ot']       The object type to retrieve (optional).
     * @param string  $args['where']    The where clause to use when retrieving the collection (optional) (default='').
     * @param string  $args['orderBy']  The order-by clause to use when retrieving the collection (optional) (default='').
     * @param boolean $args['useJoins'] Whether to include joining related objects (optional) (default=true).
     * @param boolean $args['slimMode'] If activated only some basic fields are selected without using any joins (optional) (default=false).
     *
     * @return Array with retrieved collection.
     */
    public function getEntities(array $args = array())
    {
        $objectType = $this->determineObjectType($args, 'getEntities');
        $repository = $this->getRepository($objectType);
    
        $where = isset($args['where']) ? $args['where'] : '';
        $orderBy = isset($args['orderBy']) ? $args['orderBy'] : '';
        $useJoins = isset($args['useJoins']) ? ((bool) $args['useJoins']) : true;
        $slimMode = isset($args['slimMode']) ? ((bool) $args['slimMode']) : false;
    
        return $repository->selectWhere($where, $orderBy, $useJoins, $slimMode);
    }
    
    /**
     * Selects a list of entities by different criteria.
     *
     * @param string  $args['ot']             The object type to retrieve (optional).
     * @param string  $args['where']          The where clause to use when retrieving the collection (optional) (default='').
     * @param string  $args['orderBy']        The order-by clause to use when retrieving the collection (optional) (default='').
     * @param integer $args['currentPage']    Where to start selection.
     * @param integer $args['resultsPerPage'] Amount of items to select.
     * @param boolean $args['useJoins']       Whether to include joining related objects (optional) (default=true).
     * @param boolean $args['slimMode']       If activated only some basic fields are selected without using any joins (optional) (default=false).
     *
     * @return Array with retrieved collection and amount of total records affected by this query.
     */
    public function getEntitiesPaginated(array $args = array())
    {
        $objectType = $this->determineObjectType($args, 'getEntitiesPaginated');
        $repository = $this->getRepository($objectType);
    
        $where = isset($args['where']) ? $args['where'] : '';
        $orderBy = isset($args['orderBy']) ? $args['orderBy'] : '';
        $currentPage = isset($args['currentPage']) ? $args['currentPage'] : 1;
        $resultsPerPage = isset($args['resultsPerPage']) ? $args['resultsPerPage'] : 25;
        $useJoins = isset($args['useJoins']) ? ((bool) $args['useJoins']) : true;
        $slimMode = isset($args['slimMode']) ? ((bool) $args['slimMode']) : false;
    
        return $repository->selectWherePaginated($where, $orderBy, $currentPage, $resultsPerPage, $useJoins, $slimMode);
    }
    
    /**
     * Determines object type using controller util methods.
     *
     * @param string $args['ot'] The object type to retrieve (optional).
     * @param string $methodName Name of calling method.
     *
     * @return string the object type.
     */
    protected function determineObjectType(array $args = array(), $methodName = '')
    {
        $objectType = isset($args['ot']) ? $args['ot'] : '';
        $controllerHelper = new Classifieds_Util_Controller($this->serviceManager);
        $utilArgs = array('api' => 'selection', 'action' => $methodName);
        if (!in_array($objectType, $controllerHelper->getObjectTypes('api', $utilArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('api', $utilArgs);
        }
    
        return $objectType;
    }
    
    /**
     * Returns repository instance for a certain object type.
     *
     * @param string $objectType The desired object type.
     *
     * @return mixed Repository class instance or null.
     */
    protected function getRepository($objectType = '')
    {
        if (empty($objectType)) {
            throw new \InvalidArgumentException(__('Invalid object type received.'));
        }
    
        $entityClass = 'Classifieds_Entity_' . ucwords($objectType);
    
        return $this->entityManager->getRepository($entityClass);
    }
}
