<?php
header("Content-type: text/html; charset=utf-8"); 
require_once dirname(__FILE__) . "/XMPPHP/XMPP.php";

class SinaFetcher{

	public $appkey = '506163941';
	public $username = '正邪邪邪';

	public function getTimeline(){
		$url = "http://api.t.sina.com.cn/statuses/user_timeline.json?screen_name=". urlencode($this->username). "&source=" . $this->appkey;
		$timeline = file_get_contents($url);
		$timeline = json_decode($timeline);
		return $timeline;
	}
	
	public function getValidTimeline($lastid){
		$timeline = $this->getTimeline();
		$arr = array();
		$newid = $lastid;

		foreach($timeline as $item){
			$id = floatval($item->id);
			if($id > $lastid){
				$newid = $id > $newid ? $id: $newid;
				$text = $item->text;
				array_push($arr, $text);
			}
		}
		return array(
			"newid" => $newid,
			"timeline" => $arr
		);
	}
}

class Main{

	public $file = "lastid.log";
	public $sinaFector;
	public $renrenID = '197262681';
	public $renrenPassword;
	private $renrenPasswordConfig = 'renrenPassword.ini';

	public function init(){
		
		if(!file_exists($this->file)){
			touch($this->file);
		}
		$this->renrenPassword = file_get_contents($this->renrenPasswordConfig);
		$this->sinaFetcher = new SinaFetcher();
	}


	public function getLastID(){
		$str = file_get_contents($this->file);
		return floatval($str);
	}

	public function updateID($newid){
		file_put_contents($this->file, $newid);
	}

	public function updateRenren($statuses){
		$conn = new XMPPHP_XMPP('talk.xiaonei.com', 5222, $this->renrenID, $this->renrenPassword, 'xmpphp', 'talk.xiaonei.com', $printlog=False, $loglevel=LOGGING_INFO);
		$conn->connect();
		$conn->processUntil('session_start');
		foreach($statuses as $item){
			echo '更新：'. $item . '<br/>';
			//$conn->presence($item);
		}
		$conn->disconnect();
	}
	
	public function sync(){
		$lastid = $this->getLastID();
		$data = $this->sinaFetcher->getValidTimeline($lastid);
		$newid = $data['newid'];
		$timeline = $data['timeline'];
		if(sizeof($timeline) == 0){
			return;
		}
		$this->updateRenren($timeline);
		$this->updateID($newid);
	}
}

$instance = new Main();
$instance->init();
$instance->sync();
?>