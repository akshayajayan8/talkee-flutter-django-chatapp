from django.db import models

# Create your models here.
# Create your models here.
from datetime import date
from user.models import User
# Create your models here.


class Project(models.Model):
    pid=models.AutoField(primary_key=True)
    pname=models.CharField()
    info=models.CharField()
    deadline=models.DateField()
    admin=models.ForeignKey(User,related_name='admin',on_delete=models.CASCADE)
    members=models.ManyToManyField(User,related_name='members')

class Requirement(models.Model):
    proid=models.ForeignKey(Project,related_name='proid',on_delete=models.CASCADE)
    rid=models.AutoField(primary_key=True)
    description=models.CharField(max_length=100)

class Task(models.Model):
    taskid=models.AutoField(primary_key=True)
    projectid=models.ForeignKey(Project,related_name='projectid',on_delete=models.CASCADE)
    reqid=models.ForeignKey(Requirement,related_name='reqid',on_delete=models.CASCADE)
    assign_to=models.ForeignKey(User,related_name='assign_to',on_delete=models.CASCADE)
    task=models.CharField(max_length=100)
    deadline=models.CharField(max_length=50)
    updated_time=models.DateField(default=date.today)
    status=models.CharField(default="incomplete")