import java.util.Date;

ArrayList<File> allFiles ;
ArrayList<PImage> allImages = new ArrayList<PImage>() ;
PImage img;
float[][] distances;
float maxDistance;
int spacer;
int nbImages;
int fontSize;
float imgW;

void setup() {
  
  size(4000, 4000);


  // Using just the path of this sketch to demonstrate,
  // but you can list any directory you like.
  String path = "/Users/Océane/Documents/Processing/rythm/data/";



  //println("\nListing info about all files in a directory and all subdirectories: ");
  allFiles = listFilesRecursive(path);
 


  
  maxDistance = dist(width, height, width, height);
  distances = new float[width][height];
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      float distance = dist(width, height, x, y);
      distances[x][y] = distance/maxDistance * 255;
    }
  }
  
  for (int x = 1; x < allFiles.size()-1; x++) {
       PImage img = loadImage(allFiles.get(x).getAbsolutePath());
       allImages.add(img);
    }
  
  fontSize = 100;

  noLoop();
  
  
  
}


// Nothing is drawn in this program and the draw() doesn't loop because
// of the noLoop() in setup()


void draw() {
nbImages = allFiles.size();
 background(255);
  // This embedded loop skips over values in the arrays based on
  // the spacer variable, so there are more values in the array
  // than are drawn here. Change the value of the spacer variable
  // to change the density of the points
  for (int y = 0; y < height-400; y += fontSize*1.20) {
    for (int x = 200; x < width-300; x += imgW) {
       img = allImages.get(int(random(0, allImages.size()-1)));
       imgW = img.width*fontSize/img.height;
       image(img, x, y + fontSize, imgW, fontSize);
    }
  }
  
  //sauvegarder le rendu
  save("rythm_"+year()+month()+day()+"-"+hour()+minute()+second()+".png");
  println("Finished.");
}






// Function to get a list of all files in a directory and all subdirectories
ArrayList<File> listFilesRecursive(String dir) {
  ArrayList<File> fileList = new ArrayList<File>(); 
  recurseDir(fileList, dir);
  return fileList;
}




// Recursive function to traverse subdirectories
void recurseDir(ArrayList<File> a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } else {
    a.add(file);
  }
}
