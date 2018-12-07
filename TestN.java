package cn.thu.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class TestN
{

    public static void main(String[] args)
    {
        Point p0 = new Point();
        p0.setX(4.5);
        p0.setY(4.5);
        p0.setZ(4.5);

        List<Point> lstPointsView1 = new ArrayList<Point>();
        Point p1 = new Point();
        p1.setX(7.5);
        p1.setY(34.5);
        p1.setZ(2.5);

        Point p2 = new Point();
        p1.setX(3.5);
        p1.setY(4.5);
        p1.setZ(3.5);

        Point p3 = new Point();
        p1.setX(103.5);
        p1.setY(118.5);
        p1.setZ(53.5);
        lstPointsView1.add(p3);
        lstPointsView1.add(p2);
        lstPointsView1.add(p1);

        Point nearest = findNearestPoint(p0, lstPointsView1);
        System.out.println(nearest.getX());
    }

    // 返回三个视图中最近点的列表
    public List<List<Point>> compute(List<Point> lstPoints_Red, List<Point> lstPoints_Dark, List<Point> lstPoints_Green)
    {
        List<List<Point>> llsist = new ArrayList<List<Point>>();

        for (int i = 0; i < lstPoints_Red.size(); i++)
        {
            // 红色点中的第i个点：pointView0
            Point pointView0 = lstPoints_Red.get(i);

            // 黑色点中距离pointView0最近的点：pointView1，两者构成一组数据
            Point pointView1 = findNearestPoint(pointView0, lstPoints_Dark);

            // 绿色点中距离pointView0、pointView1最近的点，三者构成一组数据
            Point pointView2 = findNearestPoint(pointView0, lstPoints_Green);

            // 红色点中第i个点、及其距离最近的黑色、绿色点，三者构成一组数据
            List<Point> lstpointV012 = new ArrayList<Point>();
            lstpointV012.add(pointView0);
            lstpointV012.add(pointView1);
            lstpointV012.add(pointView2);

            llsist.add(lstpointV012);
        }

        return llsist;
    }

    // 给定一个点，得到另一个view里最近的点
    public static Point findNearestPoint(Point pointView0, List<Point> lstPointsView1)
    {
        double vx = pointView0.getX();
        double vy = pointView0.getY();
        double vz = pointView0.getZ();

        Map<Point, Double> map = new HashMap<Point, Double>();
        for (int i = 0; i < lstPointsView1.size(); i++)
        {
            double x = lstPointsView1.get(i).getX();
            double y = lstPointsView1.get(i).getY();
            double z = lstPointsView1.get(i).getZ();

            // 计算距离的平方
            double length = Math.sqrt(Math.abs(vx - x)) + Math.sqrt(Math.abs(vy - y)) + Math.sqrt(Math.abs(vz - z));

            map.put(lstPointsView1.get(i), length);
        }

        // 排序获取最近的点
        Collection<Double> valueCollection = map.values();
        List<Double> lstdouble = new ArrayList<Double>(valueCollection);
        Collections.sort(lstdouble);

        double nearestLength = lstdouble.get(0);

        Point neartPoint = (Point) getKey(map, nearestLength);

        return neartPoint;
    }

    public static Object getKey(Map map, Object value)
    {
        List<Object> keyList = new ArrayList<Object>();
        for (Object key : map.keySet())
        {
            if (map.get(key).equals(value))
            {
                keyList.add(key);
            }
        }
        return keyList;
    }

    // 构造模拟数据： 点云（红色）、点云（绿色）、点云（黑色）
    public static List<Point> createDatas()
    {
        List<Point> lstPoints_Red = new ArrayList<Point>();

        for (int i = 0; i < 20; i++)
        {

            double random_x = new Random().nextDouble();// 0.0-1.0的随机数
            double random_y = new Random().nextDouble();// 0.0-1.0的随机数
            double random_z = new Random().nextDouble();// 0.0-1.0的随机数

            Point point = new Point();
            point.setX(random_x * 12);
            point.setY(random_y * 4);
            point.setZ(random_z * 9);

            lstPoints_Red.add(point);
        }

        return lstPoints_Red;
    }

}
