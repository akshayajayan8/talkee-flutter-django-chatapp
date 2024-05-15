

# Create your views here.
from rest_framework.response import Response
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser

from . serializers import Userserializer
from . models import *

@csrf_exempt
@api_view(['GET','POST'])
def create_friend_req(request):
    from_user_phone=request.data['from_user_phone']
    to_user_phone=request.data['to_user_phone']
    if(from_user_phone==to_user_phone):
        return Response("You are sending request yourself",status=400)

    else:
        
        from_user=User.objects.get(phone=from_user_phone)
        to_user=User.objects.get(phone=to_user_phone)
        FriendRequest.objects.update_or_create(from_user=from_user,to_user=to_user)
    return Response("Friend Request Sent",status=201)

@csrf_exempt
@api_view(['GET','POST'])
def accept_friend_req(request):
    from_user_phone=request.data['from_user_phone']
    to_user_phone=request.data['to_user_phone']
    acceptorreject=request.data['acceptorreject']
    from_user=User.objects.get(phone=from_user_phone)
    to_user=User.objects.get(phone=to_user_phone)
    if acceptorreject=="accept":
        to_user.friends.add(from_user)
        from_user.friends.add(to_user)
        freq=FriendRequest.objects.get(from_user=from_user_phone,to_user=to_user_phone).delete()
        freq.delete()
        ack="friend request accepted successfully"
    else:
        freq=FriendRequest.objects.get(from_user=from_user_phone,to_user=to_user_phone).delete()

        ack="friend request rejected"

    return Response(ack,status=201)

@csrf_exempt
@api_view(['GET','POST'])
def search_user(request):
    phone=request.data['phone']
    check=User.objects.filter(phone=phone).exists()
    if(check==True):
        queryset=User.objects.filter(phone=phone).all()
        serializer=Userserializer(queryset,many=True)
        return Response(serializer.data,status=201)
    else:
        print("user not found")
        return Response("user not found",status=404)


@csrf_exempt
@api_view(['GET','POST'])
def get_all_req(request):
    to_user=request.data['to_user']
    check=FriendRequest.objects.filter(to_user=to_user).exists()
    if(check==True):
        queryset=FriendRequest.objects.filter(to_user=to_user)
        friendReqs=[]
        for friendReq in queryset:
            friendReqs.append(friendReq.from_user)   
        print(queryset,friendReqs) 
        
        serializer=Userserializer(friendReqs,many=True)
        return Response(serializer.data,status=201)
    else:
        print("user not found")
        return Response("user not found",status=404)



@csrf_exempt
@api_view(['GET','POST'])
def get_friends(request):
    phone=request.data['phone']
    queryset=User.objects.get(phone=phone)
    print(queryset)
    friends=queryset.friends.all()
    if(friends is not None):

        serializer=Userserializer(friends,many=True)
        print(serializer.data)
        return Response(serializer.data,status=201)
    else:
        return Response("No Friends",status=400)