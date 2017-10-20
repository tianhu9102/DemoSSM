<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Accessible Map</title>
    <link rel="stylesheet" href="https://openlayers.org/en/v3.19.1/css/ol.css" type="text/css">
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
     <!--  <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script> //如果要支持低版本浏览器你可以取消注释-->
    <script src="https://openlayers.org/en/v3.19.1/build/ol.js"></script>
    <style>
      a.skiplink {
        position: absolute;
        clip: rect(1px, 1px, 1px, 1px);
        padding: 0;
        border: 0;
        height: 1px;
        width: 1px;
        overflow: hidden;
      }
      a.skiplink:focus {
        clip: auto;
        height: auto;
        width: auto;
        background-color: #fff;
        padding: 0.3em;
      }
      #map:focus {
        outline: #4A74A8 solid 0.15em;
      }
    </style>
  </head>
  
  <!-- 参考： http://blog.csdn.net/u012539364/article/details/53385648 -->
  <!-- 参考： http://blog.csdn.net/jiaotuwoaini/article/details/51452095 -->
  
  <body>
    <a class="skiplink" href="#map">Go to map</a>
    <div id="map" class="map" tabindex="0"></div>
    <button id="zoom-out">Zoom out</button>
    <button id="zoom-in">Zoom in</button>
    <script>
        var _map;
        function lu_LngLat(lng, lat) {
        //如果有坐标偏移，你可以在这做
               var lnglat = { "lng": lng, "lat": lat };
            
            //经纬度坐标转换到高斯坐标
            return ol.proj.fromLonLat([lnglat.lng, lnglat.lat]);
        }
        //------------------------------//
      
        /**
        * 轨迹回放
       
        * @constructor
        */
        function lu_LocusOption(data) {
            this.locusData = {
                locusId: null,
                label: null,
                /* icon: "http://webapi.amap.com/images/car.png", */
                icon: "${pageContext.request.contextPath}/jslib/img/flight.png",
                lnglat: [],
                lineType: "solid",
                lineWidth: 3,
                nodeIcon: null,
                lineOpacity: 0.6,
                lineColor: "#0000ff"
            }

            this.locusState = {
                moveSpeed: 100,
                isSetView: true,
                syncEvent: null,
                circlable: false,
                overlayEvent: null
            }
            if (data) {
                if (data.locusData) {
                    if (data.locusData.locusId) this.locusData.locusId = data.locusData.locusId;
                    if (data.locusData.icon) this.locusData.icon = data.locusData.icon;
                    if (data.locusData.label) this.locusData.label = data.locusData.label;
                    if (data.locusData.lnglat) this.locusData.lnglat = data.locusData.lnglat;
                    if (data.locusData.lineType) this.locusData.lineType = data.locusData.lineType;
                    if (data.locusData.nodeIcon) this.locusData.nodeIcon = data.locusData.nodeIcon;
                    if (data.locusData.lineWidth) this.locusData.lineWidth = data.locusData.lineWidth;
                    if (data.locusData.lineColor) this.locusData.lineColor = data.locusData.locusData.lineColor;
                    if (data.locusState) {
                        if (data.locusState.moveSpeed) this.locusState.moveSpeed = data.locusState.moveSpeed;
                        if (data.locusState.isSetView != undefined) this.locusState.isSetView = data.locusState.isSetView;
                        if (data.locusState.syncEvent) this.locusState.syncEvent = data.locusState.syncEvent;
                        if (data.locusState.circlable != undefined) this.locusState.circlable = data.locusState.circlable;
                        if (data.locusState.overlayEvent) this.locusState.overlayEvent = data.locusState.overlayEvent;
                    }
                }
            }
        }

        var _lu_locus;
        var lu_MoveLocus = function(LocusOption, isfor) {
            if (_lu_locus) {
                _lu_locus.stop();
            }
            try {

                var _locusState = LocusOption.locusState;
                var _locusData = LocusOption.locusData;
                if (_locusState.isClearOverlay) {
                    //清空
                }
              
                lu_DrawLinesAndMarkers(_locusData, _locusState);

                //开启路书
                _lu_locus = new TYMapLib.lu_track(_map, _locusData.lnglat, {
                    defaultContent: _locusData.label,
                    autoView: _locusState.isSetView, //是否开启自动视野调整，如果开启那么路书在运动过程中会根据视野自动调整
                    speed: _locusState.moveSpeed,
                    enableRotation: true, //是否设置marker随着道路的走向进行旋转
                    circlable: _locusState.circlable
                });

            } catch (e) {
                console.log(e.message);
            }
        }

        function lu_DrawLinesAndMarkers(locusData, _locusState) {
            if (locusData) {
                if (locusData.nodeIcon) image = locusData.nodeIcon;
                if (locusData.label) text = locusData.label.content;
                if (locusData.label) offset = locusData.label.offset;
            }
          
            var styles = {
                'route': new ol.style.Style({
                    stroke: new ol.style.Stroke({
                        width: 2, color: [237, 212, 0, 0.8]
                    })
                }),
                'node': new ol.style.Style({
                    image: new ol.style.Circle({
                        radius: 5,
                        stroke: new ol.style.Stroke({
                            color: "#ffffff",
                            width: 2
                        }),
                        fill: new ol.style.Fill({
                            color: "#000000"
                        })
                    })
                }),
                'icon1': new ol.style.Style({
                    image: new ol.style.Icon({
                        anchor: [0.5, 1],
                        src: image
                    }),
                    text: new ol.style.Text({
                        font: "13px Microsoft Yahei",
                        text: "起点",
                        fill: new ol.style.Fill({
                            color: "#aa3300"
                        }),
                        stroke: new ol.style.Stroke({ color: "#fff", width: 2 }),
                        textAlign: "left"
                    })
                }),
                'icon2': new ol.style.Style({
                    image: new ol.style.Icon({
                        anchor: [0.5, 1],
                        src: image
                    }),
                    text: new ol.style.Text({
                        font: "13px Microsoft Yahei",
                        text: "终点",
                        fill: new ol.style.Fill({
                            color: "#aa3300"
                        }),
                        stroke: new ol.style.Stroke({ color: "#fff", width: 2 }),
                        textAlign: "left"
                    })
                }),
                'geoMarker': new ol.style.Style({
                    image: new ol.style.Icon({
                        anchor: [0.5, 0.5],
                        rotation: 0,
                        size: [52, 26],
                        /* src: 'http://webapi.amap.com/images/car.png' */
                        src: "${pageContext.request.contextPath}/jslib/img/flight.png"
                    }),
                    text: new ol.style.Text({
                        font: "13px Microsoft Yahei",
                        text: text,
                        fill: new ol.style.Fill({
                            color: "#aa3300"
                        }),
                        stroke: new ol.style.Stroke({ color: "#fff", width: 2 }),
                        offsetX: offset[0],
                        offsetY: offset[1],
                        textAlign: "left"
                    })
                })
            };

            var locussff = [], star, stop;
            var style = new ol.style.Style({
                stroke: new ol.style.Stroke({
                    width: 5,
                    color: [237, 212, 0, 0.8]
                })
            });
            var lineFeature = new ol.Feature(new ol.geom.LineString(locusData.lnglat));
            lineFeature.setId(locusData.locusId);
            lineFeature.setStyle(style);
            locussff.push(lineFeature);

            //节点打印
            var arrLngLat = locusData.lnglat;

            var arrX = [], arrY = [];
            for (var i in arrLngLat) {
                //console.log(i)
                if (i > 0 && i < arrLngLat.length - 1) {
                    var nodeMarker = new ol.Feature({
                        type: 'node',
                        geometry: new ol.geom.Point(locusData.lnglat[i])
                    });
                    locussff.push(nodeMarker);
                } else {
                    if (i == 0) {
                        var starMarker = new ol.Feature({
                        type: 'node',
                            geometry: new ol.geom.Point(arrLngLat[i])
                        });
                        locussff.push(starMarker);
                    } else if (i == arrLngLat.length - 1) {
                        var startMarker = new ol.Feature({
                        type: 'node',
                            geometry: new ol.geom.Point(arrLngLat[i])
                        });
                        locussff.push(startMarker);
                    }
                }
                arrX.push(arrLngLat[i][0]);
                arrY.push(arrLngLat[i][1]);
            }

            var routeCoords = arrLngLat;
            var routeLength = arrLngLat.length;

            var vectorLayer = new ol.layer.Vector({
                zIndex: 50000,
                source: new ol.source.Vector({
                    features: locussff
                }),
                style: function(feature) {
                    // hide geoMarker if animation is active
                    if (feature.get('type') === 'geoMarker') return null;
                    return styles[feature.get('type')];
                }
            });

            _map.addLayer(vectorLayer);

            //标题
            var mp2 = document.createElement("div");
            mp2.id = "mycar_title";
            mp2.innerHTML = text;

            var title = new ol.Overlay({
                id: "_ty_lj_key_title",
                //autoPan: true,
                position: [arrX[0][0], arrY[0][1]],
                stopEvent: false,
                offset: offset,
                positioning: "bottom-left",
                element: mp2
            });
            _map.addOverlay(title);

            //视野
            _lu_box(arrX, arrY);
            /**
            * 获取最好视野
            * @param __boxX
            * @param __boxY
            * @author luwenjun 2016-9-22
            * @returns
            */
            function _lu_box(__boxX, __boxY) {
                try {
                    var sort1 = [__boxX.sort()[0], __boxX.sort()[__boxX.sort().length - 1]];
                    var sort2 = [__boxY.sort()[0], __boxY.sort()[__boxY.sort().length - 1]];
                    _map.getView().fit([sort1[0], sort2[0], sort1[1], sort2[1]], _map.getSize());
                } catch (e) {
                    console.log(e.message);
                }
            }

            //添加事件
            if (_locusState.overlayEvent) {
                var keys__ = _map.on(_locusState.overlayEvent.mouseEvent, function(evt) {
                    var feature = _map.forEachFeatureAtPixel(evt.pixel,
                            function(feature) {
                                return feature;
                            });
                    if (feature) {
                        var mkNew = new Object();
                        var coord = feature.getGeometry().getCoordinates();
                        var newcoord = new GPSLngLat(coord[0], coord[1]);
                        mkNew.lng = newcoord.GPSLng;
                        mkNew.lat = newcoord.GPSLat;

                        _locusState.overlayEvent.mouseFunc(mkNew);
                    }
                });
                _ty_point.push(keys__);
            }
        }

        function TYCar(lnglat, config) {
            var mp = document.createElement("div");
            mp.id = "mymovecar";
            mp.style.position = "absolute";

            var mimg = document.createElement("img");
            if (config.icon) mimg.src = config.icon;
            mp.appendChild(mimg);

            var TYMarker = new ol.Overlay({
                id: "_ty_lj_key_car",
                stopEvent: false,
                offset: [-26, -13],
                positioning: "center-center",
                element: mp
            });

            TYMarker.setPosition(lnglat);
            //console.log(config);
            TYMarker.setRotation = function(a) {
                if (!isNaN(a)) {
                    if (a <= 360 && a >= 0) {
                        var x = document.getElementById("mymovecar");
                        x.style.transform = "rotate(" + a + "deg)";
                    }
                }
            }

            return TYMarker;
        }

        /**
        * @namespace BMap的所有library类均放在TYMapLib命名空间下
        */
        var TYMapLib = window.TYMapLib = TYMapLib || {};
        (function() {
            /**
            * @exports lu_track as TYMapLib.lu_track
            */
            var lu_track =
                    TYMapLib.lu_track = function(map, path, opts) {
                        if (!path || path.length < 1) {
                            return;
                        }
                        this.ismove = false;
                        this._cc = 0;
                        this._map = map;
                        //存储一条路线
                        this._path = path;
                        //移动到当前点的索引
                        this.i = 0;
                        //控制暂停后开始移动的队列的数组
                        this._setTimeoutQuene = [];
                        //进行坐标转换的类
                        // this._projection = this._map.getMapType().getProjection();
                        this._opts = {
                            icon: null,
                            //默认速度 米/秒
                            speed: 400,
                            defaultContent: ''
                        };
                        this._setOptions(opts);
                        this._rotation = 0; //小车转动的角度

                        //如果不是默认实例，则使用默认的icon  instanceof BMap.Icon
                        if (!this._opts.icon) {
                            /* this._opts.icon = "http://webapi.amap.com/images/car.png"; */
                        	this._opts.icon ="${pageContext.request.contextPath}/jslib/img/flight.png";
                        }

                    }
            /**
            * 根据用户输入的opts，修改默认参数_opts
            * @param {Json Object} opts 用户输入的修改参数.
            * @return 无返回值.
            */
            lu_track.prototype._setOptions = function(opts) {
                if (!opts) {
                    return;
                }
                for (var p in opts) {
                    if (opts.hasOwnProperty(p)) {
                        this._opts[p] = opts[p];
                    }
                }
            }

            /**
            * @description 开始运动
            * @param none
            * @return 无返回值.
            *
            * @example <b>参考示例：</b><br />
            * lu_track.start();
            */
            lu_track.prototype.start = function() {
                this.ismove = true;
                var me = this, len = me._path.length;

                //不是第一次点击开始,并且小车还没到达终点
                if (me.i && me.i < len - 1) {
                    //没按pause再按start不做处理
                    if (!me._fromPause) {
                        return;
                    } else if (!me._fromStop) {
                        //按了pause按钮,并且再按start，直接移动到下一点
                        //并且此过程中，没有按stop按钮
                        //防止先stop，再pause，然后连续不停的start的异常
                        me._moveNext(++me.i);

                    }
                } else {
                    //第一次点击开始，或者点了stop之后点开始
                    me._addMarker();
                    //等待marker动画完毕再加载infowindow
                    me._timeoutFlag = setTimeout(function() {
                        //弹出窗口
                        //me._addInfoWin();
                        if (me._opts.defaultContent == "") {
                            //  me.hideInfoWindow();
                        }
                        me._moveNext(me.i);
                    }, 400);
                }
                //重置状态
                this._fromPause = false;
                this._fromStop = false;
            },
            /**
            * 结束运动
            * @return 无返回值.
            *
            * @example <b>参考示例：</b><br />
            * lu_track.stop();
            */
                    lu_track.prototype.stop = function() {
                        this.ismove = false;
                        this.i = 0;
                        this._fromStop = true;
                        clearInterval(this._intervalFlag);
                        this._clearTimeout();
                        //重置landmark里边的poi为未显示状态
                        /*  for (var i = 0, t = this._opts.landmarkPois, len = t.length; i < len; i++) {
                        t[i].bShow = false;
                        }*/
                    };
            /**
            * 暂停运动
            * @return 无返回值.
            */
            lu_track.prototype.pause = function() {

                clearInterval(this._intervalFlag);

                //标识是否是按过pause按钮
                this._fromPause = true;
                this._clearTimeout();
            };
            /**
            * 隐藏上方overlay
            * @return 无返回值.
            *
            * @example <b>参考示例：</b><br />
            * lu_track.hideInfoWindow();
            */
            lu_track.prototype.hideInfoWindow = function() {
                this._overlay._div.style.visibility = 'hidden';
            };
            /**
            * 显示上方overlay
            * @return 无返回值.
            *
            * @example <b>参考示例：</b><br />
            * lu_track.showInfoWindow();
            */

            lu_track.prototype.showInfoWindow = function() {
                this._overlay._div.style.visibility = 'visible';
            };


            //lu_track私有方法
          
            /**
            * 添加marker到地图上
            * @param {Function} 回调函数.
            * @return 无返回值.
            */
            lu_track.prototype._addMarker = function(callback) {
                if (this._marker) {
                    this.stop();
                    this._marker.setMap(null);

                    clearTimeout(this._timeoutFlag);
                }
                //移除之前的overlay
                this._overlay && this._overlay.setMap(null);
                var marker = new TYCar(this._path[0], this._opts);
                //this._opts.icon && marker.setIcon(this._opts.icon);


                // this._opts.icon && marker.setIcon(this._opts.icon);
                _map.addOverlay(marker);
               
                //if (this._opts.defaultContent && this._opts.defaultContent != "")
                this._marker = marker;


                // var adiv = this._marker.getIcon().containerDiv;
                //adiv.innerHTML = adiv.innerHTML + "<br/>" + this._opts.defaultContent;


            },
            /**
            * 添加上方overlay
            * @return 无返回值. 暂时无用
            */
                    lu_track.prototype._addInfoWin = function() {
                        var me = this;
                        //if(me._opts.defaultContent!== ""){
                        var overlay = new CustomOverlay(me._marker.getLngLat(), me._opts.defaultContent);

                        //将当前类的引用传给overlay。
                        overlay.setRelatedClass(this);
                        this._overlay = overlay;
                        this._map.TYaddOverLay(overlay);

                        //}

                    },

            /**
            * 计算两点间的距离
            * @param {Point} poi 经纬度坐标A点.
            * @param {Point} poi 经纬度坐标B点.
            * @return 无返回值.
            */
                    lu_track.prototype._getDistance = function(pxA, pxB) {
                        return formatLength([pxA, pxB])
                    },
            //目标点的  当前的步长,position,总的步长,动画效果,回调
            /**
            * 移动小车
            * @param {Number} poi 当前的步长.
            * @param {Point} initPos 经纬度坐标初始点.
            * @param {Point} targetPos 经纬度坐标目标点.
            * @param {Function} effect 缓动效果.
            * @return 无返回值.
            */
                    lu_track.prototype._move = function(initPos, targetPos, effect, currentCount) {
                        var me = this;
                        me.ismove = true;
                        //当前的帧数
                        if (!currentCount)
                            currentCount = 0;
                        //步长，米/秒
                        var timer = 10,
                                step = this._opts.speed / (1000 / timer),
                        //初始坐标
                                init_pos = this._map.getPixelFromCoordinate(initPos),
                        //获取结束点的(x,y)坐标
                                target_pos = this._map.getPixelFromCoordinate(targetPos),
                        //总的步长
                                count = Math.round(me._getDistance(init_pos, target_pos) / step);

                        //如果小于1直接移动到下一点
                        if (count < 1) {
                            me._moveNext(++me.i);
                            return;
                        }
                        //两点之间匀速移动 setInterval
                        me._intervalFlag = setInterval(function() {
                            //两点之间当前帧数大于总帧数的时候，则说明已经完成移动
                            if (currentCount >= count) {
                                clearInterval(me._intervalFlag);
                                //移动的点已经超过总的长度
                                if (me.i > me._path.length) {
                                    return;
                                }
                                //运行下一个点
                                me._moveNext(++me.i);
                            } else {
                                currentCount++;
                                me._cc = currentCount;
                                var x = effect(init_pos[0], target_pos[0], currentCount, count),
                                        y = effect(init_pos[1], target_pos[1], currentCount, count),
                                        pos = me._map.getCoordinateFromPixel([x, y]);
                                //console.log(pos);
                                //设置marker
                                if (currentCount == 1) {
                                    var proPos = null;
                                    if (me.i - 1 >= 0) {
                                        proPos = me._path[me.i - 1];
                                    }
                                    if (me._opts.enableRotation == true) {
                                        me.setRotation(proPos, initPos, targetPos);
                                    }
                                    if (me._opts.autoView) {

                                    }
                                }

                                var extent = _map.getView().calculateExtent(_map.getSize());
                                var bl = ol.extent.getBottomLeft(extent);
                                var tr = ol.extent.getTopRight(extent);
                                var bb = ol.extent.containsCoordinate([bl[0], bl[1], tr[0], tr[1]], pos);

                                //移动中的label
                                var overs = _map.getOverlayById("_ty_lj_key_title");
                                overs.setPosition(pos);

                                if (!bb) {
                                    if (me._opts.autoView) {
                                        clearInterval(me._intervalFlag);
                                        _map.getView().setCenter(pos);
                                        me._move(initPos, targetPos, me._tween.linear);
                                    } else {
                                        me._marker.setPosition(pos);
                                    }
                                } else {
                                    me._marker.setPosition(pos);
                                }
                            }
                        }, timer);
                    },

            /**
            *在每个点的真实步骤中设置小车转动的角度
            */
                    lu_track.prototype.setRotation = function(prePos, curPos, targetPos) {
                        //console.log(prePos);console.log(curPos);

                        var me = this;

                        curPos = me._map.getPixelFromCoordinate(curPos);
                        targetPos = me._map.getPixelFromCoordinate(targetPos);

                        curPos = { x: curPos[0], y: curPos[1] };
                        targetPos = { x: targetPos[0], y: targetPos[1] }

                        var x = Math.abs(targetPos.x - curPos.x);
                        var y = Math.abs(targetPos.y - curPos.y);
                        var z = Math.sqrt(x * x + y * y);
                        var ration = Math.round((Math.asin(y / z) / Math.PI * 180));
                        var a = 0;
                        if (targetPos.y < curPos.y && targetPos.x == curPos.x) {
                            a = 270; // (180 - ration);
                        }
                        else if (targetPos.y > curPos.y && targetPos.x == curPos.x)
                            a = 90///ration;
                        else if (targetPos.y == curPos.y && targetPos.x < curPos.x)
                            a = 180//(180 - ration);
                        else if (targetPos.y == curPos.y && targetPos.x > curPos.x)
                            a = 0//ration;
                        else if (targetPos.y > curPos.y && targetPos.x > curPos.x)
                            a = ration;
                        else if (targetPos.y > curPos.y && targetPos.x < curPos.x)
                            a = 180 - ration;
                        else if (targetPos.y < curPos.y && targetPos.x < curPos.x)
                            a = 180 + ration;
                        else if (targetPos.y < curPos.y && targetPos.x > curPos.x)
                            a = 360 - ration;
                        this._marker.setRotation(a);
                        //console.log(a)
                        return;

                    },

                    lu_track.prototype.linePixellength = function(from, to) {
                        return Math.sqrt(Math.abs(from.x - to.x) * Math.abs(from.x - to.x) + Math.abs(from.y - to.y) * Math.abs(from.y - to.y));

                    },
                    lu_track.prototype.pointToPoint = function(from, to) {
                        return Math.abs(from.x - to.x) * Math.abs(from.x - to.x) + Math.abs(from.y - to.y) * Math.abs(from.y - to.y)
                    },

            /**
            * 移动到下一个点
            * @param {Number} index 当前点的索引.
            * @return 无返回值.
            */
                    lu_track.prototype._moveNext = function(index) {
                        this.ismove = true;
                        if (this._opts.func && this._opts.func != "")
                            _opts.func(index);
                        var me = this;
                        if (index == me._path.length - 1 && me._opts.circlable) {
                            index = 0;
                            me.i = 0;
                        }
                        if (index < this._path.length - 1) {
                            //判断是否需要屏幕暂停，移动中心
                            var ifXYZ1 = me._path[index];
                            var ifXYZ2 = me._path[index + 1];

                            var extent = _map.getView().calculateExtent(_map.getSize());

                            var bl = ol.extent.getBottomLeft(extent);
                            var tr = ol.extent.getTopRight(extent);

                            tr = [_map.getPixelFromCoordinate(tr)[0] - 30, _map.getPixelFromCoordinate(tr)[1] + 30];
                            bl = [_map.getPixelFromCoordinate(bl)[0] + 30, _map.getPixelFromCoordinate(tr)[1] - 30];

                            tr = _map.getCoordinateFromPixel(tr);
                            bl = _map.getCoordinateFromPixel(bl);

                            var extentA = ol.extent.containsCoordinate([bl[0], bl[1], tr[0], tr[1]], ifXYZ1);
                            var extentB = ol.extent.containsCoordinate([bl[0], bl[1], tr[0], tr[1]], ifXYZ2);

                            //console.log(extentA, extentB);
                            if (extentA == false || extentB == false) {
                                if (me._opts.autoView) {
                                    clearInterval(_lu_locus._intervalFlag);

                                    var centerA = (ifXYZ2[0] - ifXYZ1[0]) / 2 + ifXYZ2[0];
                                    var centerB = (ifXYZ2[1] - ifXYZ1[1]) / 2 + ifXYZ2[1];

                                    if (extentA == false && extentB == false) {
                                        _map.getView().setCenter([centerA, centerB]);
                                    }
                                    else if (extentA == false) {
                                        _map.getView().setCenter(ifXYZ1);
                                    }
                                    else if (extentB == false) {
                                        _map.getView().setCenter(ifXYZ2);
                                    } else {
                                        console.log("#1005853");
                                        return;
                                    }
                                    setTimeout(function() {
                                        me._move(me._path[index], me._path[index + 1], me._tween.linear);
                                    }, 100);
                                } else {
                                    me._move(me._path[index], me._path[index + 1], me._tween.linear);
                                }
                            } else {
                                me._move(me._path[index], me._path[index + 1], me._tween.linear);
                            }
                        }
                    },
            /**
            * 设置小车上方infowindow的内容，位置等
            * @param {Point} pos 经纬度坐标点.
            * @return 无返回值.
            */
                    lu_track.prototype._setInfoWin = function(pos) {
                        //设置上方overlay的position
                        var me = this;
                        if (!me._overlay) {
                            return;
                        }
                        me._overlay.setPosition(pos, me._marker.getIcon().size);
                        var index = me._troughPointIndex(pos);
                        if (index != -1) {
                            clearInterval(me._intervalFlag);
                            //  me._overlay.setHtml(me._opts.landmarkPois[index].html);
                            me._overlay.setPosition(pos, me._marker.getIcon().getSize());
                            me._pauseForView(index);
                        } else {
                            me._overlay.setHtml(me._opts.defaultContent);
                        }
                    },
            /**
            * 在某个点暂停的时间
            * @param {Number} index 点的索引.
            * @return 无返回值.
            */
                    lu_track.prototype._pauseForView = function(index) {

                        var me = this;
                        var t = setTimeout(function() {
                            //运行下一个点
                            me._moveNext(++me.i);
                        },
                                me._opts.landmarkPois[index].pauseTime * 1000);
                        me._setTimeoutQuene.push(t);
                    },
            //清除暂停后再开始运行的timeout
                    lu_track.prototype._clearTimeout = function() {
                        for (var i in this._setTimeoutQuene) {
                            clearTimeout(this._setTimeoutQuene[i]);
                        }
                        this._setTimeoutQuene.length = 0;
                    },
            //缓动效果
                    lu_track.prototype._tween = {
                        //初始坐标，目标坐标，当前的步长，总的步长
                        linear: function(initPos, targetPos, currentCount, count) {
                            var b = initPos, c = targetPos - initPos, t = currentCount,
                                    d = count;
                            return c * t / d + b;
                        }
                    },

            /**
            * 否经过某个点的index
            * @param {Point} markerPoi 当前小车的坐标点.
            * @return 无返回值.
            */
                    lu_track.prototype._troughPointIndex = function(markerPoi) {
                        var t = this._opts.landmarkPois, distance;
                        for (var i = 0, len = t.length; i < len; i++) {
                            //landmarkPois中的点没有出现过的话
                            if (!t[i].bShow) {
                                distance = markerPoi.distance(new AMap.LngLat(t[i].lng, t[i].lat));
                                //两点距离小于10米，认为是同一个点
                                if (distance < 10) {
                                    t[i].bShow = true;
                                    return i;
                                }
                            }
                        }
                        return -1;
                    }
        })();

        function LocusStart() {
            if (_lu_locus)
                _lu_locus.start();
        }

        function LocusStop() {
            if (_lu_locus)
                _lu_locus.stop()
        }

        function LocusPause() {
            if (_lu_locus)
                _lu_locus.pause()
        }

        /**
        * 求多点间距离
        * @param hex
        * @param opacity
        * @author luwenjun 2016-9-22
        * @returns
        */
        var formatLength = function(coordinates) {
            var wgs84Sphere = new ol.Sphere(6378137), length = 0;
            var sourceProj = _map.getView().getProjection();
            for (var i = 0, ii = coordinates.length - 1; i < ii; ++i) {
                var c1 = ol.proj.transform(coordinates[i], sourceProj, 'EPSG:4326');
                var c2 = ol.proj.transform(coordinates[i + 1], sourceProj, 'EPSG:4326');
                length += wgs84Sphere.haversineDistance(c1, c2);
            }
            return length;
        };


        _map = new ol.Map({
            layers: [
          new ol.layer.Tile({
              source: new ol.source.OSM()
          })
        ],
            target: 'map',
            controls: ol.control.defaults({
                attributionOptions: /** @type {olx.control.AttributionOptions} */({
                    collapsible: false
                })
            }),
            view: new ol.View({
                center: [0, 0],
                zoom: 2
            })
        });
        
        //轨迹回放
        //------轨迹回放------//
        var lineArr = new Array();
        var lngX = 116.397428, latY = 39.90923;
        //数组中添加坐标
        lineArr.push(new lu_LngLat(lngX, latY));
        //随机生成坐标点
        for (var i = 1; i < 10; i++) {
            lngX = lngX + Math.random() * 0.1;
            if (i % 2) {
                latY = latY + Math.random() * 0.1;
            } else {
                latY = latY + Math.random() * 0.6;
            }
            lineArr.push(new lu_LngLat(lngX, latY));
        }

        //创建入参方法
        var p = new lu_LocusOption({
            locusData: {
                locusId: 1, //路径点id
                nodeIcon: "http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png", //路径点图标
                label: new Object({//加入label对象
                    offset: [15, 0], //修改label相对于maker的位置 偏移
                    content: "CCA1502" //显示内容，也可以为html
                }),
                lnglat: lineArr//路径点数组
            },
            locusState: {
                circlable: false //是否循环播放，false只做一次
            }
        })
      
        lu_MoveLocus(p); //执行构造函数，接收返回参数lu_MoveLocus
        LocusStart(); //开始动画
        //LocusStop();//停止动画
        //LocusPause();//暂停动画，调用LocusStart()方法继续
        
        function setvalue1(e) {
            alert("点击成功，触发了回调函数")
        }
    </script>
  </body>
</html>