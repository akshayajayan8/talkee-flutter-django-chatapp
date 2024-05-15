
from datetime import date

# Create your views here.
from rest_framework.response import Response
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser
from rest_framework import status
from .models import * 
from . serializers import *
from . models import *

@csrf_exempt
@api_view(['POST'])
def  create_project(request):
    data=JSONParser().parse(request)
    members=data['members']
    serializer=Projectserializer(data=data)
    if serializer.is_valid():
        serializer.save()
        pid=serializer.data['pid']
        project=Project.objects.get(pid=pid)
        for memberphone in members:
            project.members.add(memberphone)
        return Response(pid,status=201)
    else:
        print('project cant be created')
        return Response(serializer.errors,status=400)

@csrf_exempt
@api_view(['POST'])
def create_requirement(request):

    data=request.data
    requirements=data['requirements']
    proid=data['proid']
    for requirement in requirements:
        serializer=Requirementserializer(data=requirement)
        if serializer.is_valid():
            serializer.save()
            print("succcess")
        else:
            print(serializer.errors)
            return Response(serializer.errors,status=400)
    
    requirements=Requirement.objects.filter(proid=proid)
    serializer=Requirementserializer(requirements,many=True)
    return Response(serializer.data,status=201)


@csrf_exempt
@api_view(['POST'])
def create_task(request):

    tasks=request.data
    print(tasks)
    for task in tasks:
        print(task)
        serializer=Taskserializer(data=task)
        if serializer.is_valid():
            serializer.save()
         

        else:
            print(serializer.errors)
            return Response(serializer.errors,status=400)
    return Response(serializer.data,status=201)

@csrf_exempt
@api_view(['POST'])
def get_project(request):

    phone=request.data['phone']
    check=Project.objects.filter(members=phone).exists()
    if(check):
        queryset=Project.objects.filter(members=phone)
        serializer=Projectserializer(queryset,many=True)
        return Response(serializer.data,status=201)
    else:
        print('project error')
        return Response("Something error occured",status=400)
    

@csrf_exempt
@api_view(['POST'])
def get_user_tasks(request):
    user=request.data['phone']
    projectid=request.data['projectid']
    queryset=Task.objects.filter(assign_to=user,projectid=projectid).all()
    serializer=Taskserializer(queryset,many=True)
    print(serializer.data)
    return Response(serializer.data,status=201)

    

@csrf_exempt
@api_view(['POST'])
def get_project_tasks(request):
    projectid=request.data['projectid']
    queryset=Task.objects.filter(projectid=projectid,status="completed").all()
    serializer=Taskserializer(queryset,many=True)
    print(serializer.data)
    return Response(serializer.data,status=201)
    
@csrf_exempt
@api_view(['POST'])
def update_tasks(request):
    taskid=request.data['taskid']
    task=Task.objects.get(taskid=taskid)
    task.status='completed'
    task.updated_time=date.today()
    task.save()
    return Response(status=201)

@csrf_exempt
@api_view(['POST'])
def get_count(request):
    projectid=request.data['projectid']
    count=Task.objects.filter(projectid=projectid).count()
    print(count)
    return Response(count,status=201)
    