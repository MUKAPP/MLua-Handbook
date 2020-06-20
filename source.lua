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
      title.setText("加载中，请稍等 ( ･ิω･ิ)")
    end,
    onPageStarted=function(view,url,favicon)
      控件可见(webprogress)
      控件可见(jzdh)
    end,
    onPageFinished=function(view,url)
      控件隐藏(webprogress)
      控件隐藏(jzdh)
      for v in string.gmatch([[
          document.querySelector('.mf').style.display="none";
          document.querySelector('.mdo').style.display="none";
          document.querySelector('.mft').style.display="none";
        ]],"\n(.+)\n") do
        --print(v)
        web.loadUrl([[
      javascript:(function()
        { ]]..v..[[ })()
      ]]);
      end
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

  web.setDownloadListener{
    onDownloadStart=function(url, userAgent, contentDisposition, mimetype, contentLength)
      local i = Intent(Intent.ACTION_VIEW);
      i.setData(Uri.parse(url));
      activity.startActivity(i);
      --提示("正在拉起系统下载器…")
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
