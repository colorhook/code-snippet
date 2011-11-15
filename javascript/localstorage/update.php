<?php
$client_version = intval($_REQUEST["version"]);
$server_version = 9527;
$data = array();
if($client_version < $server_version){
    $data["version"] = $server_version;
	$data["js"] = "alert($server_version)";
	$data["css"] = "body{background:#f2f2f2;}";
}
echo json_encode($data);
?>