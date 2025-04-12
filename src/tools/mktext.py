import random

def create_textbox_data(x):
    x = x.encode('ascii')
    x = b'\n'.join(i.strip() for i in x.split(b'\n')).strip()
    paragraphs = x.split(b'\n\n')
    result = []
    for paragraph in paragraphs:
        lines = paragraph.split(b"\n")
        subresult = []
        for line in lines:
            subresult.append(line)
        result.append(subresult[0] + b'\xfe' + b'\xfd'.join(subresult[1:]))
    return b'\xfc'.join(result) + b'\x00'

chars = b'K,fZxJIESRF1Net4?uqnyHUsi6CQcm3YkBX. T7P9olMLb2wpDOv5h!a0r8j-VWdgzGA@\''

def is_charset(x):
    for c in x:
        if bytes([c]) not in chars: return False
    return True

def to_std_charset(x):
    r = []
    x = x.replace(b"{FF}", b"\xff")
    x = x.replace(b"{FE}", b"\xfe")
    x = x.replace(b"{FD}", b"\xfd")
    x = x.replace(b"{FC}", b"\xfc")
    x = x.replace(b"{FB}", b"\xfb")
    x = x.replace(b"{FA}", b"\xfa")
    for c in x:
        if c > 0xf0 or c == 0:
            r.append(c)
            continue
        try:
            r.append(1+chars.index(bytes([c])))
        except:
            raise RuntimeError("weird char %.2x" % c)
    return bytes(r)

def hex2(x):
    return "%.2x" % x

data = b""
textboxes = []

for i in range(0, 255):
    try:
        with open('text/%s.txt' % hex2(i)) as f:
            data += create_textbox_data(f.read())
    except FileNotFoundError:
        pass

data_orig = data

idx = 1
window_size = 4

dictionary = []
operable_dictionary = []

def get_substring_with_biggest_gain(x):
    r = {}
    for window_size in range(6, 2, -1):
        for i in range(0, len(data)-window_size):
            k = data[i:i+window_size]
            if not is_charset(k): continue
            if k not in r:
                r[k] = 0
            r[k] += 1
    for k, v in r.items():
        r[k] = (r[k]-1) * (len(k)-1) # number of occurences * number of bytes saved
    r = [(k, v) for k, v in r.items()]
    r.sort(key=lambda x: -x[1])
    return r[0]

while True:
    ss = get_substring_with_biggest_gain(data)
    if idx > 180: break
    print("\r%i/180" % idx, end="")
    data = data.replace(ss[0], bytes([0, len(chars)+idx, 0]))
    idx += 1
    dictionary.append(to_std_charset(ss[0]))
    operable_dictionary.append(ss[0])
print(" dictionary entries")
#print(operable_dictionary)

dict_blob = b'\xff' + b'\xff'.join(dictionary) + b'\xff'

text_blob = to_std_charset(data_orig)
orig_len = len(text_blob)

idx = 1
for r in dictionary:
    text_blob = text_blob.replace(r, bytes([len(chars)+idx]))
    idx += 1

new_len = len(text_blob)

print("text encoder: %i/%i (%.2f%%) / with dictionary: %i/%i (%.2f%%)" % (
    new_len, orig_len, (new_len/orig_len)*100,
    new_len + len(dict_blob), orig_len, ((new_len + len(dict_blob))/orig_len)*100
))

import codecs
zsz = len(codecs.encode(data_orig, "zlib"))
print("zlibbed size (for reference): %i (%.2f%%)" % (zsz, 100*(zsz/orig_len)))

with open('text_dictionary.bin', 'wb') as f:
    f.write(dict_blob)
with open('text_data.bin', 'wb') as f:
    f.write(text_blob)
