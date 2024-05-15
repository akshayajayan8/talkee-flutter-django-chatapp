from rest_framework import serializers
from . models import *
class Userserializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=['phone','fname','lname','email','date_joined']