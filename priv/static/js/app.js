/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ({

/***/ "./css/app.css":
/*!*********************!*\
  !*** ./css/app.css ***!
  \*********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("// extracted by mini-css-extract-plugin\n\n//# sourceURL=webpack:///./css/app.css?");

/***/ }),

/***/ "./js/app.js":
/*!*******************!*\
  !*** ./js/app.js ***!
  \*******************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _css_app_css__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../css/app.css */ \"./css/app.css\");\n/* harmony import */ var _css_app_css__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_css_app_css__WEBPACK_IMPORTED_MODULE_0__);\n/* harmony import */ var phoenix_html__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! phoenix_html */ \"./node_modules/phoenix_html/priv/static/phoenix_html.js\");\n/* harmony import */ var phoenix_html__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(phoenix_html__WEBPACK_IMPORTED_MODULE_1__);\n/* harmony import */ var _socket__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./socket */ \"./js/socket.js\");\n// We need to import the CSS so that webpack will load it.\n// The MiniCssExtractPlugin is used to separate it out into\n// its own CSS file.\n // webpack automatically bundles all modules in your\n// entry points. Those entry points can be configured\n// in \"webpack.config.js\".\n//\n// Import dependencies\n//\n\n // Import local files\n//\n// Local files can be imported directly using relative paths, for example:\n\n\n\n//# sourceURL=webpack:///./js/app.js?");

/***/ }),

/***/ "./js/socket.js":
/*!**********************!*\
  !*** ./js/socket.js ***!
  \**********************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var phoenix__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! phoenix */ \"./node_modules/phoenix/priv/static/phoenix.js\");\n/* harmony import */ var phoenix__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(phoenix__WEBPACK_IMPORTED_MODULE_0__);\n// NOTE: The contents of this file will only be executed if\n// you uncomment its entry in \"assets/js/app.js\".\n// To use Phoenix channels, the first step is to import Socket,\n// and connect at the socket path in \"lib/web/endpoint.ex\".\n//\n// Pass the token on params as below. Or remove it\n// from the params if you are not using authentication.\n // When you connect, you'll often need to authenticate the client.\n// For example, imagine you have an authentication plug, `MyAuth`,\n// which authenticates the session and assigns a `:current_user`.\n// If the current user exists you can assign the user's token in\n// the connection for use in the layout.\n//\n// In your \"lib/web/router.ex\":\n//\n//     pipeline :browser do\n//       ...\n//       plug MyAuth\n//       plug :put_user_token\n//     end\n//\n//     defp put_user_token(conn, _) do\n//       if current_user = conn.assigns[:current_user] do\n//         token = Phoenix.Token.sign(conn, \"user socket\", current_user.id)\n//         assign(conn, :user_token, token)\n//       else\n//         conn\n//       end\n//     end\n//\n// Now you need to pass this token to JavaScript. You can do so\n// inside a script tag in \"lib/web/templates/layout/app.html.eex\":\n//\n//     <script>window.userToken = \"<%= assigns[:user_token] %>\";</script>\n//\n// You will need to verify the user token in the \"connect/3\" function\n// in \"lib/web/channels/user_socket.ex\":\n//\n//     def connect(%{\"token\" => token}, socket, _connect_info) do\n//       # max_age: 1209600 is equivalent to two weeks in seconds\n//       case Phoenix.Token.verify(socket, \"user socket\", token, max_age: 1209600) do\n//         {:ok, user_id} ->\n//           {:ok, assign(socket, :user, user_id)}\n//         {:error, reason} ->\n//           :error\n//       end\n//     end\n//\n// Finally, connect to the socket:\n\nif (window.userToken) {\n  var socket = new phoenix__WEBPACK_IMPORTED_MODULE_0__[\"Socket\"](\"/socket\", {\n    params: {\n      token: window.userToken\n    }\n  });\n  socket.connect();\n\n  var createSocket = function createSocket(topicId) {\n    var channelName = \"event_timeline:\" + topicId; // Now that you are connected, you can join channels with a topic:\n\n    var channel = socket.channel(channelName, {});\n    channel.join().receive(\"ok\", function (resp) {\n      console.log(\"Joined successfully\", resp);\n    }).receive(\"error\", function (resp) {\n      console.log(\"Unable to join\", resp);\n    });\n    channel.on(\"change\", function (resp) {\n      console.log(\"Change:\", resp);\n    });\n  };\n\n  window.createSocket = createSocket;\n}\n\n//# sourceURL=webpack:///./js/socket.js?");

/***/ }),

/***/ "./node_modules/phoenix/priv/static/phoenix.js":
/*!*****************************************************!*\
  !*** ./node_modules/phoenix/priv/static/phoenix.js ***!
  \*****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("!function(e,t){ true?module.exports=t():undefined}(window,function(){return function(e){var t={};function s(n){if(t[n])return t[n].exports;var i=t[n]={i:n,l:!1,exports:{}};return e[n].call(i.exports,i,i.exports,s),i.l=!0,i.exports}return s.m=e,s.c=t,s.d=function(e,t,n){s.o(e,t)||Object.defineProperty(e,t,{configurable:!1,enumerable:!0,get:n})},s.r=function(e){Object.defineProperty(e,\"__esModule\",{value:!0})},s.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return s.d(t,\"a\",t),t},s.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},s.p=\"\",s(s.s=2)}([function(e,t,s){\"use strict\";s.r(t),s.d(t,\"Channel\",function(){return d}),s.d(t,\"Socket\",function(){return m}),s.d(t,\"LongPoll\",function(){return v}),s.d(t,\"Ajax\",function(){return b}),s.d(t,\"Presence\",function(){return j});const n=\"undefined\"!=typeof self?self:window,i=\"2.0.0\",o={connecting:0,open:1,closing:2,closed:3},r=1e4,h=1e3,a={closed:\"closed\",errored:\"errored\",joined:\"joined\",joining:\"joining\",leaving:\"leaving\"},c={close:\"phx_close\",error:\"phx_error\",join:\"phx_join\",reply:\"phx_reply\",leave:\"phx_leave\"},l=[c.close,c.error,c.join,c.reply,c.leave],u={longpoll:\"longpoll\",websocket:\"websocket\"};let f=e=>{if(\"function\"==typeof e)return e;return function(){return e}};class p{constructor(e,t,s,n){this.channel=e,this.event=t,this.payload=s||function(){return{}},this.receivedResp=null,this.timeout=n,this.timeoutTimer=null,this.recHooks=[],this.sent=!1}resend(e){this.timeout=e,this.reset(),this.send()}send(){this.hasReceived(\"timeout\")||(this.startTimeout(),this.sent=!0,this.channel.socket.push({topic:this.channel.topic,event:this.event,payload:this.payload(),ref:this.ref,join_ref:this.channel.joinRef()}))}receive(e,t){return this.hasReceived(e)&&t(this.receivedResp.response),this.recHooks.push({status:e,callback:t}),this}reset(){this.cancelRefEvent(),this.ref=null,this.refEvent=null,this.receivedResp=null,this.sent=!1}matchReceive({status:e,response:t,ref:s}){this.recHooks.filter(t=>t.status===e).forEach(e=>e.callback(t))}cancelRefEvent(){this.refEvent&&this.channel.off(this.refEvent)}cancelTimeout(){clearTimeout(this.timeoutTimer),this.timeoutTimer=null}startTimeout(){this.timeoutTimer&&this.cancelTimeout(),this.ref=this.channel.socket.makeRef(),this.refEvent=this.channel.replyEventName(this.ref),this.channel.on(this.refEvent,e=>{this.cancelRefEvent(),this.cancelTimeout(),this.receivedResp=e,this.matchReceive(e)}),this.timeoutTimer=setTimeout(()=>{this.trigger(\"timeout\",{})},this.timeout)}hasReceived(e){return this.receivedResp&&this.receivedResp.status===e}trigger(e,t){this.channel.trigger(this.refEvent,{status:e,response:t})}}class d{constructor(e,t,s){this.state=a.closed,this.topic=e,this.params=f(t||{}),this.socket=s,this.bindings=[],this.bindingRef=0,this.timeout=this.socket.timeout,this.joinedOnce=!1,this.joinPush=new p(this,c.join,this.params,this.timeout),this.pushBuffer=[],this.rejoinTimer=new y(()=>this.rejoinUntilConnected(),this.socket.reconnectAfterMs),this.joinPush.receive(\"ok\",()=>{this.state=a.joined,this.rejoinTimer.reset(),this.pushBuffer.forEach(e=>e.send()),this.pushBuffer=[]}),this.onClose(()=>{this.rejoinTimer.reset(),this.socket.hasLogger()&&this.socket.log(\"channel\",`close ${this.topic} ${this.joinRef()}`),this.state=a.closed,this.socket.remove(this)}),this.onError(e=>{this.isLeaving()||this.isClosed()||(this.socket.hasLogger()&&this.socket.log(\"channel\",`error ${this.topic}`,e),this.state=a.errored,this.rejoinTimer.scheduleTimeout())}),this.joinPush.receive(\"timeout\",()=>{if(!this.isJoining())return;this.socket.hasLogger()&&this.socket.log(\"channel\",`timeout ${this.topic} (${this.joinRef()})`,this.joinPush.timeout),new p(this,c.leave,f({}),this.timeout).send(),this.state=a.errored,this.joinPush.reset(),this.rejoinTimer.scheduleTimeout()}),this.on(c.reply,(e,t)=>{this.trigger(this.replyEventName(t),e)})}rejoinUntilConnected(){this.rejoinTimer.scheduleTimeout(),this.socket.isConnected()&&this.rejoin()}join(e=this.timeout){if(this.joinedOnce)throw\"tried to join multiple times. 'join' can only be called a single time per channel instance\";return this.joinedOnce=!0,this.rejoin(e),this.joinPush}onClose(e){this.on(c.close,e)}onError(e){return this.on(c.error,t=>e(t))}on(e,t){let s=this.bindingRef++;return this.bindings.push({event:e,ref:s,callback:t}),s}off(e,t){this.bindings=this.bindings.filter(s=>!(s.event===e&&(void 0===t||t===s.ref)))}canPush(){return this.socket.isConnected()&&this.isJoined()}push(e,t,s=this.timeout){if(!this.joinedOnce)throw`tried to push '${e}' to '${this.topic}' before joining. Use channel.join() before pushing events`;let n=new p(this,e,function(){return t},s);return this.canPush()?n.send():(n.startTimeout(),this.pushBuffer.push(n)),n}leave(e=this.timeout){this.state=a.leaving;let t=()=>{this.socket.hasLogger()&&this.socket.log(\"channel\",`leave ${this.topic}`),this.trigger(c.close,\"leave\")},s=new p(this,c.leave,f({}),e);return s.receive(\"ok\",()=>t()).receive(\"timeout\",()=>t()),s.send(),this.canPush()||s.trigger(\"ok\",{}),s}onMessage(e,t,s){return t}isLifecycleEvent(e){return l.indexOf(e)>=0}isMember(e,t,s,n){return this.topic===e&&(!n||n===this.joinRef()||!this.isLifecycleEvent(t)||(this.socket.hasLogger()&&this.socket.log(\"channel\",\"dropping outdated message\",{topic:e,event:t,payload:s,joinRef:n}),!1))}joinRef(){return this.joinPush.ref}sendJoin(e){this.state=a.joining,this.joinPush.resend(e)}rejoin(e=this.timeout){this.isLeaving()||this.sendJoin(e)}trigger(e,t,s,n){let i=this.onMessage(e,t,s,n);if(t&&!i)throw\"channel onMessage callbacks must return the payload, modified or unmodified\";for(let t=0;t<this.bindings.length;t++){const o=this.bindings[t];o.event===e&&o.callback(i,s,n||this.joinRef())}}replyEventName(e){return`chan_reply_${e}`}isClosed(){return this.state===a.closed}isErrored(){return this.state===a.errored}isJoined(){return this.state===a.joined}isJoining(){return this.state===a.joining}isLeaving(){return this.state===a.leaving}}const g={encode(e,t){let s=[e.join_ref,e.ref,e.topic,e.event,e.payload];return t(JSON.stringify(s))},decode(e,t){let[s,n,i,o,r]=JSON.parse(e);return t({join_ref:s,ref:n,topic:i,event:o,payload:r})}};class m{constructor(e,t={}){this.stateChangeCallbacks={open:[],close:[],error:[],message:[]},this.channels=[],this.sendBuffer=[],this.ref=0,this.timeout=t.timeout||r,this.transport=t.transport||n.WebSocket||v,this.defaultEncoder=g.encode,this.defaultDecoder=g.decode,this.transport!==v?(this.encode=t.encode||this.defaultEncoder,this.decode=t.decode||this.defaultDecoder):(this.encode=this.defaultEncoder,this.decode=this.defaultDecoder),this.heartbeatIntervalMs=t.heartbeatIntervalMs||3e4,this.reconnectAfterMs=t.reconnectAfterMs||function(e){return[1e3,2e3,5e3,1e4][e-1]||1e4},this.logger=t.logger||null,this.longpollerTimeout=t.longpollerTimeout||2e4,this.params=f(t.params||{}),this.endPoint=`${e}/${u.websocket}`,this.heartbeatTimer=null,this.pendingHeartbeatRef=null,this.reconnectTimer=new y(()=>{this.teardown(()=>this.connect())},this.reconnectAfterMs)}protocol(){return location.protocol.match(/^https/)?\"wss\":\"ws\"}endPointURL(){let e=b.appendParams(b.appendParams(this.endPoint,this.params()),{vsn:i});return\"/\"!==e.charAt(0)?e:\"/\"===e.charAt(1)?`${this.protocol()}:${e}`:`${this.protocol()}://${location.host}${e}`}disconnect(e,t,s){this.reconnectTimer.reset(),this.teardown(e,t,s)}connect(e){e&&(console&&console.log(\"passing params to connect is deprecated. Instead pass :params to the Socket constructor\"),this.params=f(e)),this.conn||(this.conn=new this.transport(this.endPointURL()),this.conn.timeout=this.longpollerTimeout,this.conn.onopen=(()=>this.onConnOpen()),this.conn.onerror=(e=>this.onConnError(e)),this.conn.onmessage=(e=>this.onConnMessage(e)),this.conn.onclose=(e=>this.onConnClose(e)))}log(e,t,s){this.logger(e,t,s)}hasLogger(){return null!==this.logger}onOpen(e){this.stateChangeCallbacks.open.push(e)}onClose(e){this.stateChangeCallbacks.close.push(e)}onError(e){this.stateChangeCallbacks.error.push(e)}onMessage(e){this.stateChangeCallbacks.message.push(e)}onConnOpen(){this.hasLogger()&&this.log(\"transport\",`connected to ${this.endPointURL()}`),this.flushSendBuffer(),this.reconnectTimer.reset(),this.resetHeartbeat(),this.stateChangeCallbacks.open.forEach(e=>e())}resetHeartbeat(){this.conn.skipHeartbeat||(this.pendingHeartbeatRef=null,clearInterval(this.heartbeatTimer),this.heartbeatTimer=setInterval(()=>this.sendHeartbeat(),this.heartbeatIntervalMs))}teardown(e,t,s){this.conn&&(this.conn.onclose=function(){},t?this.conn.close(t,s||\"\"):this.conn.close(),this.conn=null),e&&e()}onConnClose(e){this.hasLogger()&&this.log(\"transport\",\"close\",e),this.triggerChanError(),clearInterval(this.heartbeatTimer),e&&e.code!==h&&this.reconnectTimer.scheduleTimeout(),this.stateChangeCallbacks.close.forEach(t=>t(e))}onConnError(e){this.hasLogger()&&this.log(\"transport\",e),this.triggerChanError(),this.stateChangeCallbacks.error.forEach(t=>t(e))}triggerChanError(){this.channels.forEach(e=>e.trigger(c.error))}connectionState(){switch(this.conn&&this.conn.readyState){case o.connecting:return\"connecting\";case o.open:return\"open\";case o.closing:return\"closing\";default:return\"closed\"}}isConnected(){return\"open\"===this.connectionState()}remove(e){this.channels=this.channels.filter(t=>t.joinRef()!==e.joinRef())}channel(e,t={}){let s=new d(e,t,this);return this.channels.push(s),s}push(e){if(this.hasLogger()){let{topic:t,event:s,payload:n,ref:i,join_ref:o}=e;this.log(\"push\",`${t} ${s} (${o}, ${i})`,n)}this.isConnected()?this.encode(e,e=>this.conn.send(e)):this.sendBuffer.push(()=>this.encode(e,e=>this.conn.send(e)))}makeRef(){let e=this.ref+1;return e===this.ref?this.ref=0:this.ref=e,this.ref.toString()}sendHeartbeat(){if(this.isConnected()){if(this.pendingHeartbeatRef)return this.pendingHeartbeatRef=null,this.hasLogger()&&this.log(\"transport\",\"heartbeat timeout. Attempting to re-establish connection\"),void this.conn.close(h,\"hearbeat timeout\");this.pendingHeartbeatRef=this.makeRef(),this.push({topic:\"phoenix\",event:\"heartbeat\",payload:{},ref:this.pendingHeartbeatRef})}}flushSendBuffer(){this.isConnected()&&this.sendBuffer.length>0&&(this.sendBuffer.forEach(e=>e()),this.sendBuffer=[])}onConnMessage(e){this.decode(e.data,e=>{let{topic:t,event:s,payload:n,ref:i,join_ref:o}=e;i&&i===this.pendingHeartbeatRef&&(this.pendingHeartbeatRef=null),this.hasLogger()&&this.log(\"receive\",`${n.status||\"\"} ${t} ${s} ${i&&\"(\"+i+\")\"||\"\"}`,n);for(let e=0;e<this.channels.length;e++){const r=this.channels[e];r.isMember(t,s,n,o)&&r.trigger(s,n,i,o)}for(let t=0;t<this.stateChangeCallbacks.message.length;t++)this.stateChangeCallbacks.message[t](e)})}}class v{constructor(e){this.endPoint=null,this.token=null,this.skipHeartbeat=!0,this.onopen=function(){},this.onerror=function(){},this.onmessage=function(){},this.onclose=function(){},this.pollEndpoint=this.normalizeEndpoint(e),this.readyState=o.connecting,this.poll()}normalizeEndpoint(e){return e.replace(\"ws://\",\"http://\").replace(\"wss://\",\"https://\").replace(new RegExp(\"(.*)/\"+u.websocket),\"$1/\"+u.longpoll)}endpointURL(){return b.appendParams(this.pollEndpoint,{token:this.token})}closeAndRetry(){this.close(),this.readyState=o.connecting}ontimeout(){this.onerror(\"timeout\"),this.closeAndRetry()}poll(){this.readyState!==o.open&&this.readyState!==o.connecting||b.request(\"GET\",this.endpointURL(),\"application/json\",null,this.timeout,this.ontimeout.bind(this),e=>{if(e){var{status:t,token:s,messages:n}=e;this.token=s}else var t=0;switch(t){case 200:n.forEach(e=>this.onmessage({data:e})),this.poll();break;case 204:this.poll();break;case 410:this.readyState=o.open,this.onopen(),this.poll();break;case 0:case 500:this.onerror(),this.closeAndRetry();break;default:throw`unhandled poll status ${t}`}})}send(e){b.request(\"POST\",this.endpointURL(),\"application/json\",e,this.timeout,this.onerror.bind(this,\"timeout\"),e=>{e&&200===e.status||(this.onerror(e&&e.status),this.closeAndRetry())})}close(e,t){this.readyState=o.closed,this.onclose()}}class b{static request(e,t,s,i,o,r,h){if(n.XDomainRequest){let s=new XDomainRequest;this.xdomainRequest(s,e,t,i,o,r,h)}else{let a=n.XMLHttpRequest?new n.XMLHttpRequest:new ActiveXObject(\"Microsoft.XMLHTTP\");this.xhrRequest(a,e,t,s,i,o,r,h)}}static xdomainRequest(e,t,s,n,i,o,r){e.timeout=i,e.open(t,s),e.onload=(()=>{let t=this.parseJSON(e.responseText);r&&r(t)}),o&&(e.ontimeout=o),e.onprogress=(()=>{}),e.send(n)}static xhrRequest(e,t,s,n,i,o,r,h){e.open(t,s,!0),e.timeout=o,e.setRequestHeader(\"Content-Type\",n),e.onerror=(()=>{h&&h(null)}),e.onreadystatechange=(()=>{if(e.readyState===this.states.complete&&h){let t=this.parseJSON(e.responseText);h(t)}}),r&&(e.ontimeout=r),e.send(i)}static parseJSON(e){if(!e||\"\"===e)return null;try{return JSON.parse(e)}catch(t){return console&&console.log(\"failed to parse JSON response\",e),null}}static serialize(e,t){let s=[];for(var n in e){if(!e.hasOwnProperty(n))continue;let i=t?`${t}[${n}]`:n,o=e[n];\"object\"==typeof o?s.push(this.serialize(o,i)):s.push(encodeURIComponent(i)+\"=\"+encodeURIComponent(o))}return s.join(\"&\")}static appendParams(e,t){if(0===Object.keys(t).length)return e;return`${e}${e.match(/\\?/)?\"&\":\"?\"}${this.serialize(t)}`}}b.states={complete:4};class j{constructor(e,t={}){let s=t.events||{state:\"presence_state\",diff:\"presence_diff\"};this.state={},this.pendingDiffs=[],this.channel=e,this.joinRef=null,this.caller={onJoin:function(){},onLeave:function(){},onSync:function(){}},this.channel.on(s.state,e=>{let{onJoin:t,onLeave:s,onSync:n}=this.caller;this.joinRef=this.channel.joinRef(),this.state=j.syncState(this.state,e,t,s),this.pendingDiffs.forEach(e=>{this.state=j.syncDiff(this.state,e,t,s)}),this.pendingDiffs=[],n()}),this.channel.on(s.diff,e=>{let{onJoin:t,onLeave:s,onSync:n}=this.caller;this.inPendingSyncState()?this.pendingDiffs.push(e):(this.state=j.syncDiff(this.state,e,t,s),n())})}onJoin(e){this.caller.onJoin=e}onLeave(e){this.caller.onLeave=e}onSync(e){this.caller.onSync=e}list(e){return j.list(this.state,e)}inPendingSyncState(){return!this.joinRef||this.joinRef!==this.channel.joinRef()}static syncState(e,t,s,n){let i=this.clone(e),o={},r={};return this.map(i,(e,s)=>{t[e]||(r[e]=s)}),this.map(t,(e,t)=>{let s=i[e];if(s){let n=t.metas.map(e=>e.phx_ref),i=s.metas.map(e=>e.phx_ref),h=t.metas.filter(e=>i.indexOf(e.phx_ref)<0),a=s.metas.filter(e=>n.indexOf(e.phx_ref)<0);h.length>0&&(o[e]=t,o[e].metas=h),a.length>0&&(r[e]=this.clone(s),r[e].metas=a)}else o[e]=t}),this.syncDiff(i,{joins:o,leaves:r},s,n)}static syncDiff(e,{joins:t,leaves:s},n,i){let o=this.clone(e);return n||(n=function(){}),i||(i=function(){}),this.map(t,(e,t)=>{let s=o[e];if(o[e]=t,s){let t=o[e].metas.map(e=>e.phx_ref),n=s.metas.filter(e=>t.indexOf(e.phx_ref)<0);o[e].metas.unshift(...n)}n(e,s,t)}),this.map(s,(e,t)=>{let s=o[e];if(!s)return;let n=t.metas.map(e=>e.phx_ref);s.metas=s.metas.filter(e=>n.indexOf(e.phx_ref)<0),i(e,s,t),0===s.metas.length&&delete o[e]}),o}static list(e,t){return t||(t=function(e,t){return t}),this.map(e,(e,s)=>t(e,s))}static map(e,t){return Object.getOwnPropertyNames(e).map(s=>t(s,e[s]))}static clone(e){return JSON.parse(JSON.stringify(e))}}class y{constructor(e,t){this.callback=e,this.timerCalc=t,this.timer=null,this.tries=0}reset(){this.tries=0,clearTimeout(this.timer)}scheduleTimeout(){clearTimeout(this.timer),this.timer=setTimeout(()=>{this.tries=this.tries+1,this.callback()},this.timerCalc(this.tries+1))}}},function(e,t){var s;s=function(){return this}();try{s=s||Function(\"return this\")()||(0,eval)(\"this\")}catch(e){\"object\"==typeof window&&(s=window)}e.exports=s},function(e,t,s){(function(t){e.exports=t.Phoenix=s(0)}).call(this,s(1))}])});\n\n//# sourceURL=webpack:///./node_modules/phoenix/priv/static/phoenix.js?");

/***/ }),

/***/ "./node_modules/phoenix_html/priv/static/phoenix_html.js":
/*!***************************************************************!*\
  !*** ./node_modules/phoenix_html/priv/static/phoenix_html.js ***!
  \***************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\n(function() {\n  var PolyfillEvent = eventConstructor();\n\n  function eventConstructor() {\n    if (typeof window.CustomEvent === \"function\") return window.CustomEvent;\n    // IE<=9 Support\n    function CustomEvent(event, params) {\n      params = params || {bubbles: false, cancelable: false, detail: undefined};\n      var evt = document.createEvent('CustomEvent');\n      evt.initCustomEvent(event, params.bubbles, params.cancelable, params.detail);\n      return evt;\n    }\n    CustomEvent.prototype = window.Event.prototype;\n    return CustomEvent;\n  }\n\n  function buildHiddenInput(name, value) {\n    var input = document.createElement(\"input\");\n    input.type = \"hidden\";\n    input.name = name;\n    input.value = value;\n    return input;\n  }\n\n  function handleClick(element) {\n    var to = element.getAttribute(\"data-to\"),\n        method = buildHiddenInput(\"_method\", element.getAttribute(\"data-method\")),\n        csrf = buildHiddenInput(\"_csrf_token\", element.getAttribute(\"data-csrf\")),\n        form = document.createElement(\"form\"),\n        target = element.getAttribute(\"target\");\n\n    form.method = (element.getAttribute(\"data-method\") === \"get\") ? \"get\" : \"post\";\n    form.action = to;\n    form.style.display = \"hidden\";\n\n    if (target) form.target = target;\n\n    form.appendChild(csrf);\n    form.appendChild(method);\n    document.body.appendChild(form);\n    form.submit();\n  }\n\n  window.addEventListener(\"click\", function(e) {\n    var element = e.target;\n\n    while (element && element.getAttribute) {\n      var phoenixLinkEvent = new PolyfillEvent('phoenix.link.click', {\n        \"bubbles\": true, \"cancelable\": true\n      });\n\n      if (!element.dispatchEvent(phoenixLinkEvent)) {\n        e.preventDefault();\n        return false;\n      }\n\n      if (element.getAttribute(\"data-method\")) {\n        handleClick(element);\n        e.preventDefault();\n        return false;\n      } else {\n        element = element.parentNode;\n      }\n    }\n  }, false);\n\n  window.addEventListener('phoenix.link.click', function (e) {\n    var message = e.target.getAttribute(\"data-confirm\");\n    if(message && !window.confirm(message)) {\n      e.preventDefault();\n    }\n  }, false);\n})();\n\n\n//# sourceURL=webpack:///./node_modules/phoenix_html/priv/static/phoenix_html.js?");

/***/ }),

/***/ 0:
/*!*************************!*\
  !*** multi ./js/app.js ***!
  \*************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("module.exports = __webpack_require__(/*! ./js/app.js */\"./js/app.js\");\n\n\n//# sourceURL=webpack:///multi_./js/app.js?");

/***/ })

/******/ });