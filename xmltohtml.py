#!/home/chip/tk/venv/bin/python
import lxml.etree as ET
import argparse
import sys
import os.path

def createParser ():
    parser = argparse.ArgumentParser()
    parser.add_argument ('--xml',default='/home/chip/tk/XSLT/Dop/АКЦИЗНЫЕ_МАРКИ_ТРИ_ТОВАРА.XML')
    parser.add_argument ('--xslt',default='/home/chip/tk/XSLT/Dop/1006107E_ESADout_CU.xslt')
    parser.add_argument ('--html', default='/home/chip/tk/test.html')
    return parser

if __name__ == '__main__':
    print('xml_to_html')
    parser = createParser()
    namespace = parser.parse_args()
    if not namespace.xml or not namespace.xslt:
        print('xmltohtml.py --xml <file_name> --xslt <file_name> [--html<file_name>]')
        sys.exit(1)
    if not os.path.exists(namespace.xml):
        print('file not found {}'.format(namespace.xml))
        sys.exit(1)
    if not os.path.exists(namespace.xslt):
        print('file not found {}'.format(namespace.xslt))
        sys.exit(1)
    dom = ET.parse(namespace.xml)
    xslt = ET.parse(namespace.xslt)
    transform = ET.XSLT(xslt)
    newdom = transform(dom)
    s = ET.tostring(newdom, pretty_print=True)
    handle = open(namespace.html,'w')
    handle.write(s.decode())
    handle.close
