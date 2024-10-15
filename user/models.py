from django.db import models

# Create your models here.
''' En este apartado entra:
    User
    Employee
    Student
    Legalguardian
    Teacher
'''

class Employee(models.Model):
    iduser = models.OneToOneField('User', models.DO_NOTHING, db_column='idUser', primary_key=True)  
    position_employee = models.CharField(max_length=45)

    class Meta:
        managed = False
        db_table = 'Employee'


class Legalguardian(models.Model):
    idlegalguardian = models.IntegerField(db_column='idLegalGuardian', primary_key=True)  
    studentrelationship = models.CharField(db_column='studentRelationship', max_length=45)  
    adresslegal = models.CharField(db_column='adressLegal', max_length=45)  
    phonelegal = models.IntegerField(db_column='phoneLegal')  
    dnilegal = models.CharField(db_column='dniLegal', max_length=15)  
    student_iduser = models.ForeignKey('Student', models.DO_NOTHING, db_column='Student_idUser')  

    class Meta:
        managed = False
        db_table = 'LegalGuardian'


class Student(models.Model):
    iduser = models.OneToOneField('User', models.DO_NOTHING, db_column='idUser', primary_key=True)  
    dnistudent = models.CharField(db_column='dniStudent', max_length=10, blank=True, null=True)  
    phonestudent = models.IntegerField(db_column='phoneStudent', blank=True, null=True)  
    dateregistrationstudent = models.DateField(db_column='dateRegistrationStudent')  
    birthdaystudent = models.DateField(db_column='birthdayStudent')  
    adressstudent = models.CharField(db_column='adressStudent', max_length=45)  
    idclassefk = models.ForeignKey('Classe', models.DO_NOTHING, db_column='idClasseFK')  
    socialnumber = models.CharField(db_column='socialNumber', max_length=14)  

    class Meta:
        managed = False
        db_table = 'Student'


class Teacher(models.Model):
    iduser = models.OneToOneField('User', models.DO_NOTHING, db_column='idUser', primary_key=True)  
    degree = models.CharField(max_length=45)

    class Meta:
        managed = False
        db_table = 'Teacher'


class User(models.Model):
    iduser = models.IntegerField(db_column='idUser', primary_key=True)  
    nameuser = models.CharField(db_column='nameUser', max_length=15)  
    surnamesuser = models.CharField(db_column='surnamesUser', max_length=45)  
    emailuser = models.CharField(db_column='emailUser', max_length=45)  
    passworduser = models.CharField(db_column='passwordUser', max_length=30)  
    roluser = models.CharField(db_column='rolUser', max_length=13)  
    statususer = models.CharField(db_column='statusUser', max_length=1)  
    dateusercreated = models.DateTimeField(db_column='dateUserCreated')  
    lastloginuser = models.DateTimeField(db_column='lastLoginUser')  
    idschoolfk = models.ForeignKey('School', models.DO_NOTHING, db_column='idSchoolFK')  

    class Meta:
        managed = False
        db_table = 'User'
