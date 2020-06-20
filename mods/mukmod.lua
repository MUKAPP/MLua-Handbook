
mukactivity={
  setData=function(string_name,sth_value,string_mode)
    activity.setSharedData(string_name,sth_value)
  end,
  setDataR=function(string_name,sth_value,string_mode)
    if activity.getSharedData(string_name)==nil then
      activity.setSharedData(string_name,sth_value)
    end
  end,
  getData=function(string_name,string_mode,sth_notresult)
    if activity.getSharedData(string_name) then
      return activity.getSharedData(string_name)
     elseif string_mode=="Custom string" then
      return sth_notresult
     else
      return nil
    end
  end,
  CUSTOM_STRING="Custom string",
  CUSTOM_THINGS="Custom things",
}

muktable={
  pairsBySort=function(_t, func)
    local a = {}
    for n in pairs(_t) do a[#a + 1] = n end
    table.sort(a, func)
    local i = 0
    return function()
      i = i + 1
      return a[i], _t[a[i]]
    end
  end,
  sort=function(_t,func)
    _t1={}
    for i,v in muktable.pairsBySort(_t,func) do
      _t1[#_t1 + 1] = v
    end
    return _t1
  end,
}

--[[tbl_ret={}

for i,v in muktable.pairsBySort(tbl) do
  tbl_ret[#tbl_ret + 1] = v
end]]


mukutils = mukutils or {}
--寻找数组中某个值的下标，仅在table中每个值都不一样时有效
function mukutils.findIdxByValue (arr,value)
  local tempArr = arr
  local tempValue = value
  for i,v in ipairs(tempArr) do
    if v == tempValue then
      return i
    end
  end
end

--将string转为table
function mukutils.stringToTable(str, isTableList)
  if str=="" or str==nil then
    return {}
  end
  local ret, msg
  if isTableList then
    ret, msg = loadstring(string.format("return {%s}", str))
   else
    ret, msg = loadstring(string.format("return %s", str))
  end
  if not ret then
    print("原文内容 ",str)
    print("loadstring error", msg)
    return nil
  end
  return ret()
end

--去除字符串两边空格
function mukutils.trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

--根据分隔符分割字符串，返回分割后的table
function mukutils.split(s, delim)
  if not s then
    return {}
  end
  assert (type (delim) == "string" and string.len (delim) > 0, "bad delimiter")
  local start = 1
  local t = {}
  while true do
    local pos = string.find(s, delim, start, true)
    if not pos then
      break
    end
    table.insert (t, string.sub (s, start, pos - 1))
    start = pos + string.len (delim)
  end
  table.insert (t, string.sub (s, start))
  return t
end

--获取两点之间的距离
function mukutils.getDistance(pOne, pTwo)
  if not pOne then
    return 0
  end

  if not pTwo then
    return 0
  end

  local dx = pTwo.x - pOne.x
  local dy = pTwo.y - pOne.y

  return math.sqrt(dx * dx + dy * dy)
end

--四舍五入
function mukutils.roundOff(num)
  local integer, decimal = math.modf(num)
  if decimal >= 0.5 then
    return integer + 1
   else
    return integer
  end
end

--保留两位小数
function mukutils.reserveTwo(num)
  return tonumber(string.format("%.2f", num))
end

-- 是否中文
function mukutils.isCn(c)
  return c:byte() > 128
end

-- 判断资源是否为jpg
function mukutils:checkIsJpeg(filePath)
  local isJpeg = false
  local inpFile = io.open(filePath, "rb")
  -- 读取前三位
  local bytes = inpFile:read(3)
  if bytes then
    local fileHeadIden = ""
    for _, b in ipairs{string.byte(bytes, 1, -1)} do
      local val = string.format("%02X", b)
      fileHeadIden = fileHeadIden..val
    end

    if string.upper(fileHeadIden) == "FFD8FF" then
      isJpeg = true
     else
      print("==> filePath : "..tostring(filePath)..", fileHeadIden : "..tostring(fileHeadIden))
    end
  end

  inpFile:close()

  return isJpeg
end

--[==[
tab1={"a","b"}
str1=" a,b,c "
num1=3.1415

print(mukutils.findIdxByValue(tab1,"b"))
print(dump(mukutils.stringToTable([[{"a","b"},{}]],true)))
print(mukutils.trim(str1))
print(dump(mukutils.split(str1,",")))
print(mukutils.getDistance({["x"]=0,["y"]=0}, {["x"]=1,["y"]=1}))
print(mukutils.roundOff(num1))
print(mukutils.reserveTwo(num1))
print(mukutils.isCn("中文"),mukutils.isCn("English"))
print(mukutils:checkIsJpeg(activity.getLuaDir("icon.png")))
]==]

--今天距离星期几还有几天（tday[0-6 = Sunday-Saturday]）
function mukutils.mondayDays( tday )
  local today = os.date("%w", os.time()) --今天星期几  %w weekday (3) [0-6 = Sunday-Saturday]
  local weeks = {[1]=0,[2]=6,[3]=5,[4]=4,[5]=3,[6]=2,[0]=1}--这是距离星期一所对应的天数集合
  local span = tday - 1
  for k,v in pairs(weeks) do
    local t = v + span
    weeks[k] = t >= 7 and (t - 7) or t
  end
  return weeks[tonumber(today)]
end

--print(mukutils.mondayDays( 0 ))

--打乱table
function mukutils.shuffle(t)
  if type(t)~="table" then
    return
  end
  local tab={}
  local index=1
  while #t~=0 do
    local n=math.random(0,#t)
    if t[n]~=nil then
      tab[index]=t[n]
      table.remove(t,n)
      index=index+1
    end
  end
  return tab
end

--print(dump(mukutils.shuffle({1,2,3,4})))

