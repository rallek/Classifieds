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
 * The classifiedsItemSelector plugin provides items for a dropdown selector.
 *
 * @param  array            $params All attributes passed to this function from the template.
 * @param  Zikula_Form_View $view   Reference to the view object.
 *
 * @return string The output of the plugin.
 */
function smarty_function_classifiedsItemSelector($params, $view)
{
    return $view->registerPlugin('Classifieds_Form_Plugin_ItemSelector', $params);
}
