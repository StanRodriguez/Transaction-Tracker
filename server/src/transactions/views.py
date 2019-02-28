from django.shortcuts import render
from django.http import HttpResponse, JsonResponse, HttpRequest
from transactions.models import User, Transaction


# Create your views here.


def transactions_view(request, id=None):
    user = User.objects.get(id=id)
    transaction = list(user.transaction_set.values(
        'id', 'amount', 'type', 'description', 'comment', 'date', 'time'))
    return JsonResponse({'user': {'id': user.id, 'username': user.username, 'balance': user.balance}, 'transactions': transaction}, safe=False)


def transaction_delete(request, user_id, transaction_id):
    # if request.method == 'DELETE':
    #     pass

    return HttpResponse(request.method)
