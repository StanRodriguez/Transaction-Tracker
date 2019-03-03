from django.shortcuts import render
from django.http import HttpResponse, JsonResponse, HttpRequest
from transactions.models import User, Transaction
import json

# Create your views here.


def transactions_view(request, id=None):
    user = User.objects.get(id=id)
    transaction = list(user.transaction_set.order_by('-date', '-time').values(
        'id', 'amount', 'is_expense', 'description', 'comment', 'date', 'time'))
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
    user = User.objects.get(id=user_id)
    if request.method == "POST":

        data = json.loads(request.body)
        user.transaction_set.create(
            amount=data["amount"], is_expense=data["isExpense"], description=data["description"], comment=data["comment"], date=data["date"], time=data["time"])
        print(data)
    else:
        print("no")
    return JsonResponse({"hello": "world"}, safe=False)
