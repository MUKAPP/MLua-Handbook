require "import"
import "mods.muk"

pageurl=...

local debug_time_create_n=os.clock()

function onCreate()
  layout={
    LinearLayout;
    layout_height="-1";
    layout_width="-1";
    orientation="vertical";
    background=backgroundc;
    {
      LinearLayout;--标题栏
      orientation="horizontal";
      layout_height="56dp";
      layout_width="-1";
      background=barbackgroundc;
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
          id="back";
          onClick=function()关闭页面()end;
        };
      };
      {
        ImageView;
        ColorFilter="#9f000000";
        src=图标("info");
        layout_height="24dp";
        layout_width="24dp";
        id="https";
        layout_marginLeft="8dp";
        onClick=function()info()end;
      };
      {
        TextView;--标题
        Typeface=字体("product-Bold");
        textSize="20sp";
        Text="加载中，请稍等 ( ･ิω･ิ)";
        ellipsize="end";
        layout_marginLeft="16dp";
        SingleLine=true;
        textColor=primaryc;
        id="title";
        layout_weight="1";
      };
      {
        ImageView;
        src=图标("more_vert");
        ColorFilter=primaryc;
        layout_width="32dp",
        layout_height="32dp",
        padding="4dp";
        id="more";
        layout_margin="8dp";
        onClick=function()
          --pop.showAsDropDown(_more_lay,dp2px(-8-192),dp2px(8))
          pop.showAsDropDown(_more_lay)
        end;
      };
      {
        TextView;
        id="_more_lay";
        layout_width="0",
        layout_height="0",
        layout_gravity="top";
      };
    };
    {
      RelativeLayout;
      layout_height="-1";
      layout_width="-1";
      id="_root";
      {
        LuaWebView;--主体
        layout_height="-1";
        layout_width="-1";
        id="web";
      };
      {
        LinearLayout;
        layout_height="-1";
        layout_width="-1";
        orientation="vertical";
        background=viewshaderc;
        {
          TextView;
          layout_width="-1";
          layout_height="2dp";
          id="webprogress";
        };
      };
      {
        LinearLayout;
        layout_height="-1";
        layout_width="-1";
        id="jzdh";
        background=backgroundc;
        orientation="vertical";
        --[[{
          ProgressBar;
          id="spb2";
          layout_height="2dp";
          layout_width="-1";
          style="?android:attr/progressBarStyleHorizontal";
          max=100;
        };]]
        {
          LinearLayout;
          layout_height="-1";
          layout_width="-1";
          gravity="center";
          orientation="vertical";
          onClick=function()end;
          {
            LinearLayout;
            id="spb";
            layout_height="48dp";
            layout_width="48dp";
          };
          {
            TextView;
            text="加载中…";
            textColor=textc;
            textSize="14sp";
            id="jztitle";
            gravity="center";
            layout_width="-2";
            layout_height="-2";
            Typeface=字体("product");
            paddingTop="8dp";
          };
        };
      };
    };
  };

  设置视图(layout)

  波纹({back,more},"圆主题")

  图标注释(back,"返回")
  图标注释(more,"更多")

  web.removeView(web.getChildAt(0))

  import "org.jsoup.*"

  web.loadUrl(pageurl)--加载网页

  function 加载动画(n)
    jztitle.Text=n
    控件可见(jzdh)
  end

  function 设置值(anm)
    import "android.graphics.Paint$Align"
    import "android.graphics.Paint$FontMetrics"
    local myLuaDrawable=LuaDrawable(function(mCanvas,mPaint,mDrawable)

      --获取控件宽和高的最小值
      local r=math.min(mDrawable.getBounds().right,mDrawable.getBounds().bottom)

      --画笔属性
      mPaint.setColor(转0x(primaryc))
      mPaint.setAntiAlias(true)
      mPaint.setStrokeWidth(r/8)
      mPaint.setStyle(Paint.Style.STROKE)
      --mPaint.setStrokeCap(Paint.Cap.ROUND)

      local mPaint2=Paint()
      mPaint2.setColor(转0x(primaryc))
      mPaint2.setAntiAlias(true)
      mPaint2.setStrokeWidth(r/2)
      mPaint2.setStyle(Paint.Style.FILL)
      mPaint2.setTextAlign(Paint.Align.CENTER)
      mPaint2.setTextSize(sp2px(14))

      --圆弧绘制坐标范围:左上坐标,右下坐标

      return function(mCanvas)
        local n=anm*360/100

        local fontMetrics = mPaint2.getFontMetrics();
        local top = fontMetrics.top;--为基线到字体上边框的距离,即上图中的top
        local bottom = fontMetrics.bottom;--为基线到字体下边框的距离,即上图中的bottom

        local baseLineY =r/2 - top/2 - bottom/2

        if anm==100 then
          mCanvas.drawText("完成",r/2,baseLineY,mPaint2);
         else
          mCanvas.drawText(tostring(anm),r/2,baseLineY,mPaint2);
        end

        mCanvas.drawArc(RectF(r/8/2,r/8/2,r-r/8/2,r-r/8/2),-90,n,false,mPaint)

        --mDrawable.invalidateSelf()
      end
    end)

    --绘制的Drawble设置成控件背景
    spb.background=myLuaDrawable
  end

  --PopupWindow
  Popup_layout={
    LinearLayout;
    {
      CardView;
      CardElevation="6dp";
      CardBackgroundColor=backgroundc;
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="8dp";
      {
        GridView;
        layout_height="-1";
        layout_width="-1";
        NumColumns=1;
        id="Popup_list";
      };
    };
  };

  pop=PopupWindow(activity)
  pop.setContentView(loadlayout(Popup_layout))
  pop.setWidth(dp2px(192))
  pop.setHeight(-2)

  pop.setOutsideTouchable(true)
  pop.setBackgroundDrawable(ColorDrawable(0x00000000))

  pop.onDismiss=function()
  end

  Popup_list_item={
    LinearLayout;
    layout_width="-1";
    layout_height="48dp";
    {
      TextView;
      id="popadp_text";
      textColor=textc;
      layout_width="-1";
      layout_height="-1";
      textSize="14sp";
      gravity="left|center";
      paddingLeft="16dp";
      Typeface=字体("product");
    };
  };

  popadp=LuaAdapter(activity,Popup_list_item)

  Popup_list.setAdapter(popadp)

  popadp.add{popadp_text="刷新",}
  popadp.add{popadp_text="前进",}
  popadp.add{popadp_text="后退",}
  popadp.add{popadp_text="停止加载",}
  popadp.add{popadp_text="浏览器打开",}

  Popup_list.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(parent, v, pos,id)
      pop.dismiss()
      local s=v.Tag.popadp_text.Text
      if s=="刷新" then
        web.reload()
      end
      if s=="前进" then
        web.goForward()
      end
      if s=="后退" then
        web.goBack()
      end
      if s=="停止加载" then
        web.stopLoading()
      end
      if s=="浏览器打开" then
        浏览器打开(web.getUrl())
      end
      if s=="分享" then
        local intent=Intent(Intent.ACTION_SEND);
        intent.setType("text/plain");
        intent.putExtra(Intent.EXTRA_SUBJECT, "分享");
        lx=""
        if wurl:match("?(.-).htm") then
          if wurl:match("?(.-).htm"):find("thread") then
            lx="分享帖子：\n"
          end
          if wurl:match("?(.-).htm"):find("forum") then
            lx="分享板块：\n"
          end
          if wurl:match("?(.-).htm"):find("user") or wurl:match("?(.-).htm"):find("my") then
            lx="分享用户：\n"
          end
        end
        if web.getTitle():match("(.+)-MLuaForum") then
          intent.putExtra(Intent.EXTRA_TEXT, lx..web.getTitle():match("(.+)-MLuaForum").."\n"..web.getUrl());
         else
          intent.putExtra(Intent.EXTRA_TEXT, lx..web.getTitle():gsub("个人中心","我").."\n"..web.getUrl());
        end
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        activity.startActivity(Intent.createChooser(intent,"分享到:"));
        lx=nil
      end
    end
  })

  import "com.lua.*"

  静态渐变(转0x(primaryc)-转0x("#9f000000"),转0x(primaryc),webprogress,"横")

  web.setWebChromeClient(LuaWebChrome(LuaWebChrome.IWebChrine{
    onProgressChanged=function(view, newProgress)
      设置值(newProgress)
      local lpm=webprogress.getLayoutParams()
      lpm.width=newProgress*(activity.Width/100)
      webprogress.setLayoutParams(lpm)
    end,
  }));

  web.setWebViewClient{
    shouldOverrideUrlLoading=function(view,url)
      wurl=url
      控件隐藏(https)
      --Url即将跳转
      if wurl=="about_blank" then
       else
      end
      控件隐藏(https)
      title.setText("加载中，请稍等 ( ･ิω･ิ)")
    end,
    onPageStarted=function(view,url,favicon)
      控件可见(webprogress)
      wurl=url
      --网页加载
      title.setText("加载中，请稍等 ( ･ิω･ิ)")
      if wurl:match("uisdc.com/(.+)") then
        加载动画("正在努力排版中…")
       elseif wurl:match("mukapp.top/(.+)") then
        控件隐藏(jzdh)
       else
        加载动画("正在努力加载中…")
      end
    end,
    onPageFinished=function(view,url)
      控件隐藏(webprogress)
      wurl=url
      if wurl:sub(1,8)=="https://" then
        https.setImageBitmap(loadbitmap(图标("https")))
        https.setColorFilter(0xff4CAF50)
       else
        https.setColorFilter(0x9f000000)
        https.setImageBitmap(loadbitmap(图标("info")))
      end
      if wurl:match("uisdc.com/(.+)") then
        for v in string.gmatch([[
          document.querySelector('.header').style.display="none";
          document.querySelector('.topShow').style.display="none";
          document.querySelector('.header').style.display="none";
          document.querySelector('.icon-fire').style.display="none";
          document.querySelector('.post-meta').style.display="none";
          document.querySelector('.img-zoom').style.display="none";
          document.querySelector('.article-bt').style.display="none";
          document.querySelector('.article-zan-fav').style.display="none";
          document.querySelector('.article-info').style.display="none";
          document.querySelector('.article-paged').style.display="none";
          document.querySelector('.comment-div').style.display="none";
          document.querySelector('.comment-write').style.display="none";
          document.querySelector('.comment-footer').style.display="none";
          document.querySelector('.article-tag').style.display="none";
          document.querySelector('.article-show').style.display="none";
          document.querySelector('.post-recommend').style.display="none";
          document.querySelector('.widget-show').style.display="none";
          document.querySelector('.hide_sm').style.display="none";
          document.querySelector('.post-footer').style.display="none";
          document.querySelector('.footer-fav').style.display="none";
          document.querySelector('.container').style.display="none";
          document.querySelector('.footer').innerHTML='<p style="text-align:center;">文章来自<strong><a href="https://www.uisdc.com"><span>优设-UISDC</span></a></strong></p>';
        ]],"\n(.+)\n") do
          --print(v)
          web.loadUrl([[
      javascript:(function()
        { ]]..v..[[ })()
      ]]);
        end
      end
      控件隐藏(jzdh)

      控件可见(https)
      --网页加载完成
      if web.getTitle()=="网页无法打开" then
        title.setText("啊哦，网页跑丢了…")
       else
        title.setText(web.getTitle())
      end

      popadp.clear()
      popadp.add{popadp_text="刷新",}
      popadp.add{popadp_text="前进",}
      popadp.add{popadp_text="后退",}
      popadp.add{popadp_text="停止加载",}
      popadp.add{popadp_text="浏览器打开",}
    end
  }

  web.getSettings().setSupportZoom(true);
  web.getSettings().setBuiltInZoomControls(true);
  web.getSettings().setDefaultFontSize(14);
  web.getSettings().setDisplayZoomControls(false);
  web.getSettings().setUseWideViewPort(true);
  web.getSettings().setLoadWithOverviewMode(true);
  web.getSettings().setJavaScriptEnabled(true);
  web.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
  web.getSettings().setAllowFileAccess(true);
  web.getSettings().setAppCacheEnabled(true);
  web.getSettings().setDomStorageEnabled(true);
  web.getSettings().setDatabaseEnabled(true);

  function webinfo()
    头=wurl:match("(.+)://")
    if 头==nil then
      颜色="#424242"
      头="about:blank"
      文本="空白页"
      链接=" | 空白页"
      颜色="#ff4CAF50"
      文本="当无链接时加载的空白页面"
     else
      头=头.."://"
      链接=web.getUrl():match("://(.+)")
      if 头=="https://" then
        颜色="#ff4CAF50"
        文本="您与此网站之间建立了加密链接"
       else
        颜色=stextc
        文本="您与此网站之间未建立加密链接"
      end
    end
    local gd2 = GradientDrawable()
    gd2.setColor(转0x(backgroundc))--填充
    gd2.setCornerRadii({0,0,0,0,dp2px(8),dp2px(8),dp2px(8),dp2px(8)})--圆角
    gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
    local dann={
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-2";
        Elevation="4dp";
        BackgroundDrawable=gd2;
        layout_marginBottom="24dp";
        {
          LinearLayout;
          orientation="vertical";
          layout_width="-1";
          layout_height="-1";
          {
            LinearLayout;
            layout_width="-1";
            layout_height="-2";
            {
              TextView;
              layout_width="-2";
              layout_height="-2";
              textSize="16sp";
              layout_marginTop="24dp";
              layout_marginLeft="24dp";
              Typeface=字体("product");
              Text=头;
              textColor=颜色;
              onClick=function()复制文本(web.getUrl())提示("已复制网址")end;
            };
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              textSize="16sp";
              layout_marginTop="24dp";
              layout_marginRight="24dp";
              Typeface=字体("product");
              Text=链接;
              textColor=textc;
              onClick=function()复制文本(web.getUrl())提示("已复制网址")end;
            };
          };
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="14sp";
            layout_marginBottom="24dp";
            layout_marginRight="24dp";
            layout_marginTop="8dp";
            layout_marginLeft="24dp";
            Typeface=字体("product-Bold");
            Text=文本;
            textColor=stextc;
          };
        };
      };
    };

    dl=AlertDialog.Builder(activity)
    dl.setView(loadlayout(dann))
    an=dl.show()
    local window = an.getWindow();
    window.setBackgroundDrawable(ColorDrawable(0x00000000));
    local wlp = window.getAttributes();
    wlp.gravity = Gravity.TOP;
    wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
    wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
    window.setAttributes(wlp);
  end

  function info()
    if wurl:sub(1,8)=="https://" then
      https.setImageBitmap(loadbitmap(图标("https")))
      https.setColorFilter(0xff4CAF50)
     else
      https.setColorFilter(转0x(stextc))
      https.setImageBitmap(loadbitmap(图标("info")))
    end
    webinfo()
  end

  控件隐藏(https)

  web.setDownloadListener{
    onDownloadStart=function(url, userAgent, contentDisposition, mimetype, contentLength)
      local i = Intent(Intent.ACTION_VIEW);
      i.setData(Uri.parse(url));
      activity.startActivity(i);
      提示("正在拉起系统下载器…")
    end
  };

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

function onKeyDown(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    if pop.isShowing() then
      pop.dismiss()
      return true
    end
  end
end

function onResult(name,...)
  web.reload()
end

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
