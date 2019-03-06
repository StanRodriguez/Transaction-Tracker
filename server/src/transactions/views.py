from django.shortcuts import render
from django.http import HttpResponse, JsonResponse, HttpRequest
from transactions.models import User, Transaction
from django.core import serializers
from django.contrib.auth import authenticate
from django.db import IntegrityError
import json

# Create your views here.


def transactions_view(request, id=None):
    user = User.objects.get(id=id)
    transaction = list(user.transaction_set.order_by('-date', '-time').values(
        'id', 'amount', 'is_expense', 'comment', 'description', 'date', 'time'))
    return JsonResponse({'user': {'id': user.id, 'username': user.username, 'balance': user.balance}, 'transactions': transaction}, safe=False)


def transaction_delete(request, user_id, transaction_id):
    # if request.method == 'DELETE':
    #     pass
    try:
        user = User.objects.get(id=user_id)
        transaction = user.transaction_set.get(id=transaction_id)
        return JsonResponse(transaction.delete(), safe=False)
    except IntegrityError as e:
        return JsonResponse({"id": 0, "message": e.args}, safe=False)


def transaction_post(request, user_id):
    # if request.method == 'DELETE':
    #     pass

    if request.method == "POST":
        user = User.objects.get(id=user_id)
        data = json.loads(request.body)
        try:
            newTransaction = user.transaction_set.create(amount=data["amount"], is_expense=data["is_expense"], description=data[
                "description"], comment=data["comment"], date=data["date"], time=data["time"])
            if newTransaction:
                return JsonResponse({"id": newTransaction.id}, safe=False)
            else:
                return JsonResponse({"id": 0}, safe=False)
        except IntegrityError as e:
            return JsonResponse({"id": 0, "message": e.args}, safe=False)


# def transaction_details(request, transaction_id, user_id):
#     transaction = Transaction.objects.get(id=transaction_id, user_id=user_id)

#     return JsonResponse({"id": transaction.id, "amount": transaction.amount, "description": transaction.description, "comment": transaction.comment, "date": transaction.date, "time": transaction.time, "is_expense": transaction.is_expense}, safe=False)
def transaction_put(request, user_id, transaction_id):
    try:
        data = json.loads(request.body)
        transaction = Transaction(id=transaction_id, user_id=user_id,
                                  amount=data["amount"], description=data['description'], comment=data['comment'], date=data['date'], time=data['time'], is_expense=data['is_expense'])
        transaction.save()
        return JsonResponse({"id": transaction.id}, safe=False)

    except IntegrityError as e:
        return JsonResponse({"id": 0, "message": e.args}, safe=False)


def transactions_date(request, user_id, fromDate, toDate):

    user = User.objects.get(id=user_id)
    transaction = list(user.transaction_set.filter(date__gte=fromDate, date__lte=toDate).order_by('-date', '-time').values(
        'id', 'amount', 'is_expense', 'comment', 'description', 'date', 'time'))
    return JsonResponse({'user': {'balance': user.balance}, 'transactions': transaction}, safe=False)


def user_auth(request):
    data = json.loads(request.body)
    print(data['username'], data['password'])
    user = authenticate(username=data['username'], password=data['password'])
    if user is not None:
        response = {"error": 0, "user": user}
        return JsonResponse({"error": 0, 'user': {'id': user.id, 'username': user.username,  'balance': user.balance}})

    else:
        response = {"error": 1, "user": user}
        return JsonResponse(response)


def user_post(request):
    data = json.loads(request.body)
    user = User.objects.create_user(
        data['username'], data['email'], data['password'])
    user.first_name = data['first_name'] if data['first_name'] != None else None
    user.last_name = data['last_name'] if data['last_name'] != None else None
    user.save()
    return JsonResponse({'user': {'id': user.id, 'username': user.username,  'balance': user.balance}})
