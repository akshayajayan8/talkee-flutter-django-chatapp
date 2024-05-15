from django.urls import path , include
from communication.consumers import ChatConsumer

# Here, "" is routing to the URL ChatConsumer which 
# will handle the chat functionality.
websocket_urlpatterns = [
    path("ws/<str:user>/" , ChatConsumer.as_asgi()) , 
] 