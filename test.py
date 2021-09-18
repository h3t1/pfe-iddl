import requests
headers ={'User-Agent': 'Mozilla/5.0'}
solr_url = 'http://pebebssolrsrh01:8080/solr/srhnew-collection_shard1_replica2/select?q=file_folder+%3A+%22%2FMySafe%2FMyInbox%2F%22&rows=200&wt=json&indent=true&group=true&group.field=faas_isafe_sendercode'
response = requests.get(solr_url, headers=headers)
data = response.json()
clients = data["grouped"]["faas_isafe_sendercode"]["groups"]
nombre_total = len(clients)
index = 0
cumulativeSum = 0
sender_code_ancien_portail = ['A001','A007','A011','A015','A019','A024','A027','A029','A031','A034','A036','A041','A043','A044','A045','A054','A057','A059','A067','A071','A072','A075','A076','A080','A081','A082','A083','A084','A089','A090','A092','A093','A095','A098','A099','A101','A103','A104','A106','ADEC','ADREA','ALCOA','ALLER','ALTRAN','ANAP','ARC','ASTGRP','BRAND','CELIO','CHS','COFAC','CONDE','DAMR','DEFAULT','DEV','EBU','ELAL','FIBA','GE','GOSPR','IFP','IMS','JOHNS','KEMON','LBD','LCL','LOG','MANIT','MBL','MUTX','ORC','PAGJAU','PICHET','RGO','SAMAT','SER','SGO','SGS','SMS','TRAP','TUI','VER','VWFS','eae'
]
with open('test.csv', 'w') as f:
    print("index,clientCode,numFound,cumulativeSum",file=f)
    for cl in clients:
        groupValue = str(cl["groupValue"]).upper()
        if groupValue in sender_code_ancien_portail:
            numFound = int(cl["doclist"]["numFound"])
            cumulativeSum += numFound
            print("{},{},{},{}".format(index,cl["groupValue"],numFound,cumulativeSum), file=f)
            index +=1