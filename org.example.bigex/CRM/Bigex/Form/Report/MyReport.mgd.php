<?php
// This file declares a managed database record of type "ReportTemplate".
// The record will be automatically inserted, updated, or deleted from the
// database as appropriate. For more details, see "hook_civicrm_managed" at:
// http://wiki.civicrm.org/confluence/display/CRMDOC42/Hook+Reference
return array (
  0 => 
  array (
    'name' => 'CRM_Bigex_Form_Report_MyReport',
    'entity' => 'ReportTemplate',
    'params' => 
    array (
      'version' => 3,
      'label' => 'MyReport',
      'description' => 'MyReport (org.example.bigex)',
      'class_name' => 'CRM_Bigex_Form_Report_MyReport',
      'report_url' => 'org.example.bigex/myreport',
      'component' => 'CiviContribute',
    ),
  ),
);