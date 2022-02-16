from openpyxl import load_workbook

wb = load_workbook('test.xlsx')
sh = wb['test-_select_tc_inn_tc_name_as_']
path = './monitor'
for row in sh: 
    text = row[10].value    
    if text.find('xml') != -1:
        name = '{0}_{1}_{2}.xml'.format(row[0].row-1, row[3].value[0:1], row[4].value)
        my_file = open(path+'/'+name, "w")
        my_file.write(text)
        my_file.close()