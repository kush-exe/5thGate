(()=>{var b=e=>new Promise(a=>setTimeout(a,e)),x=e=>{let a=GetEntityModel(e),t=GetHashKey("mp_m_freemode_01"),r=GetHashKey("mp_f_freemode_01");return a===t||a===r},f=e=>{let a=GetEntityModel(e),t=GetHashKey("mp_m_freemode_01");return a===t};function g(e){return{x:e[0],y:e[1],z:e[2]}}var O=[0,1,2,3,4,5,6,7,8,9,10,11],D=[0,1,2,6,7],F=["noseWidth","nosePeakHigh","nosePeakSize","noseBoneHigh","nosePeakLowering","noseBoneTwist","eyeBrownHigh","eyeBrownForward","cheeksBoneHigh","cheeksBoneWidth","cheeksWidth","eyesOpening","lipsThickness","jawBoneWidth","jawBoneBackSize","chinBoneLowering","chinBoneLenght","chinBoneSize","chinHole","neckThickness"],S=["blemishes","beard","eyebrows","ageing","makeUp","blush","complexion","sunDamage","lipstick","moleAndFreckles","chestHair","bodyBlemishes"],le=["Green","Emerald","Light Blue","Ocean Blue","Light Brown","Dark Brown","Hazel","Dark Gray","Light Gray","Pink","Yellow","Purple","Blackout","Shades of Gray","Tequila Sunrise","Atomic","Warp","ECola","Space Ranger","Ying Yang","Bullseye","Lizard","Dragon","Extra Terrestrial","Goat","Smiley","Possessed","Demon","Infected","Alien","Undead","Zombie"];var se={ped:!0,headBlend:!0,faceFeatures:!0,headOverlays:!0,components:!0,props:!0,tattoos:!0},J={head:{animations:{on:{dict:"mp_masks@standard_car@ds@",anim:"put_on_mask",move:51,duration:600},off:{dict:"missheist_agency2ahelmet",anim:"take_off_helmet_stand",move:51,duration:1200}},props:{male:[[1,0]],female:[[1,0]]}},body:{animations:{on:{dict:"clothingtie",anim:"try_tie_negative_a",move:51,duration:1200},off:{dict:"clothingtie",anim:"try_tie_negative_a",move:51,duration:1200}},props:{male:[[11,252],[3,15],[8,15],[10,0],[5,0]],female:[[11,15],[8,14],[3,15],[10,0],[5,0]]}},bottom:{animations:{on:{dict:"re@construction",anim:"out_of_breath",move:51,duration:1300},off:{dict:"re@construction",anim:"out_of_breath",move:51,duration:1300}},props:{male:[[4,61],[6,34]],female:[[4,15],[6,35]]}}};function ce(){RegisterNuiCallbackType("appearance_get_locales"),RegisterNuiCallbackType("appearance_get_settings_and_data"),RegisterNuiCallbackType("appearance_set_camera"),RegisterNuiCallbackType("appearance_turn_around"),RegisterNuiCallbackType("appearance_rotate_camera"),RegisterNuiCallbackType("appearance_change_model"),RegisterNuiCallbackType("appearance_change_head_blend"),RegisterNuiCallbackType("appearance_change_face_feature"),RegisterNuiCallbackType("appearance_change_hair"),RegisterNuiCallbackType("appearance_change_head_overlay"),RegisterNuiCallbackType("appearance_change_eye_color"),RegisterNuiCallbackType("appearance_change_component"),RegisterNuiCallbackType("appearance_change_prop"),RegisterNuiCallbackType("appearance_apply_tattoo"),RegisterNuiCallbackType("appearance_preview_tattoo"),RegisterNuiCallbackType("appearance_delete_tattoo"),RegisterNuiCallbackType("appearance_wear_clothes"),RegisterNuiCallbackType("appearance_remove_clothes"),RegisterNuiCallbackType("appearance_save"),RegisterNuiCallbackType("appearance_exit"),RegisterNuiCallbackType("rotate_left"),RegisterNuiCallbackType("rotate_right"),RegisterNuiCallbackType("get_theme_configuration"),on("__cfx_nui:appearance_get_locales",(e,a)=>{a(ge)}),on("__cfx_nui:appearance_get_settings_and_data",(e,a)=>{let t=_e(),r=$(),o=q();a({config:t,appearanceData:r,appearanceSettings:o})}),on("__cfx_nui:appearance_set_camera",(e,a)=>{a({}),ee(e)}),on("__cfx_nui:appearance_turn_around",(e,a)=>{a({}),B(PlayerPedId(),180)}),on("__cfx_nui:appearance_rotate_camera",(e,a)=>{a({}),ue(e)}),on("__cfx_nui:appearance_change_model",async(e,a)=>{await L(e);let t=PlayerPedId();SetEntityHeading(PlayerPedId(),Z),SetEntityInvincible(t,!0),TaskStandStill(t,-1);let r=C(t),o=q();a({appearanceSettings:o,appearanceData:r})}),on("__cfx_nui:appearance_change_component",(e,a)=>{let t=PlayerPedId();z(t,e),a(Q(t,e.component_id))}),on("__cfx_nui:appearance_change_prop",(e,a)=>{let t=PlayerPedId();V(t,e),a(X(t,e.prop_id))}),on("__cfx_nui:appearance_change_head_blend",(e,a)=>{a({}),M(PlayerPedId(),e)}),on("__cfx_nui:appearance_change_face_feature",(e,a)=>{a({}),k(PlayerPedId(),e)}),on("__cfx_nui:appearance_change_head_overlay",(e,a)=>{a({}),G(PlayerPedId(),e)}),on("__cfx_nui:appearance_change_hair",(e,a)=>{let t=PlayerPedId();N(t,e),a(de(t,e))}),on("__cfx_nui:appearance_change_eye_color",(e,a)=>{a({}),T(PlayerPedId(),e)}),on("__cfx_nui:appearance_apply_tattoo",(e,a)=>{a({}),me(PlayerPedId(),e)}),on("__cfx_nui:appearance_preview_tattoo",(e,a)=>{a({});let{data:t,tattoo:r}=e;ve(PlayerPedId(),t,r)}),on("__cfx_nui:appearance_delete_tattoo",(e,a)=>{a({}),Pe(PlayerPedId(),e)}),on("__cfx_nui:appearance_wear_clothes",(e,a)=>{a({});let{data:t,key:r}=e;ye(t,r)}),on("__cfx_nui:appearance_remove_clothes",(e,a)=>{a({}),pe(e)}),on("__cfx_nui:appearance_save",(e,a)=>{a({}),Y(e)}),on("__cfx_nui:appearance_exit",(e,a)=>{a({}),Y()}),on("__cfx_nui:rotate_left",(e,a)=>{a({}),B(PlayerPedId(),10)}),on("__cfx_nui:rotate_right",(e,a)=>{a({}),B(PlayerPedId(),-10)}),on("__cfx_nui:get_theme_configuration",(e,a)=>{a(fe)})}var Oe=global.exports,he={default:{coords:{x:0,y:2.2,z:.2},point:{x:0,y:0,z:-.05}},head:{coords:{x:0,y:.9,z:.65},point:{x:0,y:0,z:.6}},body:{coords:{x:0,y:1.2,z:.2},point:{x:0,y:0,z:.2}},bottom:{coords:{x:0,y:.98,z:-.7},point:{x:0,y:0,z:-.9}}},De={default:{x:1.5,y:-1},head:{x:.7,y:-.45},body:{x:1.2,y:-.45},bottom:{x:.7,y:-.45}},U,ae,A,I,Z,m,w,H,h,xe={};function Ce(){let e={hair:[],makeUp:[]};for(let a=0;a<GetNumHairColors();a++)e.hair.push(GetPedHairRgbColor(a));for(let a=0;a<GetNumMakeupColors();a++)e.makeUp.push(GetMakeupRgbColor(a));return e}function $(){return A||(A=C(PlayerPedId())),A}function Be(e,a,t,r){if(a===t&&e.textures!==void 0)for(let o=0;o<e.textures.length;o++)r.textures.push(e.textures[o]);(e.textures===void 0||e.textures.length===0)&&r.drawables.push(a)}function He(e,a){var t={drawables:[],textures:[]};let r=Fe(),o=Se();for(let i=0;i<e.length;i++){let n=e[i];if(!(n.jobs&&n.jobs.includes(r)||n.gangs&&n.gangs.includes(o))&&n.drawables)for(let l=0;l<n.drawables.length;l++)Be(n,n.drawables[l],a,t)}return t}function Le(e,a){let t=E.male.components;switch(e||(t=E.female.components),a){case 1:return t.masks;case 3:return t.upperBody;case 4:return t.lowerBody;case 5:return t.bags;case 6:return t.shoes;case 7:return t.scarfAndChains;case 8:return t.shirts;case 9:return t.bodyArmor;case 10:return t.decals;case 11:return t.jackets;default:break}return[]}function ze(e,a){let t=E.male.props;switch(e||(t=E.female.props),a){case 0:return t.hats;case 1:return t.glasses;case 2:return t.ear;case 6:return t.watches;case 7:return t.bracelets;default:break}return[]}function Q(e,a){let t=GetPedDrawableVariation(e,a),r=f(e);var o={drawables:[],textures:[]};return x(e)&&(o=He(Le(r,a),t)),{component_id:a,drawable:{min:0,max:GetNumberOfPedDrawableVariations(e,a)-1},texture:{min:0,max:GetNumberOfPedTextureVariations(e,a,t)-1},blacklist:o}}function X(e,a){let t=GetPedPropIndex(e,a),r=f(e);var o={drawables:[],textures:[]};return x(e)&&(o=He(ze(r,a),t)),{prop_id:a,drawable:{min:-1,max:GetNumberOfPedPropDrawableVariations(e,a)-1},texture:{min:-1,max:GetNumberOfPedPropTextureVariations(e,a,t)-1},blacklist:o}}function de(e,a){let t=Ce();return{style:{min:0,max:GetNumberOfPedDrawableVariations(e,2)-1},color:{items:t.hair},highlight:{items:t.hair},texture:{min:0,max:GetNumberOfPedTextureVariations(e,2,a.style)-1}}}function q(){let e=PlayerPedId(),a={model:{items:oe}},t={items:Me},r=O.map(y=>Q(e,y)),o=D.map(y=>X(e,y)),i={shapeFirst:{min:0,max:45},shapeSecond:{min:0,max:45},shapeThird:{min:0,max:45},skinFirst:{min:0,max:45},skinSecond:{min:0,max:45},skinThird:{min:0,max:45},shapeMix:{min:0,max:1,factor:.1},skinMix:{min:0,max:1,factor:.1},thirdMix:{min:0,max:1,factor:.1}},n=F.reduce((y,_)=>({...y,[_]:{min:-1,max:1,factor:.1}}),{}),l=Ce(),s={beard:l.hair,eyebrows:l.hair,chestHair:l.hair,makeUp:l.makeUp,blush:l.makeUp,lipstick:l.makeUp},c=S.reduce((y,_,v)=>{let P={style:{min:0,max:GetPedHeadOverlayNum(v)-1},opacity:{min:0,max:1,factor:.1}};return s[_]&&Object.assign(P,{color:{items:s[_]}}),{...y,[_]:P}},{}),d={style:{min:0,max:GetNumberOfPedDrawableVariations(e,2)-1},color:{items:l.hair},highlight:{items:l.hair},texture:{min:0,max:GetNumberOfPedTextureVariations(e,2,GetPedDrawableVariation(e,2))-1}};return{ped:a,components:r,props:o,headBlend:i,faceFeatures:n,headOverlays:c,hair:d,eyeColor:{min:0,max:30},tattoos:t}}function _e(){return ae}function ee(e){if(h)return;e!=="current"&&(w=e);let{coords:a,point:t}=he[w],r=H?-1:1;if(m){let o=g(GetOffsetFromEntityInWorldCoords(PlayerPedId(),a.x*r,a.y*r,a.z)),i=g(GetOffsetFromEntityInWorldCoords(PlayerPedId(),t.x,t.y,t.z)),n=CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",o.x,o.y,o.z,0,0,0,50,!1,0);PointCamAtCoord(n,i.x,i.y,i.z),SetCamActiveWithInterp(n,m,1e3,1,1),h=!0;let l=setInterval(()=>{!IsCamInterpolating(m)&&IsCamActive(n)&&(DestroyCam(m,!1),m=n,h=!1,clearInterval(l))},500)}else{let o=g(GetOffsetFromEntityInWorldCoords(PlayerPedId(),a.x,a.y,a.z)),i=g(GetOffsetFromEntityInWorldCoords(PlayerPedId(),t.x,t.y,t.z));m=CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",o.x,o.y,o.z,0,0,0,50,!1,0),PointCamAtCoord(m,i.x,i.y,i.z),SetCamActive(m,!0)}}async function ue(e){if(h)return;let{coords:a,point:t}=he[w],r=De[w],o,i=H?-1:1;e==="left"?o=1:e==="right"&&(o=-1);let n=g(GetOffsetFromEntityInWorldCoords(PlayerPedId(),(a.x+r.x)*o*i,(a.y+r.y)*i,a.z)),l=g(GetOffsetFromEntityInWorldCoords(PlayerPedId(),t.x,t.y,t.z)),s=CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",n.x,n.y,n.z,0,0,0,50,!1,0);PointCamAtCoord(s,l.x,l.y,l.z),SetCamActiveWithInterp(s,m,1e3,1,1),h=!0;let c=setInterval(()=>{!IsCamInterpolating(m)&&IsCamActive(s)&&(DestroyCam(m,!1),m=s,h=!1,clearInterval(c))},500)}function B(e,a){H=!H;let t=OpenSequenceTask()??0;t!==0&&(TaskGoStraightToCoord(0,I.x,I.y,I.z,8,-1,GetEntityHeading(e)-a,.1),TaskStandStill(0,-1),CloseSequenceTask(t),ClearPedTasks(e),TaskPerformSequence(e,t),ClearSequenceTask(t))}async function ye(e,a){let{animations:t,props:r}=J[a],{dict:o,anim:i,move:n,duration:l}=t.on,{male:s,female:c}=r,{components:d}=e,p=PlayerPedId(),y=f(p);for(RequestAnimDict(o);!HasAnimDictLoaded(o);)await b(0);if(y)for(let _=0;_<s.length;_++){let[v]=s[_];for(let P=0;P<d.length;P++){let{component_id:W,drawable:K,texture:j}=d[P];W===v&&SetPedComponentVariation(p,v,K,j,2)}}else for(let _=0;_<c.length;_++){let[v]=c[_];for(let P=0;P<d.length;P++){let{component_id:W,drawable:K,texture:j}=d[P];W===v&&SetPedComponentVariation(p,v,K,j,2)}}TaskPlayAnim(p,o,i,3,3,l,n,0,!1,!1,!1)}async function pe(e){let{animations:a,props:t}=J[e],{dict:r,anim:o,move:i,duration:n}=a.off,{male:l,female:s}=t,c=PlayerPedId(),d=f(c);for(RequestAnimDict(r);!HasAnimDictLoaded(r);)await b(0);if(d)for(let p=0;p<l.length;p++){let[y,_]=l[p];SetPedComponentVariation(c,y,_,0,2)}else for(let p=0;p<s.length;p++){let[y,_]=s[p];SetPedComponentVariation(c,y,_,0,2)}TaskPlayAnim(c,r,o,3,3,n,i,0,!1,!1,!1)}var te=()=>xe,R=(e,a)=>{xe=a;let t=f(e);ClearPedDecorations(e);for(let r in a)for(let o=0;o<a[r].length;o++){let{collection:i,hashFemale:n,hashMale:l}=a[r][o],s=t?l:n;AddPedDecorationFromHashes(e,GetHashKey(i),GetHashKey(s))}},me=(e,a)=>{let t=f(e);ClearPedDecorations(e);for(let r in a)for(let o=0;o<a[r].length;o++){let{collection:i,hashFemale:n,hashMale:l}=a[r][o],s=t?l:n;AddPedDecorationFromHashes(e,GetHashKey(i),GetHashKey(s))}},Pe=(e,a)=>{let t=f(e);ClearPedDecorations(e);for(let r in a)for(let o=0;o<a[r].length;o++){let{collection:i,hashFemale:n,hashMale:l}=a[r][o],s=t?l:n;AddPedDecorationFromHashes(e,GetHashKey(i),GetHashKey(s))}},ve=(e,a,t)=>{let r=f(e),{collection:o,hashFemale:i,hashMale:n}=t,l=r?n:i;ClearPedDecorations(e),AddPedDecorationFromHashes(e,GetHashKey(o),GetHashKey(l));for(let s in a)for(let c=0;c<a[s].length;c++){let{name:d,collection:p,hashFemale:y,hashMale:_}=a[s][c];if(t.name!==d){let v=r?_:y;AddPedDecorationFromHashes(e,GetHashKey(p),GetHashKey(v))}}};function Ve(e,a=se){let t=PlayerPedId();A=C(t),U=e,ae=a,I=g(GetEntityCoords(t,!0)),Z=GetEntityHeading(t),H=!1,h=!1,ee("default"),SetNuiFocus(!0,!0),SetNuiFocusKeepInput(!1),RenderScriptCams(!0,!1,0,!0,!0),DisplayRadar(!1),SetEntityInvincible(t,!0),TaskStandStill(t,-1);let r={type:"appearance_display",payload:{}};SendNuiMessage(JSON.stringify(r))}function Y(e){RenderScriptCams(!1,!1,0,!0,!0),DestroyCam(m,!1),DisplayRadar(!0),SetNuiFocus(!1,!1);let a=PlayerPedId();ClearPedTasksImmediately(a),SetEntityInvincible(a,!1);let t={type:"appearance_hide",payload:{}};if(SendNuiMessage(JSON.stringify(t)),!e)re($());else{let{tattoos:r}=e;R(a,r)}U&&U(e),U=null,ae=null,A=null,I=null,m=null,w=null,H=null,h=null}function Ue(e){e===GetCurrentResourceName()&&(SetNuiFocus(!1,!1),SetNuiFocusKeepInput(!1))}function We(){ce(),on("onResourceStop",Ue),Oe("startPlayerCustomization",Ve)}var be={loadModule:We};var u=global.exports,Ke="0x2746bd9d88c5c5d0",ke="",Ge="";on("updateJob",e=>{ke=e});on("updateGang",e=>{Ge=e});function Fe(){return ke}function Se(){return Ge}var Me=JSON.parse(LoadResourceFile(GetCurrentResourceName(),"tattoos.json")),oe=JSON.parse(LoadResourceFile(GetCurrentResourceName(),"peds.json")),E=JSON.parse(LoadResourceFile(GetCurrentResourceName(),"blacklist.json")),fe=JSON.parse(LoadResourceFile(GetCurrentResourceName(),"theme.json")),ge=JSON.parse(LoadResourceFile(GetCurrentResourceName(),`locales/${GetConvar("fivem-appearance:locale","en")}.json`)),je=oe.reduce((e,a)=>({...e,[GetHashKey(a)]:a}),{});function Ne(e){return je[GetEntityModel(e)]}function Te(e){let a=[];return O.forEach(t=>{a.push({component_id:t,drawable:GetPedDrawableVariation(e,t),texture:GetPedTextureVariation(e,t)})}),a}function Ae(e){let a=[];return D.forEach(t=>{a.push({prop_id:t,drawable:GetPedPropIndex(e,t),texture:GetPedPropTextureIndex(e,t)})}),a}function Ie(e){let a=new ArrayBuffer(80);global.Citizen.invokeNative(Ke,e,new Uint32Array(a));let{0:t,2:r,4:o,6:i,8:n,10:l}=new Uint32Array(a),{0:s,2:c,4:d}=new Float32Array(a,48),p=parseFloat(s.toFixed(1)),y=parseFloat(c.toFixed(1)),_=parseFloat(d.toFixed(1));return Number.isNaN(_)&&(_=0),{shapeFirst:t,shapeSecond:r,shapeThird:o,skinFirst:i,skinSecond:n,skinThird:l,shapeMix:p,skinMix:y,thirdMix:_}}function we(e){return F.reduce((t,r,o)=>{let i=parseFloat(GetPedFaceFeature(e,o).toFixed(1));return{...t,[r]:i}},{})}function Ee(e){return S.reduce((t,r,o)=>{let[,i,,n,l,s]=GetPedHeadOverlayData(e,o),c=i!==255,d=c?i:0,p=c?parseFloat(s.toFixed(1)):0,y;return r==="makeUp"?y={style:d,opacity:p,color:n,secondColor:l}:y={style:d,opacity:p,color:n},{...t,[r]:y}},{})}function Re(e){return{style:GetPedDrawableVariation(e,2),color:GetPedHairColor(e),highlight:GetPedHairHighlightColor(e),texture:GetPedTextureVariation(e,2)}}function C(e){let a=GetPedEyeColor(e);return{model:Ne(e)||"mp_m_freemode_01",headBlend:Ie(e),faceFeatures:we(e),headOverlays:Ee(e),components:Te(e),props:Ae(e),hair:Re(e),eyeColor:a<le.length?a:0,tattoos:te()}}async function L(e){if(!e||!IsModelInCdimage(e))return;for(RequestModel(e);!HasModelLoaded(e);)await b(0);SetPlayerModel(PlayerId(),e),SetModelAsNoLongerNeeded(e);let a=PlayerPedId();x(a)&&(SetPedDefaultComponentVariation(a),SetPedHeadBlendData(a,0,0,0,0,0,0,0,0,0,!1))}function M(e,a){if(!a)return;let{shapeFirst:t,shapeSecond:r,shapeThird:o,shapeMix:i,skinFirst:n,skinSecond:l,skinThird:s,skinMix:c,thirdMix:d}=a;x(e)&&SetPedHeadBlendData(e,t,r,o,n,l,s,i,c,d,!1)}function k(e,a){!a||F.forEach((t,r)=>{let o=a[t];SetPedFaceFeature(e,r,o)})}function G(e,a){!a||S.forEach((t,r)=>{let o=a[t];if(SetPedHeadOverlay(e,r,o.style,o.opacity),o.color||o.color===0){let n=1;var i=o.color;({blush:!0,lipstick:!0,makeUp:!0})[t]&&(n=2),t==="makeUp"&&(i=o.secondColor),SetPedHeadOverlayColor(e,r,n,o.color,i)}})}function N(e,a){if(!a)return;let{style:t,color:r,highlight:o,texture:i}=a;SetPedComponentVariation(e,2,t,i,2),SetPedHairColor(e,r,o)}function T(e,a){!a||SetPedEyeColor(e,a)}function z(e,a){if(!a)return;let{component_id:t,drawable:r,texture:o}=a;({0:!0,2:!0})[t]&&x(e)||SetPedComponentVariation(e,t,r,o,0)}function ie(e,a){!a||a.forEach(t=>z(e,t))}function V(e,a){if(!a)return;let{prop_id:t,drawable:r,texture:o}=a;r===-1?ClearPedProp(e,t):SetPedPropIndex(e,t,r,o,!1)}function ne(e,a){!a||a.forEach(t=>V(e,t))}async function re(e){if(!e)return;let{model:a,components:t,props:r,headBlend:o,faceFeatures:i,headOverlays:n,hair:l,eyeColor:s,tattoos:c}=e;await L(a);let d=PlayerPedId();ie(d,t),ne(d,r),o&&M(d,o),i&&k(d,i),n&&G(d,n),l&&N(d,l),s&&T(d,s),c&&R(d,c)}function Je(e,a){if(!a)return;let{components:t,props:r,headBlend:o,faceFeatures:i,headOverlays:n,hair:l,eyeColor:s,tattoos:c}=a;ie(e,t),ne(e,r),o&&M(e,o),i&&k(e,i),n&&G(e,n),l&&N(e,l),s&&T(e,s),c&&R(e,c)}function qe(){be.loadModule(),u("getPedModel",Ne),u("getPedComponents",Te),u("getPedProps",Ae),u("getPedHeadBlend",Ie),u("getPedFaceFeatures",we),u("getPedHeadOverlays",Ee),u("getPedHair",Re),u("getPedTattoos",te),u("getPedAppearance",C),u("setPlayerModel",L),u("setPedHeadBlend",M),u("setPedFaceFeatures",k),u("setPedHeadOverlays",G),u("setPedHair",N),u("setPedEyeColor",T),u("setPedComponent",z),u("setPedComponents",ie),u("setPedProp",V),u("setPedProps",ne),u("setPedTattoos",R),u("setPlayerAppearance",re),u("setPedAppearance",Je)}qe();})();