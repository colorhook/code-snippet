<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head profile="http://gmpg.org/xfn/11">
	<meta content="text/html;charset=UTF-8" http-equiv="content-type">
	<title>Color Hook Web Site</title>
	<script type="text/javascript" src="assets/js/jquery.js"></script>
	<link rel="stylesheet" href="assets/css/style.css" type="text/css" media="screen" />
	<script type="text/javascript" src="assets/js/jquery.js"></script>
	<script src="assets/js//jquery_plugins.js"></script>
	<script type="text/javascript" src="assets/js/application.js"></script>
</head>
<body>
	<div id="wrapper">
		<?php require(ROOT."/layout/header.php")?>
		<?php require(ROOT."/layout/nav.php")?>
		<div id="main">
			<div id="content">
				<?php print_page();?>
			</div>
			<?php require(ROOT."/layout/sidebar.php")?>
			<div class="clear"></div>
		</div>
		<?php require(ROOT."/layout/footer.php")?>
	</div>
<body>
</html>