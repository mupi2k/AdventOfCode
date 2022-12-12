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

BEGIN {
  cols = 1
  rows = 0
}

!FLAG {
  if ($0 == "") {
    FLAG = 1
    rows--
    printf("Rows: %s  Cols:%s\n",rows, cols)
    for (c=1;c<=cols;c++) {
      # initialize stacks
      stacks[c]["lastss"] = 10000
      stacks[c]["firstss"] = 10001
      for (i=rows;i>=1;i--) {
        if (grid[c,i] != " ") push(stacks[c],grid[c,i])
      }
    }
    next}

  col = 0
  rows++
  if ($1 == 1) {
    for (i=1;i<=NF;i++) {
      stackname[i] = $i
      next
    }
  }
  for (i=1; i<=length($0); i++) {
    if (i % 4 == 0 || i == length($0)) {
      data = substr($0,i-2,1)
      if (data == "[") data = substr($0,i-1,1)
      col++
      grid[col,rows] = data
      # failsafe...
      if (col > cols) cols = col
    }
  }
}

FLAG {
  for (i=1;i<=$2;i++) {
    d = pop(stacks[$4])
    push(stacks[$6], d)
    }
}
END {
  printf("TOPS: ")
  for (c=1;c<=cols;c++) {
    printf("%s", pop(stacks[c]))
  }
  print ""
}

