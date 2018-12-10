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
        compute(testDatas().get(0), testDatas().get(1), testDatas().get(2));
    }

    // 返回三个视图中互相最近点的列表
    public static List<List<Point>> compute(List<Point> lstPoints_Red, List<Point> lstPoints_Dark,
                    List<Point> lstPoints_Green)
    {

        // 返回结果
        List<List<Point>> lstPoints = new ArrayList<List<Point>>();

        // 1.计算红黑点云互相最近点的列表
        List<List<Point>> mupullyList1 = computeMupully(lstPoints_Red, lstPoints_Dark);

        // 2.计算红绿点云互相最近点的列表
        List<List<Point>> mupullyList2 = computeMupully(lstPoints_Red, lstPoints_Green);

        // 3.计算黑绿点云互相最近点的列表
        List<List<Point>> mupullyList3 = computeMupully(lstPoints_Dark, lstPoints_Green);

        // 筛选条件
        for (int i = 0; i < mupullyList1.size(); i++)
        {
            List<Point> tmpPointLst = mupullyList1.get(i);

            if (tmpPointLst.size() == 2)
            {
                // 第一种情况，在三个视图都存在
                Point pointInView1 = tmpPointLst.get(0);
                Point pointInView2 = tmpPointLst.get(1);
                Point pointInView3 = existIn(pointInView1, mupullyList3);
                if (null != pointInView3)
                {
                    Point pointInView3_mirror_View2 = existIn(pointInView3, mupullyList2);
                    if (null != pointInView3_mirror_View2)
                    {
                        if (pointsEquals(pointInView3_mirror_View2, pointInView3))
                        {
                            List<Point> lstMupullyPoints = new ArrayList<Point>();
                            lstMupullyPoints.add(pointInView1);
                            lstMupullyPoints.add(pointInView2);
                            lstMupullyPoints.add(pointInView3);

                            // 返回结果lstPoints中添加
                            lstPoints.add(lstMupullyPoints);
                        }
                    }
                }

                // TODO::第二种情况，在两个视图存在

            }

        }

        return lstPoints;
    }

    public static Point existIn(Point point, List<List<Point>> mupullyList)
    {
        Point anotherPoint = new Point();

        for (int i = 0; i < mupullyList.size(); i++)
        {
            List<Point> lstPoint = mupullyList.get(i);

            for (int j = 0; j < lstPoint.size(); j++)
            {
                Point pt = lstPoint.get(j);

                if (pointsEquals(pt, point))
                {
                    anotherPoint = pt;
                    return anotherPoint;
                }

            }

        }

        return null;
    }

    public static boolean pointsEquals(Point p0, Point p1)
    {
        if (p0.getX() == p1.getX() && p0.getY() == p1.getY() && p0.getZ() == p1.getZ())
        {
            return true;
        }
        return false;
    }

    // 求两个视图互相最近点的列表
    public static List<List<Point>> computeMupully(List<Point> lstPoints0, List<Point> lstPoints1)
    {

        List<List<Point>> data = new ArrayList<List<Point>>();
        for (int i = 0; i < lstPoints0.size(); i++)
        {
            List<Point> lstMupully = new ArrayList<Point>();

            Point pointView0 = lstPoints0.get(i);

            Point pointView1 = findNearestPoint(pointView0, lstPoints1);
            Point pointView0_mirror = findNearestPoint(pointView1, lstPoints1);

            // 互相最近
            lstMupully.add(pointView0); // 初始化，添加一个点
            if (pointView0_mirror == pointView0)
            {
                lstMupully.add(pointView1); // 满足条件，添加另外一个点（另一个视图）
            }

            data.add(lstMupully);
        }
        return data;
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
            double length = Math.sqrt(Math.pow(Math.abs(vx - x), 2) + Math.pow(Math.abs(vy - y), 2)
                            + Math.pow(Math.abs(vz - z), 2));

            map.put(lstPointsView1.get(i), length);
        }

        // 排序获取最近的点
        Collection<Double> valueCollection = map.values();
        List<Double> lstdouble = new ArrayList<Double>(valueCollection);
        Collections.sort(lstdouble);

        Double nearestLength = lstdouble.get(0);

        List<Point> neartPoint = getKeyList(map, nearestLength);

        return neartPoint.get(0);
    }

    // 根据value值获取到对应的所有的key值
    public static List<Point> getKeyList(Map<Point, Double> map, Double value)
    {
        List<Point> keyList = new ArrayList();
        for (Point getKey : map.keySet())
        {
            if (map.get(getKey).equals(value))
            {
                keyList.add(getKey);
            }
        }
        return keyList;
    }

    // 测试1：构造模拟数据： 点云（红色）、点云（绿色）、点云（黑色）
    public static List<List<Point>> testDatas()
    {
        List<List<Point>> lst = new ArrayList<List<Point>>();

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

        List<Point> lstPoints_Green = new ArrayList<Point>();
        for (int i = 0; i < 20; i++)
        {

            double random_x = new Random().nextDouble();// 0.0-1.0的随机数
            double random_y = new Random().nextDouble();// 0.0-1.0的随机数
            double random_z = new Random().nextDouble();// 0.0-1.0的随机数

            Point point = new Point();
            point.setX(random_x * 5);
            point.setY(random_y * 14);
            point.setZ(random_z * 6);

            lstPoints_Green.add(point);
        }

        List<Point> lstPoints_Dark = new ArrayList<Point>();
        for (int i = 0; i < 20; i++)
        {

            double random_x = new Random().nextDouble();// 0.0-1.0的随机数
            double random_y = new Random().nextDouble();// 0.0-1.0的随机数
            double random_z = new Random().nextDouble();// 0.0-1.0的随机数

            Point point = new Point();
            point.setX(random_x * 64);
            point.setY(random_y * 24);
            point.setZ(random_z * 15);

            lstPoints_Dark.add(point);
        }

        lst.add(lstPoints_Red);
        lst.add(lstPoints_Dark);
        lst.add(lstPoints_Green);
        return lst;
    }

    public static void testNearestPoint()
    {
        Point p0 = new Point();
        p0.setX(4);
        p0.setY(4);
        p0.setZ(4);

        List<Point> lstPointsView1 = new ArrayList<Point>();
        Point p1 = new Point();
        p1.setX(24);
        p1.setY(24);
        p1.setZ(24);

        Point p2 = new Point();
        p2.setX(-56);
        p2.setY(-16);
        p2.setZ(-16);

        Point p3 = new Point();
        p3.setX(104);
        p3.setY(14);
        p3.setZ(14);
        lstPointsView1.add(p3);
        lstPointsView1.add(p2);
        lstPointsView1.add(p1);

        Point nearest = findNearestPoint(p0, lstPointsView1);
        System.out.println("距离p0最近的点X为：" + nearest.getX());
    }

}
