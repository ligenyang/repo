package com.core;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 解析 Excel (Microsoft Excel XLS 2003, Microsoft Excel OOXML XLSX 2007)
 * Apache POI 4.0.1, Apache POI-OOXML 4.0.1
 */
public class ExcelParser {

    /**
     * 解析 Excel (Microsoft Excel XLS 2003, Microsoft Excel OOXML XLSX 2007)
     * @param filePath 文件绝对路径
     * @return List<Map<String, String>>
     */
    public static List<Map<String, String>> parseExcel(String filePath) {
        Path path = Paths.get(filePath);
        String contentType = null;
        try {
            contentType = Files.probeContentType(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<Map<String, String>> mapList = null;
        if("application/vnd.ms-excel".equals(contentType)) {
            mapList = parseExcelXLS(filePath);
        }
        if("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet".equals(contentType)) {
            mapList = parseExcelXLSX(filePath);
        }
        return mapList;
    }

    /**
     * Microsoft Excel XLS 2003
     * @param filePath 文件绝对路径
     * @return List<Map<String, String>>
     */
    public static List<Map<String, String>> parseExcelXLS(String filePath) {
        InputStream inputStream = null;
        try {
            inputStream = new FileInputStream(filePath); // 文件流
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        HSSFWorkbook hssfWorkbook = null;
        try {
            if(inputStream != null) {
                hssfWorkbook = new HSSFWorkbook(inputStream); // 工作簿
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<Map<String, String>> mapList  = null;
        if(hssfWorkbook != null && hssfWorkbook.getNumberOfSheets() > 0) {
            mapList = new ArrayList<>();
            Map<String, String> map = null;
            for(int i = 0; i < hssfWorkbook.getNumberOfSheets(); i ++) {
                HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(i); // 第 i + 1 张工作表
                for(int j = 0; j < hssfSheet.getPhysicalNumberOfRows(); j ++) {
                    HSSFRow hssfRow = hssfSheet.getRow(j); // 第 j + 1 行
                    if (hssfRow == null) {
                        return mapList;
                    }
                    map = new HashMap<>();
                    int lastCellNum = hssfRow.getLastCellNum();
                    HSSFCell hssfCell;
                    if(lastCellNum > 0) {
                        for(int n = 0; n < lastCellNum; n ++) {
                            if ((hssfCell = hssfRow.getCell(n)) != null) { // 第 n + 1 列
                                hssfCell.setCellType(CellType.STRING);
                                map.put(String.valueOf(n), hssfCell.getStringCellValue().trim());
                            } else {
                                map.put(String.valueOf(n), "");
                            }
                        }
                    }
                    mapList.add(map);
                }
            }
        }
        return mapList;
    }

    /**
     * Microsoft Excel OOXML XLSX 2007
     * @param filePath 文件绝对路径
     * @return List<Map<String, String>>
     */
    public static List<Map<String, String>> parseExcelXLSX(String filePath) {
        InputStream inputStream = null;
        try {
            inputStream = new FileInputStream(filePath); // 文件流
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        XSSFWorkbook xssfWorkbook = null;
        try {
            if(inputStream != null) {
                xssfWorkbook = new XSSFWorkbook(inputStream); // 工作簿
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<Map<String, String>> mapList  = null;
        if(xssfWorkbook != null && xssfWorkbook.getNumberOfSheets() > 0) {
            mapList = new ArrayList<>();
            Map<String, String> map = null;
            for(int i = 0; i < xssfWorkbook.getNumberOfSheets(); i ++) {
                XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(i); // 第 i + 1 张工作表
                for(int j = 0; j < xssfSheet.getPhysicalNumberOfRows(); j ++) {
                    XSSFRow xssfRow = xssfSheet.getRow(j); // 第 j + 1 行
                    if (xssfRow == null) {
                        return mapList;
                    }
                    map = new HashMap<>();
                    int lastCellNum = xssfRow.getLastCellNum();
                    XSSFCell xssfCell;
                    if(lastCellNum > 0) {
                        for(int n = 0; n < lastCellNum; n ++) {
                            if ((xssfCell = xssfRow.getCell(n)) != null) { // 第 n + 1 列
                                xssfCell.setCellType(CellType.STRING);
                                map.put(String.valueOf(n), xssfCell.getStringCellValue().trim());
                            } else {
                                map.put(String.valueOf(n), "");
                            }
                        }
                    }
                    mapList.add(map);
                }
            }
        }
        return mapList;
    }
}
