from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from transactions.models import User, Transaction


# Create your views here.


def transactions_view(request, id=None):
    user = User.objects.get(id=id)
    transaction = list(user.transaction_set.values(
        'id', 'amount', 'type', 'description', 'comment', 'date', 'time'))
    return JsonResponse({'user': user.id, 'transactions': transaction}, safe=False)
