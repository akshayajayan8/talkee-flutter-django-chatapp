from django.urls import path
from . import views
urlpatterns = [
    path('register/',views.register),
    path('sendotp/',views.sendotp),
    path('userauth/',views.userauth)

]