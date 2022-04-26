import java.util.*;
import ketai.ui.*;


import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.Color;
import android.widget.TextView;
import android.view.Gravity;

Activity act;
TextView msg;

float x, y, vy;
float g_    = 0.25;
float r_    = -0.75;

int x_      = 0;
int d       = 0;

int y_limit = 0;
int x_limit = 0;

int next    = 0;
ArrayList<Integer> points = new ArrayList();

float speed_jump   = 10000000;
KetaiGesture gesture;

void setup(){
  fullScreen();
  orientation(LANDSCAPE);
  stroke(255, 255, 0);
  noFill();
  strokeWeight(2);
  gesture = new KetaiGesture(this);
  vy = 0;
  y  = 0;
  x  = 100;
}

void draw(){
  background(0); 
  vy+=g_;
  y+=vy;
  for(int x = 0; x < 4; x++){
    points.add(new Random().nextInt((500 - 300) + 1) + 300);
  }
  for(int y_ = 0; y_ < points.size(); y_++){
       if(x_ + 250 >= 0 && y_limit == 0){
         y_limit = points.get(y_);
       }else{
         next++;
       }
       rect(x_, points.get(y_), 300, 300);
       x_+=300;
    }
  
  if(y > y_limit - 40){
    y-=5;
    vy*=r_;
    speed_jump = 10000000;
  }
  y = lerp(y, y*speed_jump/10000000, 0.02);
  
  pushStyle();
  fill(255, 255, 0);
  ellipse(x, y, 80, 80);
  popStyle();
  
  /* Update */
  y_limit = 0;
  x_ = 0;
  d-= 5;
  x_ = d;
  
}


void onFlick(float x_dep, float y_dep, float px, float py, float v){
  speed_jump = v;
}

void backPressed(){
 dialogBox();
}

void dialogBox() {
  act = this.getActivity();
  
  TextView msg = new TextView(act); 
  msg.setGravity(Gravity.CENTER_HORIZONTAL); 
  msg.setTextColor(Color.BLACK); 
  
  act.runOnUiThread(new Runnable() {
    public void run() {
      new AlertDialog.Builder(act)
        .setTitle("Voulez-vous quitter ?")
        .setPositiveButton("NON", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
        }
      }
      )
      .setNegativeButton("OUI", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
          act.finish();
        }
      }
      )
      .show();
    }
  }
  );
}
