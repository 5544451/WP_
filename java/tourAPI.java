package com.lowCO2.web;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import jakarta.servlet.ServletException;


public class tourAPI {

//    // get elapsed time of Connection
//    private static HttpURLConnection testHttpUrlConnection() throws MalformedURLException, IOException {
//        long startTime = System.currentTimeMillis();
//        URL url = new URL("http://apis.data.go.kr/B551011/KorService/areaBasedList?numOfRows=12&pageNo=1&MobileOS=ETC&MobileApp=AppTest&ServiceKey=wPyfXtlpjWPlvMuZXuyMPllqhLKg48cLxkGvsv3svYHS7Fev4fxGpkm92qNeSEJLWEggs5e4LzSERsV7r9nDSw%3D%3D&listYN=Y&arrange=A&contentTypeId=&areaCode=&sigunguCode=&cat1=&cat2=&cat3=&_type=json");
//        HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
//        long endTime = System.currentTimeMillis();
//        
//        int statusCode = httpConn.getResponseCode();        
//        String pf = (statusCode == 200) ? "success" : "fail";
//        
//        System.out.println("1. connection " + pf + " in " + (endTime - startTime) + " millisecond");
//        System.out.println("2. Response code: " + statusCode);
//        
//        return httpConn;
//    }
// 
//    // get response code from HttpUrlConnection
//    private static int getResponseStatus() throws MalformedURLException, IOException {
//        
//        URL url = new URL("http://apis.data.go.kr/B551011/KorService/areaBasedList?numOfRows=12&pageNo=1&MobileOS=ETC&MobileApp=AppTest&ServiceKey=wPyfXtlpjWPlvMuZXuyMPllqhLKg48cLxkGvsv3svYHS7Fev4fxGpkm92qNeSEJLWEggs5e4LzSERsV7r9nDSw%3D%3D&listYN=Y&arrange=A&contentTypeId=&areaCode=&sigunguCode=&cat1=&cat2=&cat3=&_type=json");
//        HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();        
//        int responseCode = httpConn.getResponseCode();
//        
//        return responseCode;
//    }
// 
//    // handle JSON data and get JSON string
//    private static String getJsonObjectString(BufferedReader br)
//            throws MalformedURLException, IOException, ParseException {
// 
//        JSONParser jsonPar = new JSONParser();
//        JSONObject jsonObj = (JSONObject) jsonPar.parse(br);
// 
//        JSONObject outputJsonObj = new JSONObject();
//        outputJsonObj.put("status", jsonObj.get("status").toString());
//        outputJsonObj.put("data", ((JSONArray) jsonObj.get("data")).get(0));
//        outputJsonObj.put("message", jsonObj.get("message"));
// 
//        String outputString = outputJsonObj.toJSONString();
//        
//        return outputString;
//    }
//    
//    // get JSON string from json file
//    private static String getJsonObjectStringFromFile() throws MalformedURLException, IOException, ParseException {
//        System.out.println("\nRead from json file instead!!");
//        String currentPath = Paths.get(".").normalize().toString();            
//        FileReader fr = new FileReader(currentPath + ".\\employees.json");
//        BufferedReader br = new BufferedReader(fr);
//        
//        String outputString = getJsonObjectString(br);
//        
//        return outputString;
//    }
 
    // main method
	public List<String> InitAPI() throws IOException, ServletException
    {
		/*
		 * HttpURLConnection httpConn = testHttpUrlConnection(); int statusCode =
		 * getResponseStatus();
		 */
        
        URL url = new URL("http://apis.data.go.kr/B551011/KorService/areaBasedList?numOfRows=500&pageNo=1&MobileOS=ETC&MobileApp=AppTest&ServiceKey=wPyfXtlpjWPlvMuZXuyMPllqhLKg48cLxkGvsv3svYHS7Fev4fxGpkm92qNeSEJLWEggs5e4LzSERsV7r9nDSw%3D%3D&listYN=Y&arrange=A&contentTypeId=12&areaCode=&sigunguCode=&cat1=&cat2=&cat3=&_type=json");
        URLConnection conn =  url.openConnection();
        String res = null;
        
        Object Obj = null;
        JSONObject jsonObj = null;
        JSONParser jsonParser = new JSONParser();
        List<JSONObject> jsonArray = null;
        
        BufferedReader br;
        br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        
//        StringBuilder sb = new StringBuilder();
//        String line;
//        
//        while ((line = br.readLine().toString()) != null) {
//        	System.out.println(line.toString());
//            sb.append(line);
//        }
        
        res = br.readLine();
        
        try {
			jsonObj = (JSONObject) jsonParser.parse(res);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        JSONObject parse_response = (JSONObject) jsonObj.get("response"); 
        JSONObject parse_body = (JSONObject) parse_response.get("body");
        JSONObject parse_items = (JSONObject) parse_body.get("items");
        br.close();
        
        JSONArray parse_itemlist = (JSONArray) parse_items.get("item");
        JSONObject obj2 = (JSONObject) parse_itemlist.get(0);
        
        Set key = obj2.keySet();
        Iterator iter = key.iterator();

        List<String> list = new ArrayList<String>();
        for (int i=0; i< parse_itemlist.size(); i++) {
            list.add(  parse_itemlist.get(i).toString() );
        }
        	
        return list;
        
        
//        jsonArray = (List<JSONObject>) jsonParser.parse(sb);
       // System.out.println("sb.length()" +sb.getClass());
//        
        
//        jsonObj = (JSONObject) Obj;
//        System.out.println("jsonObj.size()" + jsonObj);
//        
//        Object jo = jsonObj.get("response");
//        
//        Obj = null;
//        jsonObj= null;
//        jsonObj = (JSONObject) jo;
//        jo = jsonObj.get("body");
//
//        Obj = null;
//        jsonObj= null;
//        jsonObj = (JSONObject) jo;
//        jo = jsonObj.get("items");
//        
//        Obj = null;
//        jsonObj= null;
//        jsonObj = (JSONObject) jo;
//        jo = jsonObj.get("item");
//        
//        
//        JSONArray jArr = (JSONArray) jo;
//        System.out.println("jArr.size()" + jArr);
        
        //List<String> list = new ObjectMapper().readValue(json, List.class);
        
        
//        for(int i = 0 ; i < jArr.size(); i++) {
//        	jobj = (JSONObject) jArr.get(i);
//        		System.out.println("jArr.get("+i+")" + jobj);
//        	}
//        
		/*
		 * if (statusCode == 200) { BufferedReader br = new BufferedReader(new
		 * InputStreamReader(httpConn.getInputStream())); res = getJsonObjectString(br);
		 * } else { res = getJsonObjectStringFromFile(); }
		 */
    }
 
}
