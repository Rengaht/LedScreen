void drawLogo(PGraphics pg){
  
  pg.pushStyle();
  //pg.colorMode(HSB);
  
  pg.pushMatrix();
  pg.scale(width/_logo.width);
  
  int mlogo=_logo.getChildCount();
  if(_index_logo==8+mlogo) _start_frame=frameCount;
  if(_index_logo>8+mlogo){
    pg.translate(_logo.width/2,_logo.height/2);
    pg.rotate((frameCount-_start_frame)%floor(_rot_vel)/(_rot_vel)*TWO_PI);
    pg.translate(-_logo.width/2,-_logo.height/2);
  }
  
  if(_index_logo>8){
    
    for(int i=0;i<min(_index_logo-8,mlogo);++i){
      pg.shape(_logo.getChild(i),0,0);
    }
  }
  pg.popMatrix();
  
  pg.popStyle();
}

void drawWish(PGraphics pg){
  
  //pg.background(_color_back);
  
   
      
   for(PStar p:_star) p.draw(pg);
   for(PTree p:_tree) p.draw(pg);

  
  pg.pushMatrix();
  
  pg.scale(width/_text.width);
  pg.translate(_text.width/2,_text.height/2);
  if(_stage>3) pg.rotate((frameCount-_start_frame)%floor(_rot_vel)/_rot_vel*TWO_PI);
  pg.translate(-_text.width/2,-_text.height/2);
  
  for(int i=0;i<_index_text;++i){
    pg.shape(_text.getChild(i),0,0);
  }
  //if(frameCount%30==0) _index_text=(_index_text+1)%_mtext;
  //src.shape(_text,0,0);
  
  
 
   pg.popMatrix();
   

    
  
}
void drawGlow(PGraphics pg){
  
  pg.pushStyle();
  pg.ellipseMode(CENTER);
  pg.pushMatrix();
  pg.translate(width/2,height/2);
  
  //println(_index_color);
  
  float seg=10;
  float pos=_index_color-floor(_index_color);
  float mlayer=pos*seg;
  float rad=width/2*1.2/(seg);
  
  
  for(float i=mlayer-1;i>=0;i--){
    pg.fill(lerpColor(color(0),MainColor[floor(_index_color)%5],.2+.8*i/seg));
    pg.ellipse(0,0,width/2+(i+1)*rad,width/2+(i+1)*rad);
  }
  
  pg.popMatrix();
  pg.popStyle();
}

void drawRainbow(PGraphics pg){
  
   float m=20;
  float ang=TWO_PI/m;
  
  pg.pushMatrix();
  pg.translate(width/2,height/2);
  pg.rotate(PI);
  for(int i=0;i<min(_index_logo,m);++i){
      //pg.fill(i*100.0/m,100,100);
      pg.fill(lerpColor(MainColor[i/5],MainColor[(i/5+1)%5],(i%5)*.2));
      pg.arc(0,0,width,width,TWO_PI-(i+1)*ang,TWO_PI-(i)*ang);
  }
  pg.popMatrix();
}