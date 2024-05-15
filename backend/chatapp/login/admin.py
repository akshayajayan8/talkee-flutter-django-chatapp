from django.contrib import admin

# Register your models here.
from .models import *

# Register your models here.
models_list=[UserAuth]
admin.site.register(models_list)