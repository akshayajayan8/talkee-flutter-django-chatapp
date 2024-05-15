from django.db import models

# Create your models here.
from datetime import date

class User(models.Model):
    phone=models.CharField(max_length=10,primary_key=True)
    fname=models.CharField(max_length=20)
    lname=models.CharField(max_length=20)
    email=models.CharField(max_length=50)
    date_joined=models.DateField(default=date.today)
    friends=models.ManyToManyField('User')

    def __str__(self):
        return f"{self.fname} {self.lname}"
    
class FriendRequest(models.Model):
    from_user=models.ForeignKey(User,related_name='from_user',on_delete=models.CASCADE)
    to_user=models.ForeignKey(User,related_name='to_user',on_delete=models.CASCADE)
# Create your models here.