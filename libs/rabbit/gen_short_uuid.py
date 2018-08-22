from bhkey import tools

def gen_bh_key():
    #  print('key = ', tools.gen_key())
    return tools.gen_key()

if __name__ == "__main__":
    bh_key = gen_bh_key()
    print("%s") % (bh_key)
