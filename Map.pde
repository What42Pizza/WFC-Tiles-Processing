// Vars



int MapWidth;
int MapHeight;
int TileWidth;
int TileHeight;
int[][][] SPMap; // Superposition map

int SelectedX;
int SelectedY;





// Functions



void InitMaps() {
  
  TileWidth  = TileSetProp.getInt("tile width" );
  TileHeight = TileSetProp.getInt("tile height");
  MapWidth  = ceil ((float) width  / TileWidth );
  MapHeight = ceil ((float) height / TileHeight);
  SPMap = new int [MapWidth] [MapHeight] [TileTypes.length];
  
  //MapWidth  = 3;
  //MapHeight = 3;
  
  for (int y = 0; y < MapHeight; y ++) {
    for (int x = 0; x < MapWidth; x ++) {
      SPMap[x][y] = AllTileTypes.clone();
    }
  }
  
}
