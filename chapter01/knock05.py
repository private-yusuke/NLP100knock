def n_gram(seq, n = 2):
    assert(n >= 1)
    res = []
    for i in range(len(seq)-n+1):
        res.append(seq[i:i+n])
    
    return res

def disassembly(s):
    return s.split(" ")

if __name__ == "__main__":
    print(n_gram(disassembly("I am an NLPer")))
    print(n_gram("I am an NLPer"))