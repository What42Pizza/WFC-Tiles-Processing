// Vars



StringList ConnectionNames = new StringList();





// Functions



public class Connection {
  
  
  
  // Vars
  
  int ConnectionID;
  
  
  
  public Connection (int ConnectionID) {
    this.ConnectionID = ConnectionID;
  }
  
  public Connection (String ConnectionName) {
    
    boolean NameFound = false;
    for (int i = 0; i < ConnectionNames.size(); i ++) {
      if (ConnectionNames.get(i).equals(ConnectionName)) {
        ConnectionID = i;
        NameFound = true;
        break;
      }
    }
    
    if (!NameFound) {
      ConnectionNames.append (ConnectionName);
      ConnectionID = ConnectionNames.size() - 1;
    }
    
  }
  
  
  
}
