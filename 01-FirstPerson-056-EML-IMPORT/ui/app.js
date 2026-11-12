"use strict";
const el=id=>document.getElementById(id);let bridge,config={};
async function main(){bridge=window.betterEndfield;if(!bridge){el("result").textContent="请在 EML 内打开";return;}config=await bridge.readConfig();el("active").checked=!!config.active;el("hide").checked=config.hide_head??true;
const send=async action=>{try{await bridge.send({action});}catch(e){el("result").textContent=String(e);}};
const unsub=bridge.onmessage(m=>{if(m.kind==="reply")try{el("status").textContent=JSON.stringify(typeof m.body==="string"?JSON.parse(m.body):m.body,null,2);}catch(e){el("result").textContent=String(e);}});
el("toggle").onclick=()=>send("toggle");el("exit").onclick=()=>send("exit");el("save").onclick=async()=>{try{const next={...config,enabled:true,active:el("active").checked,hide_head:el("hide").checked};await bridge.saveConfig(next);config=next;el("result").textContent="已保存";}catch(e){el("result").textContent=String(e);}};
const timer=setInterval(()=>send("status"),1500);window.addEventListener("pagehide",()=>{clearInterval(timer);if(typeof unsub==="function")unsub();},{once:true});await send("status");}
main().catch(e=>el("result").textContent=String(e));
