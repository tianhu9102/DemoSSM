<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>五种模型运行对比（TF图像识别）</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/echart/echarts.min.js"></script>
</head>
<body>
  <div id="chart" style="width:600px;height:400px;"></div>
  <div id="chart1" style="width:600px;height:400px;"></div>
  <div id="chart2" style="width:600px;height:400px;"></div>
</body>
<script type="text/javascript">
    // 初始化图表标签
    var myChart = echarts.init(document.getElementById('chart'));
    var option={
            baseOption:{
                title:{
                    text:'五种模型对比试验-CPU',
                    //subtext:'虚拟数据'
                },
                toolbox: {
                    show : true,
                    feature : {
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                legend:{
                    data:['运行时间(s)','准确率(%)']
                },
                xAxis:{
                    //data:['ssd_mobilenet','ssd_inception','rfcn_resnet101','faster_rcnn_resnet101','faster_rcnn_inception']
                	data:['模型A','模型B','模型C','模型D','模型E']
                },
                yAxis:{

                },
                tooltip:{
                    show:true,
                    formatter:'系列名:{a}<br />类目:{b}<br />数值:{c}'
                },
                series:[{
                    name:'准确率(%)',
                    type:'bar',
                    data:[90.2,98.87,98.46,99.94,99.98],
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine:{
                        data:[
                            {type:'average',name:'平均值',itemStyle:{
                                normal:{
                                    color:'green'
                                }
                            }}
                        ]
                    }
                },{
                    name:'运行时间(s)',
                    type:'line',
                    data:[4.8,6.24,25.34,42.54,104.87],
                    // 14.53 
                    // 16.03
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine:{
                        data:[
                            {type:'average',name:'平均值',itemStyle:{
                                normal:{
                                    color:'blue'
                                }
                            }}
                        ]
                    }
                }]
            }
        };

    myChart.setOption(option);
    
    
    
    
    
    
    
    
    var myChart1 = echarts.init(document.getElementById('chart1'));
    var option1={
            baseOption:{
                title:{
                    text:'五种模型对比试验',
                    //subtext:'虚拟数据'
                },
                toolbox: {
                    show : true,
                    feature : {
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                legend:{
                    data:['CPU(:s)','GPU(:s)']
                },
                xAxis:{
                    //data:['ssd_mobilenet','ssd_inception','rfcn_resnet101','faster_rcnn_resnet101','faster_rcnn_inception']
                	data:['模型A','模型B','模型C','模型D','模型E']
                },
                yAxis:{

                },
                tooltip:{
                    show:true,
                    formatter:'系列名:{a}<br />类目:{b}<br />数值:{c}'
                },
                series:[{
                    name:'CPU(:s)',
                    type:'bar',
                    data:[4.8,6.24,25.34,42.54,104.8],
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine:{
                        data:[
                            {type:'average',name:'平均值',itemStyle:{
                                normal:{
                                    color:'green'
                                }
                            }}
                        ]
                    }
                },{
                    name:'GPU(:s)',
                    type:'line',
                    data:[4.38,4.68,7.03,6.84,12.55],
                    // 14.53 
                    // 16.03
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine:{
                        data:[
                            {type:'average',name:'平均值',itemStyle:{
                                normal:{
                                    color:'blue'
                                }
                            }}
                        ]
                    }
                }]
            }
        };

    myChart1.setOption(option1);
    
    
    
    var myChart2 = echarts.init(document.getElementById('chart2'));
    var option2={
            baseOption:{
                title:{
                    text:'五种模型对比试验',
                    //subtext:'虚拟数据'
                },
                toolbox: {
                    show : true,
                    feature : {
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                legend:{
                    data:['CPU(:min)','GPU(:min)']
                },
                xAxis:{
                    //data:['ssd_mobilenet','ssd_inception','rfcn_resnet101','faster_rcnn_resnet101','faster_rcnn_inception']
                	data:['模型A','模型B','模型C','模型D','模型E']
                },
                yAxis:{

                },
                tooltip:{
                    show:true,
                    formatter:'系列名:{a}<br />类目:{b}<br />数值:{c}'
                },
                series:[{
                    name:'CPU(:min)',
                    type:'bar',
                    data:[7,10.67,86,166,420],
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine:{
                        data:[
                            {type:'average',name:'平均值',itemStyle:{
                                normal:{
                                    color:'green'
                                }
                            }}
                        ]
                    }
                },{
                    name:'GPU(:min)',
                    type:'line',
                    data:[4.08,6.33,9.5,10.75,17.67],
                    // 14.53 
                    // 16.03
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine:{
                        data:[
                            {type:'average',name:'平均值',itemStyle:{
                                normal:{
                                    color:'blue'
                                }
                            }}
                        ]
                    }
                }]
            }
        };

    myChart2.setOption(option2);
</script>
</html>