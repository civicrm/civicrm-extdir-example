<?php

$extensions = array();
foreach (glob(__DIR__.'/../*.xml') as $fileName) {
  $extName = str_replace('.xml', '', basename($fileName));
  $extensions[$extName] = file_get_contents($fileName);
}
echo json_encode($extensions);
