from django.urls import path
from . import views
urlpatterns = [
    path('create_friend/',views.create_friend_req),
    path('accept_friend/',views.accept_friend_req),
    path('searchuser/',views.search_user),
    path('get_all_req/',views.get_all_req),
    path('get_friends/',views.get_friends)
]