with open('prog','r') as file:
    with open('parsed','w') as res:
        for line in file.readlines():
            line = line.split()
            num = line [2]
            num = num[1:-2]
            res.write('0x'+format(int(num,2),'05x')+'\n')
