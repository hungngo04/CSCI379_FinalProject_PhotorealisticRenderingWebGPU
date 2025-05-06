""" 
 * Copyright (c) 2025 SingChun LEE @ Bucknell University. CC BY-NC 4.0.
 * 
 * This code is provided mainly for educational purposes at Bucknell University.
 *
 * This code is licensed under the Creative Commons Attribution-NonCommerical 4.0
 * International License. To view a copy of the license, visit 
 *   https://creativecommons.org/licenses/by-nc/4.0/
 * or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
 *
 * You are free to:
 *  - Share: copy and redistribute the material in any medium or format.
 *  - Adapt: remix, transform, and build upon the material.
 *
 * Under the following terms:
 *  - Attribution: You must give appropriate credit, provide a link to the license,
 *                 and indicate if changes where made.
 *  - NonCommerical: You may not use the material for commerical purposes.
 *  - No additional restrictions: You may not apply legal terms or technological 
 *                                measures that legally restrict others from doing
 *                                anything the license permits.
"""

import sys
import re
import subprocess

def extractEntryPoint(wgsl):
  entryPoints = []
  with open(wgsl, 'r') as file:
    wgslCode = file.read()
  
  matches = re.search(r'^/\*.*?\*/', wgslCode, flags=re.DOTALL)
  msg = matches.group(0) if matches else None
  
  matches = re.findall(r'@(vertex|fragment|compute)(?:.*?)(?:\s+@\w+.*?)*\s+fn\s+(\w+)', wgslCode)
  for fType, fName in matches:
    entryPoints.append((fType, fName))
  return [msg, entryPoints]

def extractInputStorage(wgsl):
  storages = []
  with open(wgsl, 'r') as file:
    wgslCode = file.read()
  
  matches = re.findall(r'(@group *\(\d+\) +@binding *\(\d+\) +)var<storage>', wgslCode)
  return matches

def optimizeByTint(wgsl):
  try:
    #subprocess.run('./tint --rename-all --format spvasm ' + wgsl + '.wgsl -o ' + wgsl + '.spvasm')
    subprocess.run(["./tint", "--rename-all", "--format", "spvasm", wgsl + ".wgsl", "-o", wgsl + ".spvasm"])
    #subprocess.run('./tint --format wgsl ' + wgsl + '.spvasm -o optimized_' + wgsl + '.wgsl')
    subprocess.run(["./tint", "--format", "wgsl", wgsl + ".spvasm", "-o", "optimized_" + wgsl + ".wgsl"])
  except subprocess.CalledProcessError as e:
    print(e)
    raise

def patchOptimizedCode(wgsl, msg, names, inputs):
  with open(wgsl, 'r') as file:
    wgslCode = file.read()
  for pattern in inputs:
    pattern = re.sub(r'(\()', r'\\\1', pattern)
    pattern = re.sub(r'(\))', r'\\\1', pattern)
    wgslCode = re.sub(r'('+pattern+r'+var<storage)([\w ,]*)(>)', r'\1\3', wgslCode)
  for fType, fName in names:
    match = re.search(r'@'+fType+r'(?:\s+@\w+.*?)*\s+fn\s+(tint_symbol\w*)', wgslCode)
    if match:
      obfuscatedName = match.group(1)
      wgslCode = re.sub(r'(@'+fType+r'(?:\s+@\w+.*?)*\s+fn\s+)'+obfuscatedName, r'\1'+fName, wgslCode)
  if msg:
    wgslCode = msg + '\n\n' + wgslCode
  with open(wgsl, 'w') as file:
    file.write(wgslCode)
  

def main():
  if len(sys.argv) < 2:
    print("Usage: python optimizeWGSL.py <filename w/o extension>")
  else:
    msg, names = extractEntryPoint(sys.argv[1] + ".wgsl")
    inputs = extractInputStorage(sys.argv[1] + ".wgsl")
    optimizeByTint(sys.argv[1])
    patchOptimizedCode("optimized_" + sys.argv[1] + ".wgsl", msg, names, inputs)
    
if __name__ == "__main__":
  main()
