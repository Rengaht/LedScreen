float PICON_MIN=100;
float PICON_MAX=250;

class PStar{
   float _r,_theta;
   
   float _size;
   float _ang;
   
   float _p;
   float _pvel;
   
   float _grow;
   float _vel;
   
   
   
   PStar(PVector p){
     _r=p.x; 
     _theta=p.y;
     
     _size=random(PICON_MIN,PICON_MAX);
     _ang=random(TWO_PI);
      reset();
   }
   void draw(PGraphics g){
     
       g.pushMatrix();
       g.translate(width/2+_r*sin(_theta),height/2+_r*cos(_theta));
       
       g.rotate(_ang);
       
       //println(_p);
       float w=_size*constrain(_grow,0,1)*(1+_p);
       g.shape(_shape[0],-w/2,-w/2,w,w);
       
       g.popMatrix();
       
   }
   void update(){
     
        
     switch(_stage){
       case 2:
       _grow+=_vel;
       if(_grow>=1) _grow=1;
       break;
       case 4:
       case 5:
         _p=.3*(sin((frameCount-_start_frame)%120/120.0*TWO_PI+_ang));
         break;
       
     }  
     
   }
   void reset(){
      _grow=random(-2,0);
      _vel=random(.01,.05);
      _p=0;
   }
   boolean dead(){
      return _grow>=1;
   }
}


class PTree{
   float _r,_theta;
   float _size;
   float _ang;
   float _p;
   float _grow;
   float _vel;
   
   PTree(PVector p){
     _r=p.x; _theta=p.y;
     _size=random(PICON_MIN,PICON_MAX);
     _ang=_theta+HALF_PI;//random(.1,TWO_PI);
     _p=1;
      reset();
   }
   void draw(PGraphics g){
     
        g.pushMatrix();
       g.translate(width/2+_r*sin(_theta),height/2+_r*cos(_theta));
       
       g.rotate(_ang);
       
       //println(_p);
       float w=_size*constrain(_grow,0,1)*(1+_p);
       g.shape(_shape[1],-w/2,-w/2,w,w);
       
       g.popMatrix();
       
   }
   void update(){
       
       switch(_stage){
         case 3:
           _grow+=_vel;
           if(_grow>=1) _grow=1;
           break;
          
          case 4:
          case 5:
             _p=.2*(sin((frameCount-_start_frame)%120/120.0*TWO_PI+_ang));
             break;
       }    
            
   }
    void reset(){
      _grow=random(-2,0);
      _vel=random(.01,.05);
      _p=0;
   }
   boolean dead(){
       return _grow>=1;
   }
}