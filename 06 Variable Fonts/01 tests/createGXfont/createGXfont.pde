//BauhausManifestGX.ttf


// Open a file and read its binary data 
byte b[]; 
 void setup() {
  // Print each value, from 0 to 255 
   b  = loadBytes("BauhausManifestGX.ttf");
  String a = "";
  for (int i = 0; i < b.length; i++) { 
    // Every tenth number, start a new line 
    if ((i % 10) == 0) { 
      println(); 
    } 
    // bytes are from -128 to 127, this converts to 0 to 255 
    a = a + (b[i] & 0xff); 
//    print(unhex(a) + " "); 
  } 
  // Print a blank line at the end 
  println(); 
  
  StringToHex strToHex = new StringToHex();
  println("\n***** Convert ASCII to Hex *****");
  String str = "I Love Java!";  
  //println("Original input : " + a);
    
  String hex = strToHex.convertStringToHex(a);
    
  println("Hex : " + hex);
    
  println("\n***** Convert Hex to ASCII *****");
  println("Hex : " + hex);
  //println("ASCII : " + strToHex.convertHexToString(a));
  saveStrings("a.txt", strToHex.convertHexToStringList(a).array());
 }
 
 void draw() {
 }
 
 
 public class StringToHex{
 
  public String convertStringToHex(String str){
    
    char[] chars = str.toCharArray();
    
    StringBuffer hex = new StringBuffer();
    for(int i = 0; i < chars.length; i++){
      hex.append(Integer.toHexString((int)chars[i]));
    }
    
    return hex.toString();
  }
  
  public String convertHexToString(String hex){

    StringBuilder sb = new StringBuilder();
    StringBuilder temp = new StringBuilder();
    
    //49204c6f7665204a617661 split into two characters 49, 20, 4c...
    for( int i=0; i<hex.length()-1; i+=2 ){
      
        //grab the hex in pairs
        String output = hex.substring(i, (i + 2));
        //convert hex to decimal
        int decimal = Integer.parseInt(output, 16);
        //convert the decimal to character
        sb.append((char)decimal);
      
        temp.append(decimal);
    }
    System.out.println("Decimal : " + temp.toString());
    
    return sb.toString();
  }
  
  public StringList convertHexToStringList(String hex){

    StringList sb = new StringList();
    StringList temp = new StringList();
    
    //49204c6f7665204a617661 split into two characters 49, 20, 4c...
    for( int i=0; i<hex.length()-1; i+=2 ){
      
        //grab the hex in pairs
        String output = hex.substring(i, (i + 2));
        //convert hex to decimal
        int decimal = Integer.parseInt(output, 16);
        //convert the decimal to character
        sb.append((char)decimal+"");
      
        temp.append(decimal+"");
    }
    System.out.println("Decimal : " + temp.toString());
    
    return sb;
  }
}
