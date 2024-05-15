
from rest_framework.response import Response
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser
#from rest_framework import viewsets
from user.serializers import Userserializer
from .helpers import send_otp_phone
from . models import *
from user.models import User
# Create your views here.


@api_view(['POST'])
@csrf_exempt
def sendotp(request):
    if request.method=='POST':
        phone=request.data['phone']
        print(request.data)
        print(phone)
        otp=send_otp_phone(phone)
        UserAuth.objects.update_or_create(phone=phone,defaults={'otp':otp})
        if otp!=None :
            return Response(status=201)
        else:
            return Response(status=400)
        

def get_user(phone):
    check=User.objects.filter(phone=phone).exists()
    print(check)
    if(check):
        queryset=User.objects.filter(phone=phone).all()
        serializer=Userserializer(queryset,many=True)
        data=serializer.data
        print(queryset)
        print(data)
        #user already registered
        return data
    else:
        print("user not registered")
        return None

@api_view(['POST'])
@csrf_exempt
def userauth(request):
    phone=request.data['phone']
    rec_otp=request.data['otp']
    user=UserAuth.objects.get(phone=phone)
    if(rec_otp==user.otp):
        user.delete()
        data=get_user(phone)
        if(data is not None):
            #user already registered
            return Response(data,status=201)
        else:
                print("user not registered")
                return Response("user not registered",status=202)
    else:
        return Response("Otp does not match",status=400)


                


    

       


@api_view(['POST'])
@csrf_exempt
def register(request):
    if request.method=='POST':
       
        data=JSONParser().parse(request)
        phone=data['phone']
        print(data)
        serializer=Userserializer(data=data)
        if serializer.is_valid():
            serializer.save()
            data=get_user(phone)
            return Response(data,status=201)
        else:
            print(serializer.is_valid)
            print(serializer.errors)
            return Response(serializer.errors,status=400)
        