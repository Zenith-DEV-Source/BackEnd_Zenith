from django.db import models
from user.models import User, Student, Teacher, Employee

# Create your models here.
''' En este apartado entra:
    School
    Grade
    Subject
    Assistance Student
    Classe
    Class Assignment
    Evaluations Students
    Events School
    Extra Activities
    Extra Activities Has Student
    Messages
    Schedule
    User Has Events School
'''

class Assistancestudent(models.Model):
    idassistancestudent = models.IntegerField(db_column='idAssistanceStudent', primary_key=True)  
    dateattendance = models.DateField(db_column='dateAttendance')  
    status = models.CharField(max_length=8)
    student_iduser = models.ForeignKey('Student', models.DO_NOTHING, db_column='Student_idUser')  
    subject_idsubject = models.ForeignKey('Subject', models.DO_NOTHING, db_column='Subject_idSubject')  

    class Meta:
        managed = False
        db_table = 'AssistanceStudent'


class Classassignment(models.Model):
    idclassassignment = models.IntegerField(db_column='idClassAssignment', primary_key=True)
    idclassefk = models.ForeignKey('Classe', models.DO_NOTHING, db_column='idClasseFK')  
    idsubjectfk = models.ForeignKey('Subject', models.DO_NOTHING, db_column='idSubjectFK')  
    timeclass = models.TimeField(db_column='timeClass')  
    teacher_iduser = models.ForeignKey('Teacher', models.DO_NOTHING, db_column='Teacher_idUser')  

    class Meta:
        managed = False
        db_table = 'ClassAssignment'
        unique_together = (('idclassassignment', 'teacher_iduser'),)


class Classe(models.Model):
    idclasses = models.IntegerField(db_column='idClasses', primary_key=True)  
    seccionclasse = models.CharField(db_column='seccionClasse', max_length=1)  
    idgradefk = models.ForeignKey('Grade', models.DO_NOTHING, db_column='idGradeFK')  
    teacher_iduser = models.ForeignKey(Teacher, models.DO_NOTHING, db_column='Teacher_idUser')  

    class Meta:
        managed = False
        db_table = 'Classe'


class Evaluationsstudents(models.Model):
    idevaluationsstudents = models.IntegerField(db_column='idEvaluationsStudents', primary_key=True)  
    idsubjectsfk = models.ForeignKey('Subject', models.DO_NOTHING, db_column='idSubjectsFK')  
    noteevaluation = models.DecimalField(db_column='noteEvaluation', max_digits=10, decimal_places=0)  
    comment = models.CharField(max_length=45)
    evaluationdate = models.DateField(db_column='evaluationDate')  
    typeevaluation = models.CharField(db_column='typeEvaluation', max_length=45)  
    student_iduser = models.ForeignKey(Student, models.DO_NOTHING, db_column='Student_idUser')  

    class Meta:
        managed = False
        db_table = 'EvaluationsStudents'


class Eventsschool(models.Model):
    ideventsschool = models.IntegerField(db_column='idEventsSchool', primary_key=True)  
    nameevent = models.CharField(db_column='nameEvent', max_length=45)  
    eventdescription = models.CharField(db_column='eventDescription', max_length=45)  
    dateevent = models.DateTimeField(db_column='dateEvent')  
    location = models.CharField(max_length=45)
    idschoolfk = models.ForeignKey('School', models.DO_NOTHING, db_column='idSchoolFK')  

    class Meta:
        managed = False
        db_table = 'EventsSchool'


class Extraactivities(models.Model):
    idextraactivities = models.IntegerField(db_column='idExtraActivities', primary_key=True)  
    nameactivity = models.CharField(db_column='nameActivity', max_length=45)  
    description = models.CharField(max_length=45)
    weekday = models.CharField(max_length=45)
    timeactivity = models.TimeField(db_column='timeActivity')  
    idschoolfk = models.ForeignKey('School', models.DO_NOTHING, db_column='idSchoolFK')  
    employee_iduser = models.ForeignKey(Employee, models.DO_NOTHING, db_column='Employee_idUser')   

    class Meta:
        managed = False
        db_table = 'ExtraActivities'
        
class ExtraactivitiesHasStudent(models.Model):
    extraactivities_idextraactivities = models.OneToOneField(Extraactivities, models.DO_NOTHING, db_column='ExtraActivities_idExtraActivities', primary_key=True)
    student_iduser = models.ForeignKey(Student, models.DO_NOTHING, db_column='Student_idUser')  

    class Meta:
        managed = False
        db_table = 'ExtraActivities_has_Student'
        unique_together = (('extraactivities_idextraactivities', 'student_iduser'),)


class Grade(models.Model):
    idgrade = models.IntegerField(db_column='idGrade', primary_key=True)  
    namegrade = models.CharField(db_column='nameGrade', max_length=45)  
    idschoolfk = models.ForeignKey('School', models.DO_NOTHING, db_column='idSchoolFK')  

    class Meta:
        managed = False
        db_table = 'Grade'


class Messages(models.Model):
    idissuerfk = models.OneToOneField(User, models.DO_NOTHING, db_column='idIssuerFK', primary_key=True)
    idreceiverfk = models.ForeignKey(User, models.DO_NOTHING, db_column='idReceiverFK', related_name='messages_idreceiverfk_set')  
    content = models.CharField(max_length=45)
    senddate = models.CharField(db_column='sendDate', max_length=45)  
    school_idschool = models.ForeignKey('School', models.DO_NOTHING, db_column='School_idSchool')  

    class Meta:
        managed = False
        db_table = 'Messages'
        unique_together = (('idissuerfk', 'idreceiverfk', 'school_idschool'),)


class Schedule(models.Model):
    idschedule = models.IntegerField(db_column='idSchedule', primary_key=True)  
    idclassesfk = models.ForeignKey('Classe', models.DO_NOTHING, db_column='idClassesFK')  
    weekday = models.CharField(max_length=10)
    start_time = models.TimeField()
    end_time = models.TimeField()

    class Meta:
        managed = False
        db_table = 'Schedule'


class School(models.Model):
    idschool = models.IntegerField(db_column='idSchool', primary_key=True)  
    nameschool = models.CharField(db_column='nameSchool', max_length=45)  
    adressschool = models.CharField(db_column='adressSchool', max_length=45)  
    phoneschool = models.CharField(db_column='phoneSchool', max_length=45)  
    emailschool = models.CharField(db_column='emailSchool', max_length=45)  
    typeschool = models.CharField(db_column='typeSchool', max_length=10)  

    class Meta:
        managed = False
        db_table = 'School'


class Subject(models.Model):
    idsubject = models.IntegerField(db_column='idSubject', primary_key=True)  
    namesubject = models.CharField(db_column='nameSubject', max_length=45)  
    description = models.CharField(max_length=45)
    idschoolfk = models.ForeignKey('School', models.DO_NOTHING, db_column='idSchoolFK')  

    class Meta:
        managed = False
        db_table = 'Subject'


class UserHasEventsschool(models.Model):
    user_iduser = models.OneToOneField(User, models.DO_NOTHING, db_column='User_idUser', primary_key=True)
    eventsschool_ideventsschool = models.ForeignKey(Eventsschool, models.DO_NOTHING, db_column='EventsSchool_idEventsSchool')  

    class Meta:
        managed = False
        db_table = 'User_has_EventsSchool'
        unique_together = (('user_iduser', 'eventsschool_ideventsschool'),)