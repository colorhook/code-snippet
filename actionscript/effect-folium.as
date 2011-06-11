import flash.display.Graphics;
import flash.display.Sprite;

function drawLeaf(g:Graphics, 
			a:Number = 100,
			n:Number = 2, 
			startX:Number= 0, 
			startY:Number = 0, 
			d:Number = 1){
	
	var deg:Number = 0, PI_180:Number =Math.PI/180;
	g.beginFill(0x000000);
	g.moveTo(startX, startY);
	for(; deg<360; deg+=d){
		var r = a * Math.sin(n* deg * PI_180);
		x = r * Math.cos(deg);
		y = r * Math.sin(deg);
		g.lineTo(x+startX, y+startY);
	}
	g.endFill();
}

var sprite:Sprite = new Sprite();
addChild(sprite);

this.addEventListener(Event.ENTER_FRAME, loop);
var i:Number = 0;
function loop(e:Event):void{
	sprite.graphics.clear();
	i += 0.01;
	drawLeaf( sprite.graphics, 50, i, 100, 100);
	drawLeaf( sprite.graphics, 50, i, 200, 100, 2);
	drawLeaf( sprite.graphics, 50, i, 300, 100, 4);
	drawLeaf( sprite.graphics, 50, i, 100, 200, 8);
	drawLeaf( sprite.graphics, 50, i, 200, 200, 12);
	drawLeaf( sprite.graphics, 50, i, 300, 200, 24);
}