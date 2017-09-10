<?php

$extensions = array();
foreach (glob('*.xml') as $fileName) {
  $extName = str_replace('.xml', '', $fileName);
  $extensions[$extName] = file_get_contents($fileName);
}
echo json_encode($extensions);
