from django.contrib import admin
from . models import *

# Register your models here.
# Register your models here.
model_list=[Task,Requirement,Project]
admin.site.register(model_list)