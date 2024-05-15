from django.urls import path
from . import views


urlpatterns=[
        path('create_project/',views.create_project),
        path('create_requirement/',views.create_requirement),
        path('create_task/',views.create_task),
        path('get_project/',views.get_project),
        path('get_user_tasks/',views.get_user_tasks),
        path('update_tasks/',views.update_tasks),
        path('get_project_tasks/',views.get_project_tasks),
        path('get_count/',views.get_count),

]