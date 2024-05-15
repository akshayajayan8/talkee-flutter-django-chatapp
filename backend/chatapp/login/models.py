from django.db import models

# Create your models here.
class UserAuth(models.Model):
    phone=models.CharField(max_length=10,primary_key=True)
    otp=models.CharField(max_length=6,)
# Create your models here.
