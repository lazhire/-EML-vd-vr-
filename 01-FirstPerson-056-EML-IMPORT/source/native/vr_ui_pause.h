#pragma once
// User intent survives temporary VR menu ownership, but never an explicit exit.
struct VrUiPause {
 bool resume=false;
 void suspended(bool active,bool enabled,bool exit,bool toggle){
  if(exit||!enabled)resume=false;
  else if(toggle)resume=!(resume||active);
  else if(active)resume=true;
 }
 bool released(bool active,bool enabled,bool exit,bool toggle){
  bool enter=resume&&!active&&enabled&&!exit&&!toggle;resume=false;return enter;
 }
};
