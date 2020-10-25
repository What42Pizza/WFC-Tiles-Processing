// Functions



import java.util.Arrays;





boolean Done = false;
boolean Errored = false;

long Averages_TimeForPropagate = 0;
long Averages_TimeForSelecting = 0;
int  Averages_PropagateCount = 0;
int  Averages_SelectingCount = 0;

void CollapseSelected() { // ------------------------------------------------------------------------------ Working
  if (Done) return;
  
  int[] AllowedTiles = SPMap [SelectedX] [SelectedY];
  int CollapsedTile = ChooseRandom (AllowedTiles);
  SPMap [SelectedX] [SelectedY] = new int[] {CollapsedTile};
  
  long StartNano;
  
  StartNano = System.nanoTime();
  PropagateConstraints (SelectedX, SelectedY);
  Averages_TimeForPropagate += System.nanoTime() - StartNano;
  
  StartNano = System.nanoTime();
  SelectLowestEntropy();
  Averages_TimeForSelecting += System.nanoTime() - StartNano;
  
  Averages_PropagateCount ++;
  Averages_SelectingCount ++;
  
  println();
  println ("Time for propagate: " + (Averages_TimeForPropagate / Averages_PropagateCount));
  println ("Time for selecting: " + (Averages_TimeForSelecting / Averages_SelectingCount));
  
}





int[] GetAllowedTiles (int XPos, int YPos) { // ----------------------------------------------------------- Working
  return GetAllowedTiles (XPos, YPos, SPMap [XPos] [YPos]);
}



int[] GetAllowedTiles (int XPos, int YPos, int[] TilesIn) {
  
  IntList AllowedTiles = Convert (TilesIn);
  
  if (YPos > 0 && SPMap[XPos][YPos-1].length != AllTileTypes.length) {
    ArrayList <Connection> AllowedConnections = GetAllowedConnections (XPos, YPos - 1, 1); // Top
    RemoveTilesNotAllowed (AllowedTiles, AllowedConnections, 0);
  }
  
  if (YPos < MapHeight - 1 && SPMap[XPos][YPos+1].length != AllTileTypes.length) {
    ArrayList <Connection> AllowedConnections = GetAllowedConnections (XPos, YPos + 1, 0); // Bottom
    RemoveTilesNotAllowed (AllowedTiles, AllowedConnections, 1);
  }
  
  if (XPos > 0 && SPMap[XPos-1][YPos].length != AllTileTypes.length) {
    ArrayList <Connection> AllowedConnections = GetAllowedConnections (XPos - 1, YPos, 3); // Left
    RemoveTilesNotAllowed (AllowedTiles, AllowedConnections, 2);
  }
  
  if (XPos < MapWidth - 1 && SPMap[XPos+1][YPos].length != AllTileTypes.length) {
    ArrayList <Connection> AllowedConnections = GetAllowedConnections (XPos + 1, YPos, 2); // Right
    RemoveTilesNotAllowed (AllowedTiles, AllowedConnections, 3);
  }
  
  return Convert (AllowedTiles);
  
}



ArrayList <Connection> GetAllowedConnections (int XPos, int YPos, int Side) { // ---------------------------------------------- Working
  ArrayList <Connection> AllowedConnections = new ArrayList <Connection> ();
  int[] ConstrTiles = SPMap [XPos] [YPos];
  for (int Tile : ConstrTiles) {
    Connection TileConnection = TileTypes[Tile].Connections[Side];
    if (!ListContainsConnection (AllowedConnections, TileConnection)) {
      AllowedConnections.add (TileConnection);
    }
  }
  return AllowedConnections;
}



void RemoveTilesNotAllowed (IntList AllowedTiles, ArrayList <Connection> AllowedConnections, int Side) { // ------------------- Working
  for (int i = AllowedTiles.size() - 1; i >= 0; i --) {
    if (!ListContainsConnection (AllowedConnections, TileTypes[AllowedTiles.get(i)].Connections[Side])) {
      AllowedTiles.remove (i);
    }
  }
}



boolean ListContainsConnection (ArrayList <Connection> ListIn, Connection ConnIn) {
  for (Connection C : ListIn) {
    if (C.ConnectionID == ConnIn.ConnectionID) return true;
  }
  return false;
}





void PropagateConstraints (int StartXPos, int StartYPos) { // ----------------------------------------------------------------- Working
  
  IntList SlotsToCheck = new IntList();
  boolean[][] AlreadyAddedSlots = new boolean [MapWidth] [MapHeight];
  if (StartXPos > 0            ) AddCoordsToList (SlotsToCheck, StartXPos - 1, StartYPos    , AlreadyAddedSlots); // Don't look at the slot at (StartX, StartY), but look at all its neighbors
  if (StartYPos > 0            ) AddCoordsToList (SlotsToCheck, StartXPos    , StartYPos - 1, AlreadyAddedSlots);
  if (StartXPos < MapWidth  - 1) AddCoordsToList (SlotsToCheck, StartXPos + 1, StartYPos    , AlreadyAddedSlots);
  if (StartYPos < MapHeight - 1) AddCoordsToList (SlotsToCheck, StartXPos    , StartYPos + 1, AlreadyAddedSlots);
  
  while (SlotsToCheck.size() > 0) {
    if (SlotsToCheck.size() > 1000) {println ("Error in PropagateConstraints: SlotsToCheck has become too large (greater than 100)."); return;}
    
    /*
    println ();
    println ("spots to check:");
    for (int i = 0; i < SlotsToCheck.size()/2; i ++) {
      println ("     " + SlotsToCheck.get(i*2) + " " + SlotsToCheck.get(i*2+1));
    }
    */
    
    int XPos = SlotsToCheck.get(0); // Take a slot to check
    int YPos = SlotsToCheck.get(1);
    SlotsToCheck.remove(0);
    SlotsToCheck.remove(0);
    AlreadyAddedSlots [XPos] [YPos] = false;
    
    //println ("constraining " + XPos + " " + YPos);
    
    int[] SlotTiles = SPMap [XPos] [YPos]; // Get its prev allowed tiles
    
    if (SlotTiles.length == 1) continue;   // Skip if this slot is already done
    
    if (SlotTiles.length == 0) {
      println ("Error in PropagateConstrains(): Slot at " + XPos + " " + YPos + " has an entropy of 0.");
      Errored = true;
      return;
    }
    
    int[] AllowedTiles = GetAllowedTiles (XPos, YPos, SlotTiles); // Get new allowed tiles
    
    if (Arrays.equals(SlotTiles, AllowedTiles)) continue; // Skip if nothing changes
    
    SPMap [XPos] [YPos] = AllowedTiles;                   // Update slot in map
    
    if (XPos > 0            ) AddCoordsToList (SlotsToCheck, XPos - 1, YPos    , AlreadyAddedSlots); // Continue to all neighbors
    if (YPos > 0            ) AddCoordsToList (SlotsToCheck, XPos    , YPos - 1, AlreadyAddedSlots);
    if (XPos < MapWidth  - 1) AddCoordsToList (SlotsToCheck, XPos + 1, YPos    , AlreadyAddedSlots);
    if (YPos < MapHeight - 1) AddCoordsToList (SlotsToCheck, XPos    , YPos + 1, AlreadyAddedSlots);
    
  }
  
}





void SelectLowestEntropy() {
  
  int LowestScore = TileTypes.length;
  IntList LowestSlots = new IntList();
  
  for (int YPos = 0; YPos < MapHeight; YPos ++) {
    for (int XPos = 0; XPos < MapWidth; XPos ++) {
      int[] SlotTiles = SPMap [XPos] [YPos];
      int Entropy = SlotTiles.length;
      if (Entropy <= 1 || Entropy > LowestScore) continue;
      if (Entropy == LowestScore) AddCoordsToList (LowestSlots, XPos, YPos);
      if (Entropy < LowestScore) {
        LowestSlots = new IntList (XPos, YPos);
        LowestScore = Entropy;
      }
    }
  }
  
  if (LowestSlots.size() == 0) {
    Done = true;
    return;
  }
  
  int ChosenSlot = (int) random (LowestSlots.size() / 2);
  SelectedX = LowestSlots.get(ChosenSlot * 2    );
  SelectedY = LowestSlots.get(ChosenSlot * 2 + 1);
  
}
