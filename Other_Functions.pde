// Functions



int ChooseRandom (int[] ListIn) {
  return ListIn [(int) random (ListIn.length)];
}



void AddCoordsToList (IntList ListIn, int XPos, int YPos) {
  ListIn.append(XPos);
  ListIn.append(YPos);
}



void AddCoordsToList (IntList ListIn, int XPos, int YPos, boolean[][] AlreadyFilled) {
  if (AlreadyFilled[XPos][YPos]) return;
  ListIn.append(XPos);
  ListIn.append(YPos);
  AlreadyFilled [XPos] [YPos] = true;
}



IntList Convert (int[] ArrayIn) {
  IntList Output = new IntList();
  for (int I : ArrayIn) {
    Output.append(I);
  }
  return Output;
}



int[] Convert (IntList ListIn) {
  int[] Output = new int [ListIn.size()];
  for (int i = 0; i < Output.length; i ++) {
    Output[i] = ListIn.get(i);
  }
  return Output;
}



/*
boolean ArraysAreEqual (int[] Array1, int[] Array2) { // This code isn't used becuase you can just do Arrays.equals()
  if (Array1.length != Array2.length) return false;
  for (int i = 0; i < Array1.length; i ++) {
    if (Array1[i] != Array2[i]) return false;
  }
  return true;
}
*/
