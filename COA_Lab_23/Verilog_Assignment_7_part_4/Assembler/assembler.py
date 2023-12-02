import sys
import re
import json

REGDICT = {}
INSTRUCTION_DICT = {}
OUTPUT = open("output.txt", "w")

def spit_line(line):
    try:
        opcode=INSTRUCTION_DICT[line[0]][0]
        opc=int(opcode,2)

        if(opc==0):
            print("line: ",line)
            shamt=f"{0:05b}"
            funct=INSTRUCTION_DICT[line[0]][-1]
            funct=int(funct,2)

            if(funct>=0 and funct<7):
                if len(line)!=4:
                    print("Error in line: ",line)
                    return
                else:
                    rs=f"{REGDICT[line[1]]:05b}"
                    rt=f"{REGDICT[line[2]]:05b}"
                    rd=f"{REGDICT[line[3]]:05b}"
            elif (funct>=7 and funct<=10):
                if len(line)!=3:
                    print("Error in line: ",line)
                    return
                else:
                    rs=f"{REGDICT[line[2]]:05b}"
                    rt=f"{0:05b}"
                    rd=f"{REGDICT[line[1]]:05b}"
            elif (funct>=11 and funct<=12):
                if len(line)!=2:
                    print("Error in line: ",line)
                    return
                else:
                    rd=f"{REGDICT[line[1]]:05b}"
                    rt=f"{0:05b}"
                    rs=f"{0:05b}"
            elif (funct==13):
                if len(line)!=3:
                    print("Error in line: ",line)
                    return
                else:
                    rs=f"{0:05b}"
                    rt=f"{0:05b}"
                    rd=f"{0:05b}"
            else:
                print("Error in line: ",line)
                return
            

            print(f"{opc:06b}{rs}{rt}{rd}{shamt}{funct:06b}",file=OUTPUT)

        elif(opc>=1 and opc<=9):
            if len(line)!=3:
                print("Error in line: ",line)
                return
            else:
                rs=f"{REGDICT[line[1]]:05b}"
                rt=f"{0:05b}"
                imm=f"{int(line[2]):016b}"

                print(f"{opc:06b}{rs}{rt}{imm}",file=OUTPUT)

        elif(opc==10):
            if len(line)!=2:
                print("Error in line: ",line)
                return
            else:
                rs=f"{0:05b}"
                rt=f"{0:05b}"
                imm=f"{int(line[1]):016b}"

                print(f"{opc:06b}{rs}{rt}{imm}",file=OUTPUT)

        elif(opc>=11 and opc<=13):
            if len(line) !=3:
                print("Error in line: ",line)
                return
            else:
                rs=f"{0:05b}"
                rt=f"{0:05b}"
                imm=f"{int(line[1]):016b}"

                print(f"{opc:06b}{rs}{rt}{imm}",file=OUTPUT)
        elif(opc>=14 and opc<=17):
            if len(line)!=4:
                print("Error1 in line: ",line)
                return
            else:
                rs=f"{REGDICT[line[1]]:05b}"
                rt=f"{REGDICT[line[2]]:05b}"
                imm=f"{int(line[3]):016b}"
                print(f"{opc:06b}{rs}{rt}{imm}",file=OUTPUT)
        elif(opc==18):
            if len(line)!=2:
                print("Error in line: ",line)
                return
            else:
                rs=f"{0:05b}"
                rt=f"{0:05b}"
                imm=f"{int(line[1]):016b}"

                print(f"{opc:06b}{rs}{rt}{imm}",file=OUTPUT)

        elif(opc==62 or opc==63):
            if len(line)!=1:
                print("Error in line: ",line)
                return
            else:
                rs=f"{0:05b}"
                rt=f"{0:05b}"
                imm=f"{0:016b}"

                print(f"{opc:06b}{rs}{rt}{imm}",file=OUTPUT)
        
        else:
            print("Error in line: ",line)
            return

    except:
        print("Error4 in line: ",line)

def main():
    
    INPUT = open("test1.s", "r")
    for line in INPUT:
        line = line.replace(",", " ")
        line = line.strip()
        line = re.sub(r'\s+', ' ', line)
        print (line)
        line = line.split(" ")
        print (line)
        spit_line(line)
    INPUT.close()
    OUTPUT.close()

if __name__ == "__main__":
    with open('reg.json','r') as f:
        REGDICT = json.load(f)
    with open('instruction.json','r') as f:
        INSTRUCTION_DICT = json.load(f)
    main()



