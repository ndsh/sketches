void getTracker(boolean recording) {
	if(recording) {
		buffer.beginDraw();
		// buffer.fill(foregroundColor, 10);
		if (lastX == mouse.x && lastY == mouse.y) {
			buffer.noFill();
			buffer.stroke(foregroundColor2, 10);
			buffer.strokeWeight(1);
			buffer.ellipse(mouse.x, mouse.y, 20+weight, 20+weight);
			 
			buffer.noStroke();
			buffer.fill(255, 03);
			buffer.ellipse(mouse.x, mouse.y, 10+weight, 10+weight);
			if(weight <= 5) weight = weight+.05;
		} else {
			if(lastX != mouse.x) amountX++;
			if(lastY != mouse.y) amountY++;
			buffer.stroke(foregroundColor);
			buffer.strokeWeight(.5);
			buffer.line(lastX, lastY, mouse.x, mouse.y);
			weight = .05;	
		}
		buffer.endDraw();
	}	
}

String addZeros(int n) {
	return nf(n,2);
}