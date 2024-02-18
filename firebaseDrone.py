import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import olympe
from olympe.messages.ardrone3.Piloting import TakeOff, moveBy, Landing
from olympe.messages.ardrone3.PilotingState import FlyingStateChanged

DRONE_IP = "10.202.0.1"
drone = olympe.Drone(DRONE_IP)

cred_path = 'watchdrone-dfe04-firebase-adminsdk-4hm2l-a0ec3ab47e.json'
cred = credentials.Certificate(cred_path)
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://watchdrone-dfe04-default-rtdb.firebaseio.com/'
})
action_ref = db.reference('action')

def control_drone(action, value):
    if action == "left":
        drone(moveBy(0, -value, 0, 0))
    elif action == "right":
        drone(moveBy(0, value, 0, 0))
    elif action == "up":
        drone(moveBy(0, 0, -value, 0))
    elif action == "down":
        drone(moveBy(0, 0, value, 0))
    elif action == "land":
        drone(Landing()).wait().success()

def listener(event):
    action_value = event.data["action"]
    action, value = action_value.split()
    value = float(value)
    print(f'Action: {action}, Value: {value}')
    control_drone(action, value)

if __name__ == "__main__":
    drone.connect()
    assert drone(TakeOff() >> FlyingStateChanged(state="hovering", _timeout=5)).wait().success()
    action_ref.listen(listener)
    input('Listening for changes. Press Enter to exit.\n')
    assert drone(Landing()).wait().success()
    drone.disconnect()
