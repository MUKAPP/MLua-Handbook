require "import"
import "mods.muk"
JSON=import "mods.json"

local debug_time_create_n=os.clock()

function onCreate()

  layout={
    RelativeLayout;
    layout_width="-1";
    background=backgroundc;
    layout_height="-1";
    {
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      orientation="vertical";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="56dp";
        gravity="center|left";
        id="mActionBar";
        {
          LinearLayout;
          orientation="horizontal";
          layout_height="56dp";
          layout_width="56dp";
          gravity="center";
          {
            ImageView;
            ColorFilter=primaryc;
            src=图标("arrow_back");
            layout_height="32dp";
            layout_width="32dp";
            padding="4dp";
            id="fh";
            onClick=function()关闭页面()end;
          };
        };
        {
          TextView;
          textColor=primaryc;
          text="get/post调试";
          paddingLeft="16dp";
          textSize="20sp";
          layout_height="-2";
          layout_width="-2";
          Typeface=字体("product-Bold");
          ellipsize="end";
          SingleLine=true;
        };
      };
      {
        ScrollView;
        layout_width="-1";
        layout_height="-1";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-1";
          orientation="vertical";
          padding="16dp";
          id="_root";
          {
            MEditText
            {
              textSize="14sp",
              id="url",
              textColor=textc;
              HintTextColor=stextc;
              hint="网址(URL,必填！)";
              layout_width="-1";
              layout_height="-2";
            };
          };
          {
            MEditText
            {
              textSize="14sp",
              id="cookie",
              textColor=textc;
              HintTextColor=stextc;
              hint="Cookie(身份辨认信息)";
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginTop="16dp";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="charset",
              textColor=textc;
              HintTextColor=stextc;
              hint="编码(Charset)";
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginTop="16dp";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="header",
              textColor=textc;
              HintTextColor=stextc;
              hint="请求头(Header,格式为:{名称,值}{名称,值}…)";
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginTop="16dp";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="data",
              textColor=textc;
              HintTextColor=stextc;
              hint="发送数据(Data,填入为post模式,留空为get模式)";
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginTop="16dp";
          };
          {
            CardView;
            layout_width="-1";
            layout_height="-2";
            radius="8dp";
            background=backgroundc;
            layout_marginTop="16dp";
            Elevation="2dp";
            onClick=function()
            end;
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-1";
              background=cardbackc;
              {
                TextView;
                layout_width="-1";
                layout_height="-1";
                textSize="16sp";
                paddingRight="16dp";
                paddingLeft="16dp";
                Typeface=字体("product-Bold");
                paddingTop="12dp";
                paddingBottom="12dp";
                gravity="center";
                Text="请求";
                textColor=primaryc;
                id="ann1";
              };
            };
          };
          {
            MEditText
            {
              textSize="14sp",
              id="r_code",
              textColor=textc;
              HintTextColor=stextc;
              hint="响应代码(Code,2xx表示成功,4xx表示请求错误,5xx表示服务器错误,-1表示出错)";
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginTop="16dp";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="r_content",
              textColor=textc;
              HintTextColor=stextc;
              hint="响应内容(Content)";
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginTop="16dp";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="r_cookie",
              textColor=textc;
              HintTextColor=stextc;
              hint="响应Cookie(服务器返回的身份辨认信息)";
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginTop="16dp";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="r_header",
              textColor=textc;
              HintTextColor=stextc;
              hint="响应头信息(Header)";
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginTop="16dp";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="r_dm",
              textColor=textc;
              HintTextColor=stextc;
              hint="当前的Http异步请求代码";
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginTop="16dp";
          };
        };
      };
    };

  }

  activity.setContentView(loadlayout(layout))

  波纹({fh},"圆主题")
  波纹({ann1},"方主题")

  图标注释(fh,"返回")

  activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE|WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

  ann1.onClick=function()
    local callback=[[function(code,content,cookie,header)
end]]

    local callback2=[[function(code,content,cookie,header)
Snakebar("请求完毕")
r_code.text=tostring(code)
r_content.text=content
r_cookie.text=tostring(cookie)
r_header.text=tostring(header)
end]]

    local get=[[Http.get({url},{cookie},{charset},{header},{callback})]]

    local post=[[Http.post({url},{data},{cookie},{charset},{header},{callback})]]

    local function cheak(n)
      if n=="" then
        return "nil"
       else
        return '"'..n..'"'
      end
    end

    local function header_cheak(n)
      if n~="" and n~={} then
        return "hm"
       else
        return "nil"
      end
    end

    local function header_cheak2(n)
      if n~="" and n~={} then
        hm="hm=HashMap{}\n"
        for i,v in n:gmatch("{(.-),(.-)}") do
          hm=hm.."hm.put(\""..i.."\",\""..v.."\")\n"
        end
        return hm
       else
        return "nil"
      end
    end

    local httpq={nil,nil,nil}
    local httpc=""
    local httpd=""

    httpq["cookie"]=cheak(cookie.text)
    httpq["charset"]=cheak(charset.text)
    httpq["header"]=header_cheak(header.text)
    if data.text~="" then
      httpc=post
      :gsub("{url}",'"'..url.text..'"')
      :gsub("{cookie}",httpq["cookie"])
      :gsub("{charset}",httpq["charset"])
      :gsub("{header}",httpq["header"])
      :gsub("{data}",'"'..data.text..'"')
      :gsub("{callback}",callback)
      httpd=post
      :gsub("{url}",'"'..url.text..'"')
      :gsub("{cookie}",httpq["cookie"])
      :gsub("{charset}",httpq["charset"])
      :gsub("{header}",httpq["header"])
      :gsub("{data}",'"'..data.text..'"')
      :gsub("{callback}",callback2)
     else
      httpc=get
      :gsub("{url}",'"'..url.text..'"')
      :gsub("{cookie}",httpq["cookie"])
      :gsub("{charset}",httpq["charset"])
      :gsub("{header}",httpq["header"])
      :gsub("{callback}",callback)
      httpd=get
      :gsub("{url}",'"'..url.text..'"')
      :gsub("{cookie}",httpq["cookie"])
      :gsub("{charset}",httpq["charset"])
      :gsub("{header}",httpq["header"])
      :gsub("{callback}",callback2)
    end
    if httpq["header"]=="hm" then
      httpc=header_cheak2(header.text)..httpc
      httpd=header_cheak2(header.text)..httpd
    end
    r_dm.text=httpc
    loadstring(httpd)()
    Snakebar("正在请求…")
  end

  listalpha=AlphaAnimation(0,1)
  listalpha.setDuration(256)
  controller=LayoutAnimationController(listalpha)
  controller.setDelay(0.4)
  controller.setOrder(LayoutAnimationController.ORDER_NORMAL)
  _root.setLayoutAnimation(controller)

  分屏()

  local debug_time_create=os.clock()-debug_time_create_n
  if mukactivity.getData("Setting_Activity_LoadTime")=="true" then
    print(debug_time_create)
  end
end

--[[
url 网络请求的链接网址
cookie 使用的cookie，也就是服务器的身份识别信息
charset 内容编码
header 请求头
data 向服务器发送的数据
callback 请求完成后执行的函数

回调函数接受四个参数值分别是
code 响应代码，2xx表示成功，4xx表示请求错误，5xx表示服务器错误，-1表示出错
content 内容，如果code是-1，则为出错信息
cookie 服务器返回的用户身份识别信息
header 服务器返回的头信息
]]


function onConfigurationChanged( newConfig)
  分屏()
end

function 分屏()
  if activity.Height*0.9<activity.Width then
    local m_ALocation=int{0,0}
    mActionBar.getLocationOnScreen(m_ALocation)

    if m_ALocation[1]>=状态栏高度 then
      Activity_Multi_Bottom=true
     else
      Activity_Multi_Bottom=false
    end
    Activity_Multi=true
    local linearParams = mActionBar.getLayoutParams()
    linearParams.height=dp2px(48)
    mActionBar.setLayoutParams(linearParams)
   else
    Activity_Multi=nil
    local linearParams = mActionBar.getLayoutParams()
    linearParams.height=dp2px(56)
    mActionBar.setLayoutParams(linearParams)
  end
end
