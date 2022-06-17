(function (e) {
  function o(o) {
    for (
      var i, a, d = o[0], r = o[1], l = o[2], s = 0, f = [];
      s < d.length;
      s++
    )
      (a = d[s]),
        Object.prototype.hasOwnProperty.call(t, a) && t[a] && f.push(t[a][0]),
        (t[a] = 0);
    for (i in r) Object.prototype.hasOwnProperty.call(r, i) && (e[i] = r[i]);
    u && u(o);
    while (f.length) f.shift()();
    return c.push.apply(c, l || []), n();
  }
  function n() {
    for (var e, o = 0; o < c.length; o++) {
      for (var n = c[o], i = !0, d = 1; d < n.length; d++) {
        var r = n[d];
        0 !== t[r] && (i = !1);
      }
      i && (c.splice(o--, 1), (e = a((a.s = n[0]))));
    }
    return e;
  }
  var i = {},
    t = { app: 0 },
    c = [];
  function a(o) {
    if (i[o]) return i[o].exports;
    var n = (i[o] = { i: o, l: !1, exports: {} });
    return e[o].call(n.exports, n, n.exports, a), (n.l = !0), n.exports;
  }
  (a.m = e),
    (a.c = i),
    (a.d = function (e, o, n) {
      a.o(e, o) || Object.defineProperty(e, o, { enumerable: !0, get: n });
    }),
    (a.r = function (e) {
      "undefined" !== typeof Symbol &&
        Symbol.toStringTag &&
        Object.defineProperty(e, Symbol.toStringTag, { value: "Module" }),
        Object.defineProperty(e, "__esModule", { value: !0 });
    }),
    (a.t = function (e, o) {
      if ((1 & o && (e = a(e)), 8 & o)) return e;
      if (4 & o && "object" === typeof e && e && e.__esModule) return e;
      var n = Object.create(null);
      if (
        (a.r(n),
        Object.defineProperty(n, "default", { enumerable: !0, value: e }),
        2 & o && "string" != typeof e)
      )
        for (var i in e)
          a.d(
            n,
            i,
            function (o) {
              return e[o];
            }.bind(null, i)
          );
      return n;
    }),
    (a.n = function (e) {
      var o =
        e && e.__esModule
          ? function () {
              return e["default"];
            }
          : function () {
              return e;
            };
      return a.d(o, "a", o), o;
    }),
    (a.o = function (e, o) {
      return Object.prototype.hasOwnProperty.call(e, o);
    }),
    (a.p = "");
  var d = (window["webpackJsonp"] = window["webpackJsonp"] || []),
    r = d.push.bind(d);
  (d.push = o), (d = d.slice());
  for (var l = 0; l < d.length; l++) o(d[l]);
  var u = r;
  c.push([0, "chunk-vendors"]), n();
})({
  0: function (e, o, n) {
    e.exports = n("56d7");
  },
  "0dd2": function (e, o, n) {},
  "33df": function (e, o, n) {
    "use strict";
    n("0dd2");
  },
  "56d7": function (e, o, n) {
    "use strict";
    n.r(o);
    var i = n("7a23");
    const t = Object(i["d"])(
        "audio",
        { id: "audio_on_old", src: "mic_click_on_old.ogg" },
        null,
        -1
      ),
      c = Object(i["d"])(
        "audio",
        { id: "audio_off_old", src: "mic_click_off_old.ogg" },
        null,
        -1
      ),
      a = Object(i["d"])(
        "audio",
        { id: "audio_on", src: "mic_click_on.ogg" },
        null,
        -1
      ),
      d = Object(i["d"])(
        "audio",
        { id: "audio_off", src: "mic_click_off.ogg" },
        null,
        -1
      ),
      r = { class: "voiceInfo" };
    function l(e, o, n, l, u, s) {
      return (
        Object(i["e"])(),
        Object(i["b"])("body", null, [
          t,
          c,
          a,
          d,
          Object(i["d"])("div", r, [
            0 !== l.voice.callInfo
              ? (Object(i["e"])(),
                Object(i["b"])(
                  "p",
                  { key: 0, class: { talking: l.voice.talking } },
                  " [Call] ",
                  2
                ))
              : Object(i["c"])("", !0),
            l.voice.radioEnabled && 0 !== l.voice.radioChannel
              ? (Object(i["e"])(),
                Object(i["b"])(
                  "p",
                  { key: 1, class: { talking: l.voice.usingRadio } },
                  Object(i["g"])(l.voice.radioChannel) + " Mhz [Radio] ",
                  3
                ))
              : Object(i["c"])("", !0),
            l.voice.voiceModes.length
              ? (Object(i["e"])(),
                Object(i["b"])(
                  "p",
                  { key: 2, class: { talking: l.voice.talking } },
                  Object(i["g"])(l.voice.voiceModes[l.voice.voiceMode][1]) +
                    " [Range] ",
                  3
                ))
              : Object(i["c"])("", !0),
          ]),
        ])
      );
    }
    var u = {
      name: "App",
      setup() {
        const e = Object(i["f"])({
          voiceModes: [],
          voiceMode: 0,
          radioChannel: 0,
          radioEnabled: !1,
          usingRadio: !1,
          callInfo: 0,
          talking: !1,
        });
        let o = !1;
        return (
          window.addEventListener("message", function (n) {
            const i = n.data;
            if (
              (void 0 !== i.voiceModes &&
                (e.voiceModes = JSON.parse(i.voiceModes)),
              void 0 !== i.voiceMode && (e.voiceMode = i.voiceMode),
              void 0 !== i.radioChannel && (e.radioChannel = i.radioChannel),
              void 0 !== i.radioEnabled && (e.radioEnabled = i.radioEnabled),
              void 0 !== i.callInfo && (e.callInfo = i.callInfo),
              i.usingRadio !== e.usingRadio &&
                ((o = !0),
                (e.usingRadio = i.usingRadio),
                setTimeout(function () {
                  o = !1;
                }, 100)),
              void 0 === i.talking ||
                e.usingRadio ||
                o ||
                (e.talking = i.talking),
              i.sound && e.radioEnabled)
            ) {
              let e = document.getElementById(i.sound);
              e.load(), (e.volume = i.volume), e.play().catch((e) => {});
            }
          }),
          { voice: e }
        );
      },
    };
    n("33df");
    u.render = l;
    var s = u;
    Object(i["a"])(s).mount("#app");
  },
});
