// Started 10/21/20
// Last updated 10/26/20





// Vars

JSONObject TileSetProp;
PImage SelectedTexture;










void setup() {
  
  
  
  // Basic setup
  
  fullScreen();
  //size (512, 512);
  background (255);
  frameRate (60);
  
  
  
  // Init
  
  Load();
  InitMaps();
  
  SelectedX = (int) random (MapWidth );
  SelectedY = (int) random (MapHeight);
  
  /*
  for (int i = 0; i < TileTypes.length; i ++) {
    println (i + ": " + TileTypes[i].Name);
  }
  */
  
  
  
  /*
  SPMap [0] [0] = new int[] {10, 20, 30}; // Expected output: 3, 2
  ArrayList <Connection> AllowedConnections = GetAllowedConnections (0, 0, 2); // -------------- GetAllowedConnection() works
  for (Connection C : AllowedConnections) {
    println (ConnectionNames.get(C.ConnectionID));
  }
  //*/
  
  
  
  /*
  SPMap [1] [1] = new int[] {0}; // Expended output: anything that has 0 as the second (bottom) side
  println();
  println ("1, 1:");
  println (TileTypes[SPMap [1] [1] [0]].Name); // --------------------------------------------------------- GetAllowedTiles() works
  int[] AllowedTiles = GetAllowedTiles (1, 0);
  println();
  for (int I : AllowedTiles) {
    println (TileTypes[I].Name);
  }
  //*/
  
  
  
  /*
  IntList TestTiles = new IntList (10, 20, 30); // Expected output: 0-3-3-0, 3-1-3-1
  ArrayList <Connection> AllowedConnections = new ArrayList <Connection> (); // ---------------- RemoveTilesNotAllowed() works
  AllowedConnections.add (new Connection ("3"));
  RemoveTilesNotAllowed (TestTiles, AllowedConnections, 2);
  for (int I : TestTiles) {
    println (TileTypes[I].Name);
  }
  //*/
  
  
  
  /*
  SelectedX = 1;
  SelectedY = 1;
  CollapseSelected();
  
  println();
  println();
  println();
  for (int y = 0; y < 3; y ++) {
    for (int x = 0; x < 3; x ++) {
      //if ((x == 0 && y == 0) || (x == 2 && y == 0) || (x == 0 && y == 2) || (x == 2 && y == 2)) continue; // --------------------- CollapseSelected() works!
      int[] Tiles = SPMap [x] [y];
      println();
      println(x + " " + y);
      println("length: " + Tiles.length);
      if (Tiles.length == 34) continue;
      for (int I : Tiles) {
        println (TileTypes[I].Name);
      }
    }
  }
  //*/
  
  
  
}










int Count = 0;

int LastDrawnTile = 0;

void draw() {
  
  //IntList NewTiles = new IntList(); // This is to draw only the new tiles that are collapsed, but it doesn't work because sometimes a tile that isn't selected is fully collapsed by PropagateContraints()
  
  long StartMillis = millis();
  while (!Errored && millis() - StartMillis < 1000 / (frameRate + 10)) {
    if (Count < MapWidth * MapHeight) {
      //println ("Collapsing " + SelectedX + " " + SelectedY + ", count: " + Count);
      //AddCoordsToList (NewTiles, SelectedX, SelectedY);
      CollapseSelected();
      if (Done) Count += 1000000000;
      Count ++;
    }
  }
  
  for (int i = LastDrawnTile; i < CollapsedTiles.size(); i += 2) {
    int TileX = CollapsedTiles.get(i    );
    int TileY = CollapsedTiles.get(i + 1);
    int[] Tile = SPMap [TileX] [TileY];
    image (TileTypes[Tile[0]].Texture, TileX * TileWidth, TileY * TileHeight);
  }
  LastDrawnTile = CollapsedTiles.size();
  
  /*
  for (int i = 0; i < NewTiles.size(); i += 2) {
    int TileX = NewTiles.get(i    );
    int TileY = NewTiles.get(i + 1);
    int[] Tile = SPMap [TileX] [TileY];
    image (TileTypes[Tile[0]].Texture, TileX * TileWidth, TileY * TileHeight);
  }
  //*/
  
  /*
  for (int YPos = 0; YPos < MapHeight; YPos ++) {
    for (int XPos = 0; XPos < MapWidth; XPos ++) {
      int[] SlotTiles = SPMap [XPos] [YPos];
      if (SlotTiles.length != 1) continue;
      image (TileTypes[SlotTiles[0]].Texture, XPos * TileWidth, YPos * TileHeight);
    }
  }
  //*/
  
}
