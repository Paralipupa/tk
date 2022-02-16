import os

path = '/'.join([os.getcwd(), 'guid_manual']) # путь к файлам .csv
files = list(filter(lambda x: x.endswith('.csv'), os.listdir(path)) )
# files = list(filter(lambda x: x.find('tk_nsi_customs')!=-1, os.listdir(path)) )

files.sort()
out_file = '/'.join([path,'tk_add_guid.sql'])
if os.path.isfile(out_file): 
    os.remove(out_file)
out_hand = open(out_file,'w')
for fi in files:
    try:
        in_hand = open('/'.join([path,fi]),'r')
        table = ('tk_'+fi[fi.find('_')+1:fi.find('_2022')]).replace('nsi_','')
        lines = in_hand.readlines()
        out_hand.write('--- {} \n'.format(table))
        sql = 'UPDATE ref_keymap SET guid_manual=\'\', ischeck=False WHERE name=\'{}\';\n'.format(table)
        out_hand.write(sql)
        for line in lines[1:]:
            data = line.replace('"','').strip('\n').split(',')
            if len(data) == 2 and data[1]:
                sql = 'UPDATE ref_keymap SET guid_manual=\'{guid}\', ischeck=True '\
                        'WHERE id in (SELECT id FROM ref_keymap '\
                        'WHERE name=\'{name}\' and ischeck=False and '\
                        'key LIKE \'{code}%\' ORDER BY modify_date DESC LIMIT 1);'.format(name=table,guid=data[0],code=data[1])

                out_hand.write(sql+'\n')
        out_hand.write('\n')
        in_hand.close
    except Exception as ex:
        print('error: '+str(ex)+'\n'+sql)
out_hand.close

