import pynvim
import subprocess 
import os

@pynvim.plugin 
class arduino (object):
    def __init__(self,nvim):
        self.nvim = nvim
    
    @pynvim.command("Compile",nargs='*', range='')
    def compile(self,args,range):
        getDir = os.getcwd().split('/')[-1]
        comp = subprocess.getoutput(f'arduino-cli compile --fqbn arduino:avr:nano:cpu=atmega328Bold {getDir}')
        self.nvim.command(f'echo "{comp}"')

