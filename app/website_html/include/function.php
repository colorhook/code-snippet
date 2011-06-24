<?php
$GLOBALS["Model"];
function initialize(){
	$GLOBALS["Model"]=array(
		"pageMap"=>array(
			"Home"=>"home.php",
			"About"=>"about.php",
			"Portfolio"=>"portfolio.php",
			"Contact"=>"contact.php"
		)
	);
}

function get_model($name){
	return $GLOBALS["Model"][$name];
}
function set_model($name,$value){
	$GLOBALS["Model"][$name]=$value;
}

function doLayout($page){
	set_model("page",$page);
	require(ROOT."/layout/layout.php");
}

function print_page(){
	$page=get_model("page");
	$pages=get_model("pageMap");
	require(ROOT . "/view/" . $pages[$page]);
}

function nav_is($page){
	if(get_model("page")==$page){
		return true;
	}
	return false;
}

function nav_style($page){
	if(nav_is($page)){
		echo 'class="nav-focus"';
	}
}
initialize();
?>