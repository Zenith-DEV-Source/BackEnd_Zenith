from django.db import models
from school.models import School
from user.models import User, Employee

# Create your models here.
''' En este apartado entra:
    Bank Accounts
    Payments
    Payment History
    Contract History
'''

class Paymenthistory(models.Model):
    idpaymenthistory = models.IntegerField(db_column='idPaymentHistory', primary_key=True)  
    idpaymentsfk = models.ForeignKey('Payments', models.DO_oNOTHING, db_column='idPaymentsFK')  
    updatedate = models.DateField(db_column='updateDate')
    previousstate = models.CharField(db_column='previousState', max_length=45)
    currentstate = models.CharField(db_column='currentState', max_length=45)
    comments = models.CharField(max_length=45)
    idschoolfk = models.ForeignKey('School', models.DO_NOTHING, db_column='idSchoolFK')

    class Meta:
        managed = False
        db_table = 'PaymentHistory'


class Payments(models.Model):
    idpayments = models.IntegerField(db_column='idPayments', primary_key=True)
    idschoolfk = models.ForeignKey(School, models.DO_NOTHING, db_column='idSchoolFK')
    idbankaccounts = models.ForeignKey('Bankaccounts', models.DO_NOTHING, db_column='idBankAccounts')
    datepayment = models.DateField(db_column='datePayment')
    amountpayment = models.IntegerField(db_column='amountPayment')
    conceptpayment = models.CharField(db_column='conceptPayment', max_length=45)
    statepayment = models.CharField(db_column='statePayment', max_length=10)

    class Meta:
        managed = False
        db_table = 'Payments'


class Bankaccounts(models.Model):
    idbankaccounts = models.IntegerField(db_column='idBankAccounts', primary_key=True)
    idusersfk = models.ForeignKey(User, models.DO_NOTHING, db_column='idUsersFK')
    accountholder = models.CharField(db_column='accountHolder', max_length=45)
    numaccount = models.IntegerField(db_column='numAccount')
    bank = models.CharField(max_length=45)
    typeaccount = models.CharField(db_column='typeAccount', max_length=45)

    class Meta:
        managed = False
        db_table = 'BankAccounts'


class Contracthistory(models.Model):
    idcontracthistory = models.IntegerField(db_column='idContractHistory', primary_key=True)
    salary = models.IntegerField()
    workinghours = models.IntegerField(db_column='workingHours')
    contractstatus = models.CharField(db_column='contractStatus', max_length=15)
    comments = models.CharField(max_length=45)
    enddate = models.DateField(db_column='endDate')
    contractdate = models.DateField(db_column='contractDate')
    idschoolfk = models.ForeignKey(School, models.DO_NOTHING, db_column='idSchoolFK')
    employee_iduser = models.ForeignKey(Employee, models.DO_NOTHING, db_column='Employee_idUser')
    hoursworked = models.CharField(db_column='hoursWorked', max_length=45)

    class Meta:
        managed = False
        db_table = 'ContractHistory'
