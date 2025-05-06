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
import os
import rjsmin

def combineContent(file, curDir, imported, root_dir=None):
  if file in imported: return r'' # already imported
  imported.add(file)
  
  # Store project root directory the first time
  if root_dir is None:
    root_dir = os.path.abspath(os.path.dirname(os.path.dirname(curDir)))
  
  # Handle path resolution based on whether it begins with / or not
  if file.startswith('/'):
    # Absolute path from project root
    filepath = os.path.normpath(os.path.join(root_dir, file.lstrip('/')))
  else:
    # Relative path from current directory
    filepath = os.path.normpath(os.path.join(curDir, file))
  
  # Check if file exists, if not try to resolve with project root
  if not os.path.exists(filepath):
    # Try to find it relative to project root
    filepath = os.path.normpath(os.path.join(root_dir, file))
  
  with open(filepath, 'r') as f:
    content = f.read()
  
  # import files
  pattern = r'(import +.*? +from +[\'"](.*?)[\'"]\s*)'
  matches = re.findall(pattern, content)
  for oldText, importFile in matches:
    # Use dirname of current file for relative imports
    import_dir = os.path.dirname(filepath)
    fileContent = combineContent(importFile, import_dir, imported, root_dir)
    content = content.replace(oldText, fileContent + '\n\n')
  return content

def main():
  if len(sys.argv) < 2:
    print("Usage: python combine.py <the entry js file>")
  else:
    imported = set()
    project_root = os.path.abspath(os.path.dirname(os.path.abspath(sys.argv[0])))
    content = combineContent(sys.argv[1], os.path.dirname(os.path.abspath(sys.argv[1])), imported, project_root)
    # get rid of export default 
    content = content.replace("export default ", '')
    # replace "*/*.wgsl" with "*/optimized_*.wgsl"
    # use it when you also obfuscated your shader code
    pattern = r'[\'"](.*.wgsl)[\'"]'
    matches = re.findall(pattern, content)
    for oldText in matches:
      content = content.replace(oldText, os.path.dirname(oldText) + "/optimized_" + os.path.basename(oldText))
    with open(os.path.splitext(os.path.basename(sys.argv[1]))[0] + "-full.js", 'w') as file:
      file.write(rjsmin.jsmin(content))
    
if __name__ == "__main__":
  main()