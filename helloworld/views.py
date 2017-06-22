# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render

# Create your views here.

from django.http import HttpResponse
from django.views.decorators.cache import cache_page
from django.core.cache import cache

cache.set('Helloworld', 'ubiquiti')


@cache_page(60 * 30)
def index(request):
    return HttpResponse("Hello, world. UBIQUITI NETWORKS")