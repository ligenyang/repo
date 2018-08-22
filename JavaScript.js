const date = new Date(), y = date.getFullYear(), m = date.getMonth();
const currentDay = date.formatDate("yyyy-MM-dd");//当前日期
const firstDay = new Date(y, m, 1).formatDate('yyyy-MM-dd');
const lastDay = new Date(y, m + 1, 0).formatDate('yyyy-MM-dd');//上个月的今天
