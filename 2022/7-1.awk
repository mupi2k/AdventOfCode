# STACK CODE IS PUBLIC DOMAIN, NO WARRANTY!

function push(stack, value){
  stack[++stack["lastss"]] = value
}

function pop(stack, locx){
  if(stack["firstss"] > stack["lastss"]){
  return NULL
  } else {
  locx = stack[stack["lastss"]]
  delete stack[stack["lastss"]--]
  return locx
  }
}

function stacklook(stack, num){
  if(stack["firstss"] > stack["lastss"])
  return NULL # stack spent
  if(num <= 0){
  num = stack["lastss"] + num
  if(num < 1) return NULL
  return stack[num]
  } else {
  num = stack["firstss"] + num - 1
  if(num > stack["lastss"]) return NULL
  return stack[num]
  }
}

function stackoutofrange(stack, num){
  if(stack["firstss"] > stack["lastss"])
  return 3
  if(num <= 0){
  if(stack["lastss"] + num < stack["firstss"])
  return(-1)
  else
  return(0)
  } else {
  if(num + stack["firstss"] > stack["lastss"] +1)
  return 1
  else
  return 0
  }
}

# propagate() pushes the current size up to the parent of cwd
function propagate(stack, size) {
    size = tree[stacklook(cwd,0)]
    tree[stacklook(stack, -1)] += size
}

BEGIN {
  cwd["firstss"] = "10001"
  cwd["lastss"] = "10000"
  cwd_size = 0
  tree[0] = ""
}

($1 == "$") && ($2 == "cd") {
  FLAG = "OFF"
  tree[stacklook(cwd)] += cwd_size
  if ($3 == "..") {
    propagate(cwd)
    pop(cwd)
  }
  else  {
    current = stacklook(cwd)
    if ($3 == "/") push(cwd, $3)
      else push(cwd, current $3 "/")
    }
  cwd_size = 0
}

FLAG == "ON" {
  if ($1 != "dir") {
    cwd_size += $1
  }
}

($1 == "$") && ($2 == "ls") {
  FLAG = "ON"
}

END {
  # we need to roll up the last part of the tree because our input probably won't take us back to /
  tree[stacklook(cwd)] += cwd_size
  while (stacklook(cwd) != "/") {
    propagate(cwd)
    pop(cwd)
  }
  delete tree[0]
  for (p in tree) {
    printf("%s: %d\n", p, tree[p])
  }
}
