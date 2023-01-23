import pynvim
import os

@pynvim.plugin
class Csharp (object):
    def __init__(self,nvim):
        self.nvim = nvim
    
    @pynvim.command("Nclass",nargs=1,range='')
    def nclass(self,File,range):
        Dir = os.getcwd().split("/")[-1]
        cClass = f"namespace {Dir}\n"
        cClass += "{\n"
        cClass += f"\tclass {File[0]}\n\t"
        cClass += "{\n\n"
        cClass += "\t}\n}"

        f = open(f"{File[0]}.cs","w")
        f.write(cClass)
        f.close()

        self.nvim.command(f"tabnew {File[0]}.cs")
