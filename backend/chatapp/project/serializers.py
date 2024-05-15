from rest_framework import serializers
from . models import *



class Projectserializer (serializers.ModelSerializer):
    # members=serializers.ListField(child=serializers.IntegerField())
    class Meta:
        model=Project
        fields=['pid','pname','deadline','info','admin']


        # def create(self, validated_data):
        # members_data = validated_data.pop('members', [])  # Extract members list
        # project = Project.objects.create(**validated_data)  # Create Project instance


class Requirementserializer(serializers.ModelSerializer):
    class Meta:
        model=Requirement
        fields=['rid','proid','description']

class Taskserializer(serializers.ModelSerializer):
    class Meta:
        model=Task
        fields=['taskid','projectid','reqid','task','deadline','updated_time','status','assign_to']