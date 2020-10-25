// Functions



void Load() {
  
  TileSetProp = loadJSONObject ("Tile Set/Properties.txt");
  
  LoadTextures();
  
  SelectedTexture = loadImage ("Selected.png");
  
}





void LoadTextures () {
  
  File FullDirectory = new File (dataPath("") + "/Tile Set/Textures");
  String[] TextureNames = FullDirectory.list();
  Textures = new PImage [TextureNames.length];
  
  for (int i = 0; i < TextureNames.length; i ++) {
    try {
      String PathName = dataPath("") + "/Tile Set/Textures/" + TextureNames[i];
      Textures[i] = loadImage (PathName);
    } catch (Exception e){}
  }
  
  ArrayList <TileType> NewTileTypes = new ArrayList <TileType> ();
  for (int i = 0; i < TextureNames.length; i ++) {
    String Name = TextureNames[i];
    String[] NameSegments = Name.split("_");
    if (NameSegments[0].equals("Tile")) {
      if (NameSegments.length == 2) NameSegments[1] = NameSegments[1].substring(0, NameSegments[1].length() - 4);
      String[] ConnectionsData = NameSegments[1].split("-");
      if (ConnectionsData == null || ConnectionsData.length != 4) continue;
      NewTileTypes.add (new TileType (ConnectionsData, Textures[i], Name));
    }
  }
  
  TileTypes = new TileType [NewTileTypes.size()];
  AllTileTypes = new int [NewTileTypes.size()];
  for (int i = 0; i < TileTypes.length; i ++) {
    TileTypes[i] = NewTileTypes.get(i);
    AllTileTypes[i] = i;
  }
  
}
