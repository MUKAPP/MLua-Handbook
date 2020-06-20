require "import"
import "mods.imports"
import "mods.mukmod"
import "mods.loadlayout"
JSON=import "mods.json"

状态栏高度=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)
型号 = Build.MODEL
SDK版本 = tonumber(Build.VERSION.SDK)
安卓版本 = Build.VERSION.RELEASE
ROM类型 = string.upper(Build.MANUFACTURER)
内部存储路径=Environment.getExternalStorageDirectory().toString().."/"

应用版本名=activity.getPackageManager().getPackageInfo(activity.getPackageName(), PackageManager.GET_ACTIVITIES).versionName;
应用版本=activity.getPackageManager().getPackageInfo(activity.getPackageName(), PackageManager.GET_ACTIVITIES).versionCode;

function 状态栏颜色(n)
  pcall(function()
    local window=activity.getWindow()
    window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
    window.setStatusBarColor(n)
    statusbarcolor=n
    if SDK版本>=23 then
      if n==0x3f000000 then
        window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
        window.setStatusBarColor(0xffffffff)
       else
        window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_VISIBLE)
        window.setStatusBarColor(n)
      end
    end
  end)
end

function 导航栏颜色(n,n1)
  pcall(function()
    local window=activity.getWindow()
    window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
    window.setNavigationBarColor(n)
    if SDK版本>=23 then
      if n==0x3f000000 then
        window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
        window.setNavigationBarColor(0xffffffff)
       else
        if n1 then
          window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
         else
          window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_VISIBLE)
        end
        window.setNavigationBarColor(n)
      end
    end
  end)
end

function 沉浸状态栏(n1,n2,n3)
  pcall(function()
    local window=activity.getWindow()
    window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
    pcall(function()
      window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
      window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
      window.setStatusBarColor(Color.TRANSPARENT)
      window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE)
    end)
    if SDK版本>=23 then
      if n1 then
        window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE|View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
       elseif n2 then
        window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
       elseif n3 then
        window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE|View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR)
      end
    end

  end)
end

function dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end

function px2dp(pxValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return pxValue / scale + 0.5
end

function px2sp(pxValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity;
  return pxValue / scale + 0.5
end

function sp2px(spValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return spValue * scale + 0.5
end

function 获取文件修改时间(path)
  f = File(path);
  cal = Calendar.getInstance();
  time = f.lastModified()
  cal.setTimeInMillis(time);
  return cal.getTime().toLocaleString()
end

function 写入文件(路径,内容)
  xpcall(function()
    local f=File(tostring(File(tostring(路径))
    .getParentFile()))
    .mkdirs()
    io.open(tostring(路径),"w")
    :write(tostring(内容)):close()
  end,function()
    提示("写入文件 "..路径.." 失败")
  end)
end

function 读取文件(路径)
  if 文件是否存在(路径) then
    return io.open(路径):read("*a")
   else
    return ""
  end
end

function 复制文件(from,to)
  xpcall(function()
    LuaUtil.copyDir(from,to)
  end,function()
    提示("复制文件 从 "..from.." 到 "..to.." 失败")
  end)
end

function 创建文件夹(file)
  xpcall(function()
    File(file).mkdir()
  end,function()
    提示("创建文件夹 "..file.." 失败")
  end)
end

function 创建文件(file)
  xpcall(function()
    File(file).createNewFile()
  end,function()
    提示("创建文件 "..file.." 失败")
  end)
end

function 创建多级文件夹(file)
  xpcall(function()
    File(file).mkdirs()
  end,function()
    提示("创建文件夹 "..file.." 失败")
  end)
end

function 文件是否存在(file)
  return File(file).exists()
end

function 删除文件(file)
  xpcall(function()
    LuaUtil.rmDir(File(file))
  end,function()
    提示("删除文件(夹) "..file.." 失败")
  end)
end

function 文件修改时间(path)
  local f = File(path);
  local time = f.lastModified()
  f=nil
  return time
end

function 内置存储(t)
  return Environment.getExternalStorageDirectory().toString().."/"..t
end

function 压缩(from,to,name)
  ZipUtil.zip(from,to,name)
end

function 获取系统夜间模式()
  _,Re=xpcall(function()
    import "android.content.res.Configuration"
    currentNightMode = activity.getResources().getConfiguration().uiMode & Configuration.UI_MODE_NIGHT_MASK
    return currentNightMode == Configuration.UI_MODE_NIGHT_YES--夜间模式启用
  end,function()
    return false
  end)
  return Re
end

function 主题(str)
  --str="夜"
  全局主题值=str
  if 全局主题值=="Day" then
    primaryc="#cb82be"
    --secondaryc="#51326c"
    textc="#212121"
    stextc="#424242"
    backgroundc="#ffffffff"
    barbackgroundc="#efffffff"
    cardbackc="#10000000"
    viewshaderc="#00000000"
    grayc="#ECEDF1"
    状态栏颜色(0x3f000000)
    导航栏颜色(0x3f000000)
    pcall(function()
      local _window = activity.getWindow();
      _window.setBackgroundDrawable(ColorDrawable(0xffffffff));
      local _wlp = _window.getAttributes();
      _wlp.gravity = Gravity.BOTTOM;
      _wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
      _wlp.height = WindowManager.LayoutParams.MATCH_PARENT;--WRAP_CONTENT
      _window.setAttributes(_wlp);
      activity.setTheme(android.R.style.Theme_Material_Light_NoActionBar)
    end)
   elseif 全局主题值=="Night" then
    primaryc="#C28BB8"
    --secondaryc="#51326c"
    textc="#E0E0E0"
    stextc="#9E9E9E"
    backgroundc="#222222"
    barbackgroundc="#ef212121"
    cardbackc="#3f000000"
    viewshaderc="#5f000000"
    grayc="#191919"
    状态栏颜色(0xff212121)
    导航栏颜色(0xff212121)
    pcall(function()
      local _window = activity.getWindow();
      _window.setBackgroundDrawable(ColorDrawable(0xff222222));
      local _wlp = _window.getAttributes();
      _wlp.gravity = Gravity.BOTTOM;
      _wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
      _wlp.height = WindowManager.LayoutParams.MATCH_PARENT;--WRAP_CONTENT
      _window.setAttributes(_wlp);
      activity.setTheme(android.R.style.Theme_Material_NoActionBar)
    end)
  end
end

mukactivity.setDataR("Setting_Night_Mode","false")
mukactivity.setDataR("Setting_Auto_Night_Mode","true")
mukactivity.setDataR("Setting_Auto_Update","true")
mukactivity.setDataR("Setting_Activity_LoadTime","false")
mukactivity.setDataR("Setting_Main_Enabled","true")

if Boolean.valueOf(mukactivity.getData("Setting_Auto_Night_Mode"))==true then
  if 获取系统夜间模式() then
    主题("Night")
   else
    主题("Day")
  end
 else
  if Boolean.valueOf(mukactivity.getData("Setting_Night_Mode"))==true then
    主题("Night")
   else
    主题("Day")
  end
end

--print(mukactivity.getData("Setting_Night_Mode"),全局主题值)

--[[if mukactivity.getData("Setting_Home_PlayerBar")==nil then
  mukactivity.setData("Setting_Home_PlayerBar","false")
end]]

pcall(function()
  activity.getActionBar().hide()
end)

function activity背景颜色(color)
  pcall(function()
    local _window = activity.getWindow();
    _window.setBackgroundDrawable(ColorDrawable(color));
    local _wlp = _window.getAttributes();
    _wlp.gravity = Gravity.BOTTOM;
    _wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
    _wlp.height = WindowManager.LayoutParams.MATCH_PARENT;--WRAP_CONTENT
    _window.setAttributes(_wlp);
  end)
end

function 转0x(j)
  if #j==7 then
    return tonumber("0xff"..j:match("#(.+)"))
   else
    return tonumber("0x"..j:match("#(.+)"))
  end
end

function 提示(t,bottom_p)
  local bottom_p=bottom_p or "16dp"

  local w=activity.width

  local tsbj={
    LinearLayout,
    Gravity="bottom",
    {
      CardView,
      layout_width="-1";
      layout_height="-2";
      CardElevation="4dp",
      CardBackgroundColor=转0x(backgroundc)-0x10000000,
      Radius="8dp",
      layout_margin="16dp";
      layout_marginTop=bottom_p or "16dp";
      {
        LinearLayout,
        layout_height=-2,
        layout_width=w-dp2px(32);
        gravity="left|center",
        padding="16dp";
        --paddingTop="12dp";
        --paddingBottom="12dp";
        {
          TextView,
          textColor=转0x(primaryc),
          textSize="14sp";
          layout_height=-2,
          layout_width=-2,
          text=t;
          Typeface=字体("product")
        },
      }
    }
  }

  Toast.makeText(activity,t,Toast.LENGTH_SHORT).setGravity(Gravity.TOP|Gravity.CENTER, 0, 0).setView(loadlayout(tsbj)).show()
end

function Snakebar(fill,bottom_p)
  提示(fill,bottom_p)
end

function 随机数(最小值,最大值)
  return math.random(最小值,最大值)
end

function 设置视图(t)
  activity.setContentView(loadlayout(t))
end

function 信息判断(code)
  if code/200==1 then
    return true
   else
    return false
  end
end

function 静态渐变(a,b,id,fx)
  if fx=="竖" then
    fx=GradientDrawable.Orientation.TOP_BOTTOM
  end
  if fx=="横" then
    fx=GradientDrawable.Orientation.LEFT_RIGHT
  end
  local drawable = GradientDrawable(fx,{
    a,--右色
    b,--左色
  });
  fx=nil
  id.setBackgroundDrawable(drawable)
end

xpcall(function()
  ripple = activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
  ripples = activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)
end,function()end)

function 波纹(id,lx)
  xpcall(function()
    for i=1,#id do
      if lx=="圆白" then
        id[i].setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
      end
      if lx=="方白" then
        id[i].setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
      end
      if lx=="圆黑" then
        id[i].setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
      end
      if lx=="方黑" then
        id[i].setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
      end
      if lx=="圆主题" then
        id[i].setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fcb82be})))
      end
      if lx=="方主题" then
        id[i].setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fcb82be})))
      end
      if lx=="圆自适应" then
        if 全局主题值=="Day" then
          id[i].setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
         else
          id[i].setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
        end
      end
      if lx=="方自适应" then
        if 全局主题值=="Day" then
          id[i].backgroundDrawable=(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
         else
          id[i].setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
        end
      end
    end
  end,function(e)end)
end

function 波纹2(lx)
  local i,z=xpcall(function()
    if lx=="圆白" then
      return activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff}))
    end
    if lx=="方白" then
      return activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff}))
    end
    if lx=="圆黑" then
      return activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000}))
    end
    if lx=="方黑" then
      return activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000}))
    end
    if lx=="圆主题" then
      return activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fcb82be}))
    end
    if lx=="方主题" then
      return activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fcb82be}))
    end
    if lx=="圆自适应" then
      if 全局主题值=="Day" then
        return activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000}))
       else
        return activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff}))
      end
    end
    if lx=="方自适应" then
      if 全局主题值=="Day" then
        return activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000}))
       else
        return activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff}))
      end
    end
  end,function(e)end)
  return z
end

function 控件可见(a)
  a.setVisibility(View.VISIBLE)
end

function 控件不可见(a)
  a.setVisibility(View.INVISIBLE)
end

function 控件隐藏(a)
  a.setVisibility(View.GONE)
end

function 对话框按钮颜色(dialog,button,WidgetColor)
  if button==1 then
    dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(WidgetColor)
   elseif button==2 then
    dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(WidgetColor)
   elseif button==3 then
    dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(WidgetColor)
  end
end

function 关闭对话框(en)
  if en then
    en.dismiss()
   else
    an.dismiss()
  end
end

function 控件圆角(view,radiu,InsideColor)
  local drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end

function 双按钮对话框(bt,nr,qd,qx,qdnr,qxnr,gb)
  if 全局主题值=="Day" then
    bwz=0x3f000000
   else
    bwz=0x3fffffff
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text=bt;
        Typeface=字体("product-Bold");
        textColor=primaryc;
      };
      {
        ScrollView;
        layout_width="-1";
        layout_height="-1";
        {
          TextView;
          layout_width="-1";
          layout_height="-2";
          textSize="14sp";
          layout_marginTop="8dp";
          layout_marginLeft="24dp";
          layout_marginRight="24dp";
          layout_marginBottom="8dp";
          Typeface=字体("product");
          Text=nr;
          textColor=textc;
          id="sandhk_wb";
        };
      };
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        gravity="right|center";
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="2dp";
          background="#00000000";
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginBottom="24dp";
          Elevation="0";
          onClick=qxnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            Typeface=字体("product-Bold");
            paddingRight="16dp";
            paddingLeft="16dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qx;
            textColor=stextc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          background=primaryc;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=qdnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            Typeface=字体("product-Bold");
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qd;
            textColor=backgroundc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  local window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  local wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end

function 单按钮对话框(bt,nr,qd,qdnr,gb)
  if 全局主题值=="日" then
    bwz=0x3f000000
   else
    bwz=0x3fffffff
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text=bt;
        Typeface=字体("product-Bold");
        textColor=primaryc;
      };
      {
        ScrollView;
        layout_width="-1";
        layout_height="-1";
        {
          TextView;
          layout_width="-1";
          layout_height="-2";
          textSize="14sp";
          layout_marginTop="8dp";
          layout_marginLeft="24dp";
          layout_marginRight="24dp";
          layout_marginBottom="8dp";
          Typeface=字体("product");
          Text=nr;
          textColor=textc;
        };
      };
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        gravity="right|center";
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          background=primaryc;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=qdnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            Typeface=字体("product-Bold");
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qd;
            textColor=backgroundc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  local window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  local wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end

function 三按钮对话框(bt,nr,qd,qx,ds,qdnr,qxnr,dsnr,gb)
  if 全局主题值=="Day" then
    bwz=0x3f000000
   else
    bwz=0x3fffffff
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text=bt;
        Typeface=字体("product-Bold");
        textColor=primaryc;
      };
      {
        ScrollView;
        layout_width="-1";
        layout_height="-1";
        {
          TextView;
          layout_width="-1";
          layout_height="-2";
          textSize="14sp";
          layout_marginTop="8dp";
          layout_marginLeft="24dp";
          layout_marginRight="24dp";
          layout_marginBottom="8dp";
          Typeface=字体("product");
          Text=nr;
          textColor=textc;
          id="sandhk_wb";
        };
      };
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        gravity="right|center";
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="2dp";
          background="#00000000";
          layout_marginTop="8dp";
          layout_marginLeft="24dp";
          layout_marginBottom="24dp";
          Elevation="0";
          onClick=dsnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            Typeface=字体("product-Bold");
            paddingRight="16dp";
            paddingLeft="16dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=ds;
            textColor=stextc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          LinearLayout;
          orientation="horizontal";
          layout_width="-1";
          layout_height="-2";
          layout_weight="1";
        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="2dp";
          background="#00000000";
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginBottom="24dp";
          Elevation="0";
          onClick=qxnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            Typeface=字体("product-Bold");
            paddingRight="16dp";
            paddingLeft="16dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qx;
            textColor=stextc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          background=primaryc;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=qdnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            Typeface=字体("product-Bold");
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qd;
            textColor=backgroundc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  local window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  local wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end

function 解压缩(压缩路径,解压缩路径)
  xpcall(function()
    ZipUtil.unzip(压缩路径,解压缩路径)
  end,function()
    提示("解压文件 "..压缩路径.." 失败")
  end)
end

function 压缩(原路径,压缩路径,名称)
  xpcall(function()
    LuaUtil.zip(原路径,压缩路径,名称)
  end,function()
    提示("压缩文件 "..原路径.." 至 "..压缩路径.."/"..名称.." 失败")
  end)
end

function 重命名文件(旧,新)
  xpcall(function()
    File(旧).renameTo(File(新))
  end,function()
    提示("重命名文件 "..旧.." 失败")
  end)
end

function 移动文件(旧,新)
  xpcall(function()
    File(旧).renameTo(File(新))
  end,function()
    提示("移动文件 "..旧.." 至 "..新.." 失败")
  end)
end

function 跳转页面(ym,cs)
  if cs then
    activity.newActivity(ym,cs)
   else
    activity.newActivity(ym)
  end
end

function 渐变跳转页面(ym,cs)
  if cs then
    activity.newActivity(ym,android.R.anim.fade_in,android.R.anim.fade_out,cs)
   else
    activity.newActivity(ym,android.R.anim.fade_in,android.R.anim.fade_out)
  end
end

function 检测键盘()
  local imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
  local isOpen=imm.isActive()
  return isOpen==true or false
end

function 隐藏键盘()
  activity.getSystemService(INPUT_METHOD_SERVICE).hideSoftInputFromWindow(WidgetSearchActivity.this.getCurrentFocus().getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS)
end

function 显示键盘(id)
  activity.getSystemService(INPUT_METHOD_SERVICE).showSoftInput(id, 0)
end

function 关闭页面()
  activity.finish()
end

function 复制文本(文本)
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(文本)
end

function QQ群(h)
  local url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin="..h.."&card_type=group&source=qrcode"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function QQ(h)
  local url="mqqapi://card/show_pslcard?src_type=internal&source=sharecard&version=1&uin="..h
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function 全屏()
  local window = activity.getWindow();
  window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN|
  View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN|
  View.SYSTEM_UI_FLAG_HIDE_NAVIGATION|
  View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
  window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)

  xpcall(function()
    local lp = window.getAttributes();
    lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
    window.setAttributes(lp);
    lp=nil
  end,
  function(e)
  end)
  window=nil
end

function 退出全屏()
  activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
end

function 图标(n)
  return "res/twotone_"..n.."_black_24dp.png"
end

function 高斯模糊(id,tp,radius1,radius2)
  local function blur( context, bitmap, blurRadius)
    renderScript = RenderScript.create(context);
    blurScript = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript));
    inAllocation = Allocation.createFromBitmap(renderScript, bitmap);
    outputBitmap = bitmap;
    outAllocation = Allocation.createTyped(renderScript, inAllocation.getType());
    blurScript.setRadius(blurRadius);
    blurScript.setInput(inAllocation);
    blurScript.forEach(outAllocation);
    outAllocation.copyTo(outputBitmap);
    inAllocation.destroy();
    outAllocation.destroy();
    renderScript.destroy();
    blurScript.destroy();
    return outputBitmap;
  end

  xpcall(function()bitmap=loadbitmap(tp)end,function(e)bitmap=tp end)

  local function zoomBitmap(bitmap,scale)
    local w = bitmap.getWidth();
    local h = bitmap.getHeight();
    local matrix = Matrix();
    matrix.postScale(scale, scale);
    local bitmap = Bitmap.createBitmap(bitmap, 0, 0, w, h, matrix, true);
    return bitmap;
  end

  local function blurAndZoom(context,bitmap,blurRadius,scale)
    return zoomBitmap(blur(context,zoomBitmap(bitmap, 1 / scale), blurRadius), scale);
  end

  id.setImageBitmap(blurAndZoom(activity,bitmap,radius1,radius2))
end

function 获取应用信息(archiveFilePath)
  local pm = activity.getPackageManager()
  local info = pm.getPackageInfo(archiveFilePath, PackageManager.GET_ACTIVITIES);
  if info ~= nil then
    local appInfo = info.applicationInfo;
    local appName = tostring(pm.getApplicationLabel(appInfo))
    return appInfo.packageName --安装包名称
    ,info.versionName --版本信息
    ,pm.getApplicationIcon(appInfo)--图标
   else
    return nil,nil,nil
  end
end

function 编辑框颜色(eid,color)
  pcall(function()
    eid.getBackground().setColorFilter(PorterDuffColorFilter(color,PorterDuff.Mode.SRC_ATOP))
  end)
end

function 下载文件(链接,文件名)
  downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  local request=DownloadManager.Request(Uri.parse(链接));
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
  request.setDestinationInExternalPublicDir("MUKAPP/Download",文件名);
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
  downloadManager.enqueue(request);
  Snakebar("正在下载文件，下载到："..MUKAPP文件("Download/"..文件名).."\n请查看通知栏以查看下载进度。")
end

function 获取文件MIME(name)
  local ExtensionName=tostring(name):match("%.(.+)")
  local Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
  return tostring(Mime)
end

function 申请权限(权限)
  ActivityCompat.requestPermissions(this,权限,1)
end
--申请权限({Manifest.permission.WRITE_EXTERNAL_STORAGE})--不可用

function 判断悬浮窗权限()
  if (Build.VERSION.SDK_INT >= 23 and not Settings.canDrawOverlays(this)) then
    return false
   elseif Build.VERSION.SDK_INT < 23 then
    return ""
   else
    return true
  end
end

function 获取悬浮窗权限()
  local intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
  intent.setData(Uri.parse("package:" .. activity.getPackageName()));
  activity.startActivityForResult(intent, 100);
end

function 安装apk(安装包路径)
  local intent = Intent(Intent.ACTION_VIEW)
  intent.setDataAndType(Uri.parse("file:///"..安装包路径), "application/vnd.android.package-archive")
  intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  activity.startActivity(intent)
end

function 浏览器打开(pageurl)
  local viewIntent = Intent("android.intent.action.VIEW",Uri.parse(pageurl))
  activity.startActivity(viewIntent)
end

function 设置图片(preview,url)
  xpcall(function()
    preview.setImageBitmap(loadbitmap(url))
  end,function(e)
    preview.setImageBitmap(url)
  end)
end

function 字体(t)
  return Typeface.createFromFile(File(activity.getLuaDir().."/res/"..t..".ttf"))
end

function 开关颜色(id,color,color2)
  id.ThumbDrawable.setColorFilter(PorterDuffColorFilter(转0x(color),PorterDuff.Mode.SRC_ATOP))
  id.TrackDrawable.setColorFilter(PorterDuffColorFilter(转0x(color2),PorterDuff.Mode.SRC_ATOP))
end

--[[
function 微信扫一扫()
  intent = activity.getPackageManager().getLaunchIntentForPackage("com.tencent.mm");
  intent.putExtra("LauncherUI.From.Scaner.Shortcut", true);
  activity.startActivity(intent);
end]]

function 微信扫一扫()
  import "android.content.Intent"
  import "android.content.ComponentName"
  local intent = Intent();
  intent.setComponent( ComponentName("com.tencent.mm", "com.tencent.mm.ui.LauncherUI"));
  intent.putExtra("LauncherUI.From.Scaner.Shortcut", true);
  intent.setFlags(335544320);
  intent.setAction("android.intent.action.VIEW");
  activity.startActivity(intent);
end

function 支付宝扫一扫()
  import "android.net.Uri"
  import "android.content.Intent"
  local uri = Uri.parse("alipayqr://platformapi/startapp?saId=10000007");
  local intent = Intent(Intent.ACTION_VIEW, uri);
  activity.startActivity(intent);
end

function 支付宝捐赠()
  --https://qr.alipay.com/fkx01496axmjusadzgm2v97
  xpcall(function()
    local url = "alipayqr://platformapi/startapp?saId=10000007&clientVersion=10.1.6&qrcode=https://qr.alipay.com/fkx01496axmjusadzgm2v97"
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)));
  end,
  function()
    local url = "https://qr.alipay.com/fkx01496axmjusadzgm2v97";
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)));
  end)
end

function 颜色字体(t,c)
  local sp = SpannableString(t)
  sp.setSpan(ForegroundColorSpan(转0x(c)),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  return sp
end

function 翻译(str,sth)
  local retstr=str
  import "com.kn.rhino.*"
  import "java.net.URLEncoder"

  local res=Js.runFunction(activity,[[function token(a) {
    var k = "";
    var b = 406644;
    var b1 = 3293161072;

    var jd = ".";
    var sb = "+-a^+6";
    var Zb = "+-3^+b+-f";

    for (var e = [], f = 0, g = 0; g < a.length; g++) {
        var m = a.charCodeAt(g);
        128 > m ? e[f++] = m: (2048 > m ? e[f++] = m >> 6 | 192 : (55296 == (m & 64512) && g + 1 < a.length && 56320 == (a.charCodeAt(g + 1) & 64512) ? (m = 65536 + ((m & 1023) << 10) + (a.charCodeAt(++g) & 1023), e[f++] = m >> 18 | 240, e[f++] = m >> 12 & 63 | 128) : e[f++] = m >> 12 | 224, e[f++] = m >> 6 & 63 | 128), e[f++] = m & 63 | 128)
    }
    a = b;
    for (f = 0; f < e.length; f++) a += e[f],
    a = RL(a, sb);
    a = RL(a, Zb);
    a ^= b1 || 0;
    0 > a && (a = (a & 2147483647) + 2147483648);
    a %= 1E6;
    return a.toString() + jd + (a ^ b)
};

function RL(a, b) {
    var t = "a";
    var Yb = "+";
    for (var c = 0; c < b.length - 2; c += 3) {
        var d = b.charAt(c + 2),
        d = d >= t ? d.charCodeAt(0) - 87 : Number(d),
        d = b.charAt(c + 1) == Yb ? a >>> d: a << d;
        a = b.charAt(c) == Yb ? a + d & 4294967295 : a ^ d ;
    }
    return a
};]],"token",{str})
  local url="https://translate.google.cn/translate_a/single?"
  local datastr=""
  local data={"client=webapp",
    "sl=auto",
    "tl=zh-CN",
    "hl=zh-CN",
    "dt=at",
    "dt=bd",
    "dt=ex",
    "dt=ld",
    "dt=md",
    "dt=qca",
    "dt=rw",
    "dt=rm",
    "dt=ss",
    "dt=t",
    "ie=UTF-8",
    "oe=UTF-8",
    "source=btn",
    "ssel=0",
    "tsel=0",
    "kc=0",
    "tk="..res,
    "q="..URLEncoder.encode(str)}
  local datastr=table.concat(data,"&")
  Http.get(url..datastr,{["User-Agent"]="Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7"},function(code,content)
    local rettior=content
    sth(rettior)
  end)
end

function MD5(str)
  local HexTable = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
  local A = 0x67452301
  local B = 0xefcdab89
  local C = 0x98badcfe
  local D = 0x10325476

  local S11 = 7
  local S12 = 12
  local S13 = 17
  local S14 = 22
  local S21 = 5
  local S22 = 9
  local S23 = 14
  local S24 = 20
  local S31 = 4
  local S32 = 11
  local S33 = 16
  local S34 = 23
  local S41 = 6
  local S42 = 10
  local S43 = 15
  local S44 = 21

  local function F(x,y,z)
    return (x & y) | ((~x) & z)
  end
  local function G(x,y,z)
    return (x & z) | (y & (~z))
  end
  local function H(x,y,z)
    return x ~ y ~ z
  end
  local function I(x,y,z)
    return y ~ (x | (~z))
  end
  local function FF(a,b,c,d,x,s,ac)
    a = a + F(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function GG(a,b,c,d,x,s,ac)
    a = a + G(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function HH(a,b,c,d,x,s,ac)
    a = a + H(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function II(a,b,c,d,x,s,ac)
    a = a + I(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end

  local function MD5StringFill(s)
    local len = s:len()
    local mod512 = len * 8 % 512
    --需要填充的字节数
    local fillSize = (448 - mod512) // 8
    if mod512 > 448 then
      fillSize = (960 - mod512) // 8
    end

    local rTab = {}

    --记录当前byte在4个字节的偏移
    local byteIndex = 1
    for i = 1,len do
      local index = (i - 1) // 4 + 1
      rTab[index] = rTab[index] or 0
      rTab[index] = rTab[index] | (s:byte(i) << (byteIndex - 1) * 8)
      byteIndex = byteIndex + 1
      if byteIndex == 5 then
        byteIndex = 1
      end
    end
    --先将最后一个字节组成4字节一组
    --表示0x80是否已插入
    local b0x80 = false
    local tLen = #rTab
    if byteIndex ~= 1 then
      rTab[tLen] = rTab[tLen] | 0x80 << (byteIndex - 1) * 8
      b0x80 = true
    end

    --将余下的字节补齐
    for i = 1,fillSize // 4 do
      if not b0x80 and i == 1 then
        rTab[tLen + i] = 0x80
       else
        rTab[tLen + i] = 0x0
      end
    end

    --后面加原始数据bit长度
    local bitLen = math.floor(len * 8)
    tLen = #rTab
    rTab[tLen + 1] = bitLen & 0xffffffff
    rTab[tLen + 2] = bitLen >> 32

    return rTab
  end

  --	Func:	计算MD5
  --	Param:	string
  --	Return:	string
  ---------------------------------------------

  function string.md5(s)
    --填充
    local fillTab = MD5StringFill(s)
    local result = {A,B,C,D}

    for i = 1,#fillTab // 16 do
      local a = result[1]
      local b = result[2]
      local c = result[3]
      local d = result[4]
      local offset = (i - 1) * 16 + 1
      --第一轮
      a = FF(a, b, c, d, fillTab[offset + 0], S11, 0xd76aa478)
      d = FF(d, a, b, c, fillTab[offset + 1], S12, 0xe8c7b756)
      c = FF(c, d, a, b, fillTab[offset + 2], S13, 0x242070db)
      b = FF(b, c, d, a, fillTab[offset + 3], S14, 0xc1bdceee)
      a = FF(a, b, c, d, fillTab[offset + 4], S11, 0xf57c0faf)
      d = FF(d, a, b, c, fillTab[offset + 5], S12, 0x4787c62a)
      c = FF(c, d, a, b, fillTab[offset + 6], S13, 0xa8304613)
      b = FF(b, c, d, a, fillTab[offset + 7], S14, 0xfd469501)
      a = FF(a, b, c, d, fillTab[offset + 8], S11, 0x698098d8)
      d = FF(d, a, b, c, fillTab[offset + 9], S12, 0x8b44f7af)
      c = FF(c, d, a, b, fillTab[offset + 10], S13, 0xffff5bb1)
      b = FF(b, c, d, a, fillTab[offset + 11], S14, 0x895cd7be)
      a = FF(a, b, c, d, fillTab[offset + 12], S11, 0x6b901122)
      d = FF(d, a, b, c, fillTab[offset + 13], S12, 0xfd987193)
      c = FF(c, d, a, b, fillTab[offset + 14], S13, 0xa679438e)
      b = FF(b, c, d, a, fillTab[offset + 15], S14, 0x49b40821)

      --第二轮
      a = GG(a, b, c, d, fillTab[offset + 1], S21, 0xf61e2562)
      d = GG(d, a, b, c, fillTab[offset + 6], S22, 0xc040b340)
      c = GG(c, d, a, b, fillTab[offset + 11], S23, 0x265e5a51)
      b = GG(b, c, d, a, fillTab[offset + 0], S24, 0xe9b6c7aa)
      a = GG(a, b, c, d, fillTab[offset + 5], S21, 0xd62f105d)
      d = GG(d, a, b, c, fillTab[offset + 10], S22, 0x2441453)
      c = GG(c, d, a, b, fillTab[offset + 15], S23, 0xd8a1e681)
      b = GG(b, c, d, a, fillTab[offset + 4], S24, 0xe7d3fbc8)
      a = GG(a, b, c, d, fillTab[offset + 9], S21, 0x21e1cde6)
      d = GG(d, a, b, c, fillTab[offset + 14], S22, 0xc33707d6)
      c = GG(c, d, a, b, fillTab[offset + 3], S23, 0xf4d50d87)
      b = GG(b, c, d, a, fillTab[offset + 8], S24, 0x455a14ed)
      a = GG(a, b, c, d, fillTab[offset + 13], S21, 0xa9e3e905)
      d = GG(d, a, b, c, fillTab[offset + 2], S22, 0xfcefa3f8)
      c = GG(c, d, a, b, fillTab[offset + 7], S23, 0x676f02d9)
      b = GG(b, c, d, a, fillTab[offset + 12], S24, 0x8d2a4c8a)

      --第三轮
      a = HH(a, b, c, d, fillTab[offset + 5], S31, 0xfffa3942)
      d = HH(d, a, b, c, fillTab[offset + 8], S32, 0x8771f681)
      c = HH(c, d, a, b, fillTab[offset + 11], S33, 0x6d9d6122)
      b = HH(b, c, d, a, fillTab[offset + 14], S34, 0xfde5380c)
      a = HH(a, b, c, d, fillTab[offset + 1], S31, 0xa4beea44)
      d = HH(d, a, b, c, fillTab[offset + 4], S32, 0x4bdecfa9)
      c = HH(c, d, a, b, fillTab[offset + 7], S33, 0xf6bb4b60)
      b = HH(b, c, d, a, fillTab[offset + 10], S34, 0xbebfbc70)
      a = HH(a, b, c, d, fillTab[offset + 13], S31, 0x289b7ec6)
      d = HH(d, a, b, c, fillTab[offset + 0], S32, 0xeaa127fa)
      c = HH(c, d, a, b, fillTab[offset + 3], S33, 0xd4ef3085)
      b = HH(b, c, d, a, fillTab[offset + 6], S34, 0x4881d05)
      a = HH(a, b, c, d, fillTab[offset + 9], S31, 0xd9d4d039)
      d = HH(d, a, b, c, fillTab[offset + 12], S32, 0xe6db99e5)
      c = HH(c, d, a, b, fillTab[offset + 15], S33, 0x1fa27cf8)
      b = HH(b, c, d, a, fillTab[offset + 2], S34, 0xc4ac5665)

      --第四轮
      a = II(a, b, c, d, fillTab[offset + 0], S41, 0xf4292244)
      d = II(d, a, b, c, fillTab[offset + 7], S42, 0x432aff97)
      c = II(c, d, a, b, fillTab[offset + 14], S43, 0xab9423a7)
      b = II(b, c, d, a, fillTab[offset + 5], S44, 0xfc93a039)
      a = II(a, b, c, d, fillTab[offset + 12], S41, 0x655b59c3)
      d = II(d, a, b, c, fillTab[offset + 3], S42, 0x8f0ccc92)
      c = II(c, d, a, b, fillTab[offset + 10], S43, 0xffeff47d)
      b = II(b, c, d, a, fillTab[offset + 1], S44, 0x85845dd1)
      a = II(a, b, c, d, fillTab[offset + 8], S41, 0x6fa87e4f)
      d = II(d, a, b, c, fillTab[offset + 15], S42, 0xfe2ce6e0)
      c = II(c, d, a, b, fillTab[offset + 6], S43, 0xa3014314)
      b = II(b, c, d, a, fillTab[offset + 13], S44, 0x4e0811a1)
      a = II(a, b, c, d, fillTab[offset + 4], S41, 0xf7537e82)
      d = II(d, a, b, c, fillTab[offset + 11], S42, 0xbd3af235)
      c = II(c, d, a, b, fillTab[offset + 2], S43, 0x2ad7d2bb)
      b = II(b, c, d, a, fillTab[offset + 9], S44, 0xeb86d391)

      --加入到之前计算的结果当中
      result[1] = result[1] + a
      result[2] = result[2] + b
      result[3] = result[3] + c
      result[4] = result[4] + d
      result[1] = result[1] & 0xffffffff
      result[2] = result[2] & 0xffffffff
      result[3] = result[3] & 0xffffffff
      result[4] = result[4] & 0xffffffff
    end

    --将Hash值转换成十六进制的字符串
    local retStr = ""
    for i = 1,4 do
      for _ = 1,4 do
        local temp = result[i] & 0x0F
        local str = HexTable[temp + 1]
        result[i] = result[i] >> 4
        temp = result[i] & 0x0F
        retStr = retStr .. HexTable[temp + 1] .. str
        result[i] = result[i] >> 4
      end
    end

    return retStr
  end

  return string.md5(str)
end

function MD5字符串(str)
  local md5 = MessageDigest.getInstance("MD5")
  local bytes = md5.digest(String(str).getBytes())
  local result = ""
  for i=0,#bytes-1 do
    local temp = string.format("%02x",(bytes[i] & 0xff))
    return result..temp
  end
end

function 圆形图片(bitmap)
  import "android.graphics.PorterDuffXfermode"
  import "android.graphics.Paint"
  import "android.graphics.RectF"
  import "android.graphics.Bitmap"
  import "android.graphics.PorterDuff$Mode"
  import "android.graphics.Rect"
  import "android.graphics.Canvas"
  import "android.util.Config"
  local width = bitmap.getWidth()
  local output = Bitmap.createBitmap(width, width,Bitmap.Config.ARGB_8888)
  local canvas = Canvas(output);
  local color = 0xff424242;
  local paint = Paint()
  local rect = Rect(0, 0, bitmap.getWidth(), bitmap.getHeight());
  local rectF = RectF(rect);
  paint.setAntiAlias(true);
  canvas.drawARGB(0, 0, 0, 0);
  paint.setColor(color);
  canvas.drawRoundRect(rectF, width/2, width/2, paint);
  paint.setXfermode(PorterDuffXfermode(Mode.SRC_IN));
  canvas.drawBitmap(bitmap, rect, rect, paint);
  return output;
end

function 图片缩放( bmp, scale)
  local bm=loadbitmap(bmp)
  local width = bm.getWidth();
  local height = bm.getHeight();
  local matrix = Matrix();
  matrix.postScale(scale, scale);
  local newbm = Bitmap.createBitmap(bm, 0, 0, width, height, matrix,true);
  if (bm ~= nil and not bm.isRecycled())
    bm.recycle();
    bm = nil;
  end
  return newbm;
end

function 内置存储文件(u)
  if u =="" or u==nil then
    return 内置存储("MUKAPP/MLuahb")
   else
    return 内置存储("MUKAPP/MLuahb/"..u)
  end
end

function MUKAPP文件(u,u2)
  if u2=="EXTERNAL" then
    if u =="" or u==nil then
      return "MUKAPP"
     else
      return "MUKAPP/"..u
    end
   else
    if u =="" or u==nil then
      return 内置存储("MUKAPP")
     else
      return 内置存储("MUKAPP/"..u)
    end
  end
end

function 图标注释(view,str)
  view.onLongClick=function(v)
    提示(str)
  end
end

function 获取信息(nr,sth)
  Http.get("https://www.mukapp.top/mluahb/"..nr..".php",function(code,content,cookie,header)
    --print(code,content)
    --print(code,content)
    if 0<code and code<400 then
      sth(content)
     else
      sth("error")
    end
  end)
end

function 检查更新(sdu)
  local update_table={nil,nil,nil,nil,nil,nil}
  获取信息("update",function(content)
    if content=="error" then
      if sdu then
        Snakebar("获取新版本信息失败")
      end
      return true
    end
    content=content:gsub("<br>","")
    for v in content:gmatch("{(.-)}") do
      update_table[v:match("(.+) | ")]=v:match(" | (.+)")
    end
    if tointeger(update_table.最新版本)>应用版本 then
      双按钮对话框("检测到新版本: "..update_table.最新版本名,"更新时间："..update_table.更新时间.."\n更新内容：\n"..update_table.更新内容,"立即更新","取消",function()
        关闭对话框(an)
        下载文件(update_table.下载链接,"mluahb_update.apk")
      end,function()
        关闭对话框(an)
      end)
     else
      if sdu then
        Snakebar("已经是最新版本了哦")
      end
    end
  end)
end

function HPageView()
  local function swapEvent(event)
    local width = page.getWidth();
    local height = page.getHeight();
    local newX = (event.getY() / height) * width;
    local newY = (event.getX() / width) * height;
    event.setLocation(newX, newY);
    return event;
  end
  page=luajava.override(PageView,{
    onInterceptTouchEvent=function(super,event)
      --swapEvent(event)
      --return super(swapEvent(event))
      return true
    end,
    onTouchEvent=function(super,event)
      --return super(swapEvent(event))
      return true
    end
  })
  page.setOverScrollMode(PageView.OVER_SCROLL_NEVER)
  ZoomInTransform=(PageView.PageTransformer{
    transformPage=function(view,position)
      alpha=0
      if (position <= 1 && position >= 0) then
        alpha=1-position
       elseif (position < 0 && position > -1) then
        alpha=position+1
      end
      view.setAlpha(alpha)
      transX=view.getWidth()*(-position)
      view.setTranslationX(transX);
      transY=position*view.getHeight()
      view.setTranslationY(transY);
    end
  })
  page.setPageTransformer(true ,ZoomInTransform);
  return page
end

yedrawable = GradientDrawable()
yedrawable.setShape(GradientDrawable.RECTANGLE)
yedrawable.setColor(0xffffffff)
yedrawable.setCornerRadii({dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8)});
yedrawable.setStroke(2, 0x21212121,0,0)

function 设置字体大小倍数(n)
  local res = activity.getResources()
  local config = res.getConfiguration()
  config.fontScale = n
  res.updateConfiguration(config, res.getDisplayMetrics())
end

function 字体大小恢复()
  res = activity.getResources();
  config= res.getConfiguration();
  config.setToDefaults();
  res.updateConfiguration(config,res.getDisplayMetrics() );
end

function 设置dpi(n)
  res = activity.getResources()
  config = res.getConfiguration()
  config.densityDpi = n
  res.updateConfiguration(config, res.getDisplayMetrics())
end

function dpi恢复()
  res = activity.getResources()
  config = res.getConfiguration()
  config.setToDefaults();
  res.updateConfiguration(config, res.getDisplayMetrics())
end

--字体大小恢复()
--dpi恢复()
--设置字体大小倍数(1.0)
--设置dpi(320)

function 加载对话框(bt,nr,gb)
  if 全局主题值=="日" then
    bwz=0x3f000000
   else
    bwz=0x3fffffff
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text=bt;
        Typeface=字体("product-Bold");
        textColor=primaryc;
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-2";
        paddingBottom="24dp";
        Gravity="left|center";
        {
          ProgressBar;
          layout_width="56dp";
          layout_height="56dp";
          layout_marginTop="8dp";
          layout_marginLeft="24dp";
          id="jzdhk_pb";
        };
        {
          TextView;
          layout_width="-1";
          layout_height="-2";
          textSize="14sp";
          layout_marginTop="8dp";
          layout_marginLeft="16dp";
          layout_marginRight="24dp";
          Typeface=Typeface.createFromFile(File(activity.getLuaDir().."/res/product.ttf"));
          Text=nr;
          textColor=textc;
          id="jzdhk_wb";
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  jzdhk_pb.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(转0x(primaryc),PorterDuff.Mode.SRC_ATOP))

  if gb==0 then
    dl.setCancelable(false)
  end
  an=dl.show()
  local window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  local wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end

function 加载对话框内容(n)
  jzdhk_wb.text=n
end

function 双按钮对话框内容(n)
  sandhk_wb.text=n
end

function JarToDex(jarPath,dexPath,onks,oncg,onsb)
  onks()
  local function oncgx()
    oncg()
  end
  local function onsbx()
    onsb()
  end
  local Mythread = thread(function(jarPath, dexPath)
    require "import"
    import "com.android.dx.command.Main"
    xpcall(function()
      Main.main({"--dex","--output=" .. dexPath,jarPath})
      call("oncgx")
    end,function(err)
      call("onsbx")
    end)
  end,jarPath,dexPath)
end

function loadBitmapFromViewBySystem(v)
  v.setDrawingCacheEnabled(true);
  v.buildDrawingCache();
  bitmap = v.getDrawingCache();
  return bitmap;
end

function 遍历设置文本()
  font=Typeface.create("宋体",Typeface.BOLD)
  function setFont(view)
    if luajava.instanceof(view,TextView) then
      view.setTypeface(font)
     elseif luajava.instanceof(view,ViewGroup) then
      for i=0,view.getChildCount()-1 do
        setFont(view.getChildAt(i))
      end
    end
  end
  setFont(activity.getDecorView())
end

function encodeBase64(source_str)
  local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  local s64 = ''
  local str = source_str

  while #str > 0 do
    local bytes_num = 0
    local buf = 0

    for byte_cnt=1,3 do
      buf = (buf * 256)
      if #str > 0 then
        buf = buf + string.byte(str, 1, 1)
        str = string.sub(str, 2)
        bytes_num = bytes_num + 1
      end
    end

    for group_cnt=1,(bytes_num+1) do
      local b64char = math.fmod(math.floor(buf/262144), 64) + 1
      s64 = s64 .. string.sub(b64chars, b64char, b64char)
      buf = buf * 64
    end

    for fill_cnt=1,(3-bytes_num) do
      s64 = s64 .. '='
    end
  end

  return s64
end


--解码


function decodeBase64(str64)
  local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  local temp={}
  for i=1,64 do
    temp[string.sub(b64chars,i,i)] = i
  end
  temp['=']=0
  local str=""
  for i=1,#str64,4 do
    if i>#str64 then
      break
    end
    local data = 0
    local str_count=0
    for j=0,3 do
      local str1=string.sub(str64,i+j,i+j)
      if not temp[str1] then
        return
      end
      if temp[str1] < 1 then
        data = data * 64
       else
        data = data * 64 + temp[str1]-1
        str_count = str_count + 1
      end
    end
    for j=16,0,-8 do
      if str_count > 0 then
        str=str..string.char(math.floor(data/math.pow(2,j)))
        data=math.mod(data,math.pow(2,j))
        str_count = str_count - 1
      end
    end
  end

  local last = tonumber(string.byte(str, string.len(str), string.len(str)))
  if last == 0 then
    str = string.sub(str, 1, string.len(str) - 1)
  end
  return str
end


--封装Http_upload函数，上传参数(链接，参数,图片地址,回调)
function Http_upload(ur,name,f,zhacai)
  client = OkTest.newok()
  f=File(f)
  requestBody = MultipartBody.Builder()
  .setType(MultipartBody.FORM)
  .addFormDataPart(name,tostring(f.Name),RequestBody.create(MediaType.parse("multipart/form-data"), f))
  .build()

  request = Request.Builder()
  .header("User-Agent","Dalvik/2.1.0 (Linux; U; Android 9.0; MI MIX Alpha)")
  .url(ur)
  .post(requestBody)
  .build();

  client.newCall(request).enqueue(Callback{
    onFailure=function(call, e)--请求失败
      zhacai("","","")
    end,
    onResponse=function(call, response)--请求成功
      code=response.code()--.toString()
      header=response.headers()
      data=String(response.body().bytes()).toString()
      zhacai(code,data,header)
    end
  });
end

function 获取控件图片(view)
  local linearParams = view.getLayoutParams()
  local vw=linearParams.width
  local vh=linearParams.height
  view.layout(0,0,vw,vh)
  view.setDrawingCacheEnabled(true)
  return Bitmap.createBitmap(view.getDrawingCache())
end

function 获取控件图片(view)
  view.destroyDrawingCache()
  view.setDrawingCacheEnabled(true)
  view.buildDrawingCache()
  return view.getDrawingCache()
end

function 保存图片(name,bm)
  if bm then
    import "java.io.FileOutputStream"
    import "java.io.File"
    import "android.graphics.Bitmap"
    name=tostring(name)
    f = File(name)
    out = FileOutputStream(f)
    bm.compress(Bitmap.CompressFormat.PNG,100, out)
    out.flush()
    out.close()
    return true
   else
    return false
  end
end

function MEditText(v)
  local TransY=0
  if v.text~=nil then
    TransY=-dp2px(24/2)
  end
  return function()
    return loadlayout({
      LinearLayout;
      layout_width=v.layout_width;
      layout_height=v.layout_height;
      {
        CardView;
        CardElevation="0dp";
        CardBackgroundColor=cardbackc;
        Radius="8dp";
        layout_width="-1";
        layout_height="-2";
        {
          RelativeLayout;
          focusable=true;
          layout_width="-1";
          layout_height="-2";
          focusableInTouchMode=true;
          --paddingLeft="64dp";
          --paddingRight="64dp";
          {
            EditText;
            textColor=v.textColor;
            textSize="14sp";
            gravity="center|left";
            SingleLine=v.SingleLine;
            layout_width="-1";
            layout_height="-2";
            id=v.id;
            background="#00212121";
            Typeface=字体("product");
            padding="16dp";
            paddingTop="32dp";
            text=v.text;
            InputType=v.inputType;
            addTextChangedListener=({
              afterTextChanged=function(s)
                --print(s)
              end});
            OnFocusChangeListener=({
              onFocusChange=function(vw,hasFocus)
                if hasFocus then
                  vw.getParent().getChildAt(1).setTextColor(转0x(primaryc))
                  if vw.text=="" then
                    vw.getParent().getChildAt(1).startAnimation(TranslateAnimation(0,0,0,-dp2px(24/2)).setDuration(100).setFillAfter(true))
                  end
                 else
                  vw.getParent().getChildAt(1).setTextColor(转0x(v.HintTextColor))
                  if #vw.Text==0 then
                    vw.getParent().getChildAt(1).TranslationY=0
                    vw.getParent().getChildAt(1).startAnimation(TranslateAnimation(0,0,-dp2px(24/2),0).setDuration(100).setFillAfter(true))
                   else
                    vw.getParent().getChildAt(1).setTextColor(转0x(primaryc))
                  end

                end
              end});
          };
          {
            TextView;
            textColor=v.HintTextColor;
            text=v.hint;
            textSize="14sp";
            layout_width="-1";
            layout_height="-2";
            gravity="center|left";
            Typeface=字体("product-Medium");
            padding="16dp";
            paddingTop="24dp";
            TranslationY=TransY;
          };
        };
      };
    })
  end
end
