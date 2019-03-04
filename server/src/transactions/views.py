from django.shortcuts import render
from django.http import HttpResponse, JsonResponse, HttpRequest
from transactions.models import User, Transaction
from django.core import serializers

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
    user = User.objects.get(id=user_id)
    transaction = user.transaction_set.get(id=transaction_id)

    return JsonResponse(transaction.delete(), safe=False)


def transaction_post(request, user_id):
    # if request.method == 'DELETE':
    #     pass

    if request.method == "POST":
        user = User.objects.get(id=user_id)
        data = json.loads(request.body)
        newTransaction = user.transaction_set.create(amount=data["amount"], is_expense=data["is_expense"], description=data[
            "description"], comment=data["comment"], date=data["date"], time=data["time"])
        if newTransaction:
            return JsonResponse({"id": newTransaction.id}, safe=False)
        else:
            return JsonResponse({"id": 0}, safe=False)


# def transaction_details(request, transaction_id, user_id):
#     transaction = Transaction.objects.get(id=transaction_id, user_id=user_id)

#     return JsonResponse({"id": transaction.id, "amount": transaction.amount, "description": transaction.description, "comment": transaction.comment, "date": transaction.date, "time": transaction.time, "is_expense": transaction.is_expense}, safe=False)
def transaction_put(request, user_id, transaction_id):
    data = json.loads(request.body)
    transaction = Transaction(id=transaction_id, user_id=user_id,
                              amount=data["amount"], description=data['description'], comment=data['comment'], date=data['date'], time=data['time'], is_expense=data['is_expense'])
    transaction.save()
    return JsonResponse({"id": transaction.id}, safe=False)
