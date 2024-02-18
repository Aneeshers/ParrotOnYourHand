
# Parrot on Your Hand 🦜👋⌚
*Ever imagine controlling your Parrot drone from just the gestures of your hand?*  
**Parrot on Your Hand is a Remote Controller for the Anafi Parrot Drone using Your Apple Watch.**

*A Stanford Treehacks 2024 🌳 Project!*

## Video Demonstration
[![Video Demonstration](https://s5.ezgif.com/tmp/ezgif-5-a21f821d22.gif)](https://youtu.be/ArSJQXZwJDI)
[YouTube Link](https://youtu.be/ArSJQXZwJDI)
## Implementation
- I use Core Motion from Apple WatchOS to derive and record hand gestures -- rotate right (across pitch axis) to move right, rotate left (across pitch axis) to move left, move hand up (rotate up on roll axis) to move the drone up. Tap the land button to land the drone.

- We then route these commands to Firebase using the low-level networking libraries from Apple Watch (note this was particularly difficult as Apple Watch supposedly no longer supports Firebase Realtime Database ([link to issue](https://firebase.google.com/docs/ios/learn-more))). We pilot our Parrot drone via the Olympe SDK -- which connects to our Firebase Realtime Database and listens to actions from the Apple Watch.

## Usage
1. Install Olympe ([link to original API reference](https://developer.parrot.com/docs/olympe/index.html))
2. Install Firebase_admin ([link to original tutorial](https://pypi.org/project/firebase-admin/))
3. Get the correct service account JSON file and change here:  
   ```python
   cred_path = ''
   databaseURL = ''
   ```
4. Connect the drone to the correct IP:  
   ```python
   DRONE_IP = "10.202.0.1"
   ```

5. You will need to connect your antenna to the node hosting the Olympe controller, as this connects to the Parrot drone while maintaining an internet connection to the Firebase server.

6. Then build and deploy the WatchOS application (note you cannot do this on a simulator as you need access to a gyroscope).

7. Then run `python3 firebaseDrone.py`
```

Replace `image-link-here`, `gif-link-here`, `video-link-here`, `issue-link-here`, `olympe-link-here`, and `firebase-admin-link-here` with the appropriate URLs and file paths. This version should provide a clearer layout for your project's README.
