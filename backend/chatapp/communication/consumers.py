from channels.generic.websocket import AsyncWebsocketConsumer
import json

class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.user_id=self.scope['url_route']['kwargs']['user']
        self.room_group_name=f"user_{self.user_id}"
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )
        await self.accept()
        print("connecction accepted")

    async def disconnect(self,close_code):
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )
        await self.close()

    async def receive(self, text_data=None, bytes_data=None):
        data=json.loads(text_data)
        to_user=data['to_user']
        room_group_name=f"user_{to_user}"
        await self.channel_layer.group_send(
            room_group_name,
            {
                'type':'sendMessage',
                'message':data['message'],
                'from_user':data['from_user'],
                'to_user':to_user

            }
        )
    
    async def sendMessage(self,event):
        print(event)
        await self.send(text_data=json.dumps(
            {
                "message": event['message'],
                "to_user": event['to_user'],
                "from_user": event['from_user'],
            }
        ))