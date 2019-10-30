class Cascade {
  int start;
  int end;
  int current;

  int startShelvesBird = 10;
  int start4thFloorBird = 18;

  int currentTime = 0;
  int lastBirdTime = 0;
  int betweenBirdTime = 100;

  boolean startShelves = false;
  int currentShelf = 8;
  int betweenShelvesTime = 66;
  int lastShelfTime = 0;

  float MAX_TOUCH_INTERVAL = 4000;

  Cascade(int start, int totalBirds, float touchInterval) {
    this.start = start;

    float maxTouch = (totalBirds - start)/(float)totalBirds * MAX_TOUCH_INTERVAL;

    if (touchInterval > maxTouch)
      end = totalBirds - 1;
    else {
      int remaining = totalBirds - start - 1;
      end = (int) (start + touchInterval/maxTouch * remaining);
    }

    current = start;
    currentShelf = 8;
  }

  boolean run(ArrayList<Bird> birds, int numBirds) {
    if (current <= end && current < numBirds) {

      currentTime = millis();

      if (currentTime - lastBirdTime > betweenBirdTime) {
        if (current == start)
          birds.get(current).lightIn(0.1);    // the first one fades in faster
        else
          birds.get(current).lightIn();
        current++;
        lastBirdTime = currentTime;

        if (current == startShelvesBird) {
          startShelves = true;
        }
        else if (current == start4thFloorBird && m_fg.time() > 20) {
          m_fg.jump(0);
          m_fg.play();
        }
      }

      if (startShelves && currentTime - lastShelfTime > betweenShelvesTime) {
        if (currentShelf >= 0) {
          for (House h : shelves.getHousesByRow(currentShelf)) {
            if (random(2) > 1)
              h.lightIn();
          }
          lastShelfTime = currentTime;
          currentShelf--;
        }
      }

      return true;
    }
    return false;
  }
}
