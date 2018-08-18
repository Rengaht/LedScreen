color MainColor[]={color(39,170,226),color(4,140,63),color(242,203,5),color(277,33,132),color(64,65,147)};
int MSTAGE=7;

PShader _shader_pixel;
PShader blur;

PShape _text;
PShape[] _shape;
int _stage;

PShape _logo;

PGraphics back,front;
PGraphics pass1, pass2;

ArrayList<PStar> _star;
ArrayList<PTree> _tree;

float _gen_ang=0;
boolean _record=false;
int _start_frame;

float _rot_vel=1000;

int _mtext;
int _index_text;

int STAGE_TIME=3000;
int SHORT_TIME=2000;

int _stage_timer;

color _color_back;
float _index_color=0;

int _index_logo;

void setup(){
   size(900,900,P2D);
   _shader_pixel=loadShader("pixel.glsl");
   _shader_pixel.set("pixelSize",80);
   _text=loadShape("text.svg");
   print(_text.width+" x "+_text.height);
   
   _mtext=_text.getChildCount();
   print("mtext= "+_mtext);
   
   _shape=new PShape[2];
   _shape[0]=loadShape("img-01.svg");
   _shape[1]=loadShape("img-02-stroke.svg");
  
   //_shape[1].disableStyle();
   //_shape[1].setFill(color(0,0,0,0));
   //_shape[1].setStroke(MainColor[2]);
       
       
  _logo=loadShape("logo.svg");
   
   //blur=loadShader("blur.glsl");
  
  
   back = createGraphics(width, height, P2D); 
   front = createGraphics(width, height, P2D); 
   pass1 = createGraphics(width, height, P2D);
   pass1.noSmooth();  
   //pass2 = createGraphics(width, height, P2D);
   //pass2.noSmooth();
   _stage=0;
   
   
   _star=new ArrayList<PStar>();
   _tree=new ArrayList<PTree>();
   reset();
   
   setStage(0);
}
void draw(){
  
  
  update();
  
  background(0);
  back.beginDraw();
  switch(_stage){
     case 0:
     case 5:
       drawGlow(back);
       break;
     case 6:
       drawRainbow(back);
       break;
     default:
        back.background(0);
        break;
  }
  back.endDraw();
  front.beginDraw();
  front.pushStyle();
  //front.background(0);
  front.fill(0,180);
  front.rect(0,0,width,height);
  front.popStyle();
  
    if(_stage==0){
      
       drawLogo(front);
    }else{
      if(_stage<MSTAGE-1) drawWish(front);
      else drawLogo(front);
    }
  front.endDraw();
  
  
   // Applying the blur shader along the vertical direction   
  //blur.set("horizontalPass", 0);
  pass1.beginDraw();
  pass1.background(0,0);
  pass1.shader(_shader_pixel);  
  pass1.image(back, 0, 0);
  pass1.image(front, 0, 0);
  pass1.endDraw();
  
  
  
        
  //filter(blur);
  image(pass1,0,0);
  //image(pass1,0,0);
  //image(pass1,0,0);
  
  drawMask();
  
  if(_record){
    saveFrame("screen####.png");
    //if(frameCount-_start_frame%_rot_vel) _record=false;
  }
  
  //if(_stage==4) drawGlow(this.g);
}

void drawMask(){
  pushStyle();
  fill(0);
  beginShape();
  vertex(0,0);
  vertex(width,0);
  vertex(width,height);
  vertex(0,height);
  
  beginContour();
  float m=200;
  float a=TWO_PI/m;
  for(float i=0;i<m;++i){
     vertex(width/2+width/2*sin(a*i),width/2+width/2*cos(a*i)); 
  }
  endContour();
  
  endShape();
  ellipse(width/2,width/2,width/2,width/2);
  popStyle();
}

void keyPressed(){
 switch(key){
   case 'a':
     setStage(1);
     break;
   case 'q':
     reset();
     setStage(0);
     break;
    case ' ':
      _record=!_record;
      //if(_record){
      //  reset();
      //  setStage(0);
      //}
      //_start_frame=frameCount;
      break;
     case 's':
       saveFrame("screen_shot####.png"); 
        break;
 }
}

void reset(){
  _star.clear();
  for(int i=0;i<5;++i){
     _star.add(new PStar(genPos()));
   }
  _tree.clear();
  for(int i=0;i<5;++i){
     _tree.add(new PTree(genPos()));
   }
  
}

PVector genPos(){
  float a=(_gen_ang+=TWO_PI/5+random(-.2,.2)*PI);
  float r=random(width/4+PICON_MIN/2,width/2-PICON_MIN);
  return new PVector(r,a);
 
}
void setStage(int set_){
  
  if(set_>MSTAGE-1 || set_<0) return;
  
  _stage=set_;
  switch(_stage){
    case 0:
      _index_color=0;
      _index_logo=100;
      break;
    case 1:
      _index_text=0;
      for(PStar p:_star) p.reset();
      for(PTree p:_tree) p.reset();
      _color_back=color(0);
      break;
    case 2:
      for(PStar p:_star) p.reset();
      break;
    case 3:
      for(PTree p:_tree) p.reset();
      break;
    case 4:
      _start_frame=frameCount;
      break;
    case 5:
      _index_color=0;
      break;
    case 6:
      back.beginDraw();
      back.image(front,0,0);
      back.endDraw();
      
      _index_logo=0;
      break;
  }
  _stage_timer=frameCount;  
  println("stage- "+_stage);
}
void update(){
  
     for(PStar p:_star) p.update();
     for(PTree p:_tree) p.update();
    
    
    //boolean dead_=true;
    switch(_stage){
      case 0:
        _index_color=(frameCount-_stage_timer)/(float)(5000/1000.0*60)*5.0;
        return;
      case 1:
        if((frameCount-_stage_timer)%8==0 && _index_text<_mtext-1) _index_text++;
        break;
      case 5:
        _index_color=(frameCount-_stage_timer)/(float)(STAGE_TIME/1000.0*60)*3.0;
        break;
       case 6:
        if((frameCount-_stage_timer)%5==0){
          _index_logo++;
        }
        break;
    }
    
      
      if(_stage==2 || _stage==3){   
        if(frameCount-_stage_timer>=SHORT_TIME/1000.0*60) setStage(_stage+1);    
      }else{
        if(frameCount-_stage_timer>=STAGE_TIME/1000.0*60) setStage(_stage+1);
      }
   
}