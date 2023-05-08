
def show_p(p):
    print(pToString(p))

def command_show_allg():
    print(allgToString())


def allgToString():
    res =""
    padding="   "
    allg = eval(None, "runtime.allgs").Variable.Value
    
    res+="==========allgs========\n"

    res+="| goid |"+padding
    for g in allg:
        res+= str(g.goid)+padding+"|"+padding
    res+="\n"     
    # status 
    res+="|status|"+padding
    for g in allg:
        res+= str(g.atomicstatus.value)+padding+"|"+padding
    res+="\n"
    return res
        



def pToString(p):
    return ("pid",p.id,"status: ",p.status,"runnext:",get_g(p.runnext) if p.runnext!=0 else "nil", "runq:",[ get_g(g).goid for idx, g in enumerate(p.runq) if int(g)!=0 and p.runqhead<=idx and idx<=p.runqtail ])

def get_g(addr):
    return  eval(None,"*(*runtime.g) "+"(0x%x)" %addr ).Variable.Value

def get_p(addr):
    return  eval(None,"*(*runtime.p) "+"(0x%x)" %addr ).Variable.Value

def command_show_p():
    allp = eval(None, "runtime.allp").Variable.Value
    for p in allp:
        show_p(p)


def command_show_m():
    print("==========allms========\n")
    allm = eval(None, "runtime.allm").Variable.Value
    if not hasattr(allm,"alllink"):
        return
    mp = allm.alllink
     
    while hasattr(mp,"id"):

        if not hasattr(mp.curg,"goid"):
            mp = mp.alllink
            continue


        print("m",mp.id,"curg: ",mp.curg.goid)
        # print connected p
        if mp.p !=0:
            print("connected P: ",pToString(get_p(mp.p)))
        print("")
        mp = mp.alllink
        


def command_show_gmp():
    command_show_m()
    command_show_allg()
    return


#t proc.go:4333    




