<?php
require 'vendor/autoload.php';
use DiDom\Document;
$txt = file_get_contents('./dom.txt');
$document = new Document(stripslashes($txt));
$document->loadHtml(stripslashes($txt));
$items = $document->find('dl.item');
foreach($items as $item) {
  echo "<p>";
  echo "id: " . $item->getAttribute('data-id');
  echo "<br>url:" . $item->find('dt.photo')[0]->find('img')[0]->getAttribute('src');

  $detail = $item->find('dd.detail')[0]->find('.item-name')[0];
  echo "<br>title:" . $detail->text();

  echo "<br> c-price:" .$item->find('.c-price')[0]->text();

  $sPrice = $item->find('.s-price')[0];
  if ($sPrice){
    echo "<br> s-price:" .$item->find('.s-price')[0]->text();
  }
  
  echo "<br> sale-num:".$item->find('.sale-num')[0]->text();

  $rates = $item->find('dd.rates')[0];
  if ($rates) {
    echo "<br> rates:".$item->find('dd.rates')[0]->find('span')[0]->text();
  }
  echo "</p>";
}
?>