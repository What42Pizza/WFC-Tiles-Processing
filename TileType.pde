// Vars



PImage[] Textures;
TileType[] TileTypes;
int[] AllTileTypes;





public class TileType {
  
  
  
  // Vars
  
  Connection[] Connections;
  PImage Texture;
  String Name;
  
  
  
  // Constructors
  
  public TileType (int[] ConnectionIDs, PImage Texture, String Name) {
    Connections = new Connection [ConnectionIDs.length];
    for (int i = 0; i < ConnectionIDs.length; i ++) {
      Connections[i] = new Connection (ConnectionIDs[i]);
    }
    this.Texture = Texture;
    this.Name = Name;
  }
  
  public TileType (String[] ConnectionNames, PImage Texture, String Name) {
    Connections = new Connection [ConnectionNames.length];
    for (int i = 0; i < ConnectionNames.length; i ++) {
      Connections[i] = new Connection (ConnectionNames[i]);
    }
    this.Texture = Texture;
    this.Name = Name;
  }
  
  public TileType (Connection[] Connections, PImage Texture, String Name) {
    this.Connections = Connections;
    this.Texture = Texture;
    this.Name = Name;
  }
  
  
  
}
