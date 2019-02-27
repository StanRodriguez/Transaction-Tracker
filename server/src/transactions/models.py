from django.db import models
from django.conf import settings
from django.contrib.auth.models import AbstractUser
from datetime import date
from django.utils import timezone
# Create your models here.


class User(AbstractUser):
    balance = models.DecimalField(
        decimal_places=2, max_digits=22, default=0, blank=False, null=False)
    avatar = models.TextField()


class Transaction(models.Model):
    amount = models.DecimalField(
        decimal_places=2, max_digits=9, default=0, blank=False, null=False)
    TRANSACTION_TYPES = (
        ('IN', 'Income'),
        ('EX', 'Expense')
    )
    type = models.CharField(
        max_length=2, choices=TRANSACTION_TYPES, blank=False, null=False)
    description = models.CharField(max_length=70, blank=False, null=False)
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
    )
    comment = models.TextField()
    date = models.DateField(default=date.today)
    time = models.TimeField(default=timezone.now)


class Image(models.Model):
    image = models.TextField()
    transaction = models.ForeignKey(Transaction, on_delete=models.CASCADE,)
