from django.db import models
from user.models import Student
from school.models import School
from user.models import User

# Create your models here.
''' En este apartado entra:
    Scholarchip
    Student Has Scholarchip
    Subsidies
    Subsidies Has User
'''

class Scholarchip(models.Model):
    idscholarchip = models.IntegerField(db_column='idScholarchip', primary_key=True)  
    typescholarchip = models.CharField(db_column='typeScholarchip', max_length=45)  
    amount = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True)
    description = models.CharField(max_length=45, blank=True, null=True)
    idschoolfk = models.ForeignKey('School', models.DO_NOTHING, db_column='idSchoolFK')  

    class Meta:
        managed = False
        db_table = 'Scholarchip'


class StudentHasScholarchip(models.Model):
    student_iduser = models.OneToOneField(Student, models.DO_NOTHING, db_column='Student_idUser', primary_key=True)
    scholarchip_idscholarchip = models.ForeignKey(Scholarchip, models.DO_NOTHING, db_column='Scholarchip_idScholarchip')  
    statusbeca = models.CharField(db_column='statusBeca', max_length=45)  

    class Meta:
        managed = False
        db_table = 'Student_has_Scholarchip'
        unique_together = (('student_iduser', 'scholarchip_idscholarchip'),)


class Subsidies(models.Model):
    idsubsidies = models.IntegerField(db_column='idSubsidies', primary_key=True)  
    typesubsidies = models.CharField(db_column='typeSubsidies', max_length=45)  

    class Meta:
        managed = False
        db_table = 'Subsidies'


class SubsidiesHasUser(models.Model):
    subsidies_idsubsidies = models.OneToOneField(Subsidies, models.DO_NOTHING, db_column='Subsidies_idSubsidies', primary_key=True)
    user_iduser = models.ForeignKey('User', models.DO_NOTHING, db_column='User_idUser')  

    class Meta:
        managed = False
        db_table = 'Subsidies_has_User'
        unique_together = (('subsidies_idsubsidies', 'user_iduser'),)
