#!/usr/bin/python3
import bs4
import re
import requests

BASE_URL = 'http://proxylist.hidemyass.com'

def download_and_parse(url):
    H = {
        'User-Agent': 'M0zi11@/S.O (M@cint0sh; Intel M@c 0S X 0.0; rv:360) Geck0/10100101 Firefox/360'
    }
    raw = requests.get(url, headers = H).content
    return bs4.BeautifulSoup(raw)

def valid_genral_ipv4(ip):
    ip = ip.split('.')
    if len(ip) != 4: return False
    try:
        return all(0 <= int(n) < 256 for n in ip)
    except:
        return False

def render(td):
    if not hasattr(render, 'reg_style'):
        render.reg_style = re.compile('^\.(?P<class>[\w\-_]+)\{display:\s*(?P<value>\w+)')
        render.reg_display = re.compile('display\s*:\s*(?P<value>\w+)')
        render.reg_display_none = re.compile('display\s*:\s*none')

    reg_style, reg_display, reg_display_none  = (
        render.reg_style,
        render.reg_display,
        render.reg_display_none
    )

    displays = {}

    styles = td.select('style')
    if styles:
        for style in styles: # parse style
            for l in style.text.strip().split():
                m = reg_style.match(l)
                if not m: continue
                class_name, value = m.groups()
                if value != 'none': continue
                displays[class_name] = value
            style.decompose()

    for hide_class in displays:
        for elem in td.select('.' + hide_class):
            elem.decompose()

    elements1 = td.select('span')
    elements2 = td.select('div')
    if not elements1: elements1 = []
    if not elements2: elements2 = []

    for elem in elements1 + elements2:
        #LOG#('> ' + str(elem))
        if elem.select('span') or elem.select('div'):
            continue
        if 'display:none' in str(elem):
            elem.clear()
        elif ':none' in str(elem):
            with open('err.log', 'a') as err:
                print("Notice " + str(elem), file = err)
        # if 'class' in elem.attrs:
        #     class_name = elem.attrs['class'][-1]
        #     if class_name in displays:
        #         if displays[class_name] == 'none':
        #             elem.clear()
        #LOG#('$ ' + str(elem))

    return td.text.strip()

def pages():
    first_page = download_and_parse(BASE_URL)
    lis = first_page.select('.hma-pagination div.row ul li')
    page_count = int(lis[-2].text.strip(), 10)

    yield first_page

    for i in range(2, page_count + 2):
        p = download_and_parse('{url}/{index:d}'.format(url = BASE_URL, index = i))
        yield p

for page in pages():
    proxies = page.select('table tbody tr')
    for p in proxies:
        d = p.select('td')
        log = str(d[1])
        d = [ render(d[1]) ] + [ e.text.strip() for e in d[2:] ]
        if not valid_genral_ipv4(d[0]):
            with open('err.log', 'a') as err:
                print('Error ' + repr(log), file = err)
                print('Error2 ' + repr(d), file = err)
        else:
            print(d[0] + ':' + d[1])
