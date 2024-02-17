import asyncio
import websockets

async def echo(websocket, path):
    async for message in websocket:
        print(f"Received message: {message}")
        await websocket.send(f"Echo: {message}")

async def start_server():
    async with websockets.serve(echo, "localhost", 12345):
        await asyncio.Future()  # Run forever

if __name__ == "__main__":
    print("Starting server")
    asyncio.run(start_server())
