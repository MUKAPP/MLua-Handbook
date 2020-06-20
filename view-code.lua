require "import"
import "mods.muk"
JSON=import "mods.json"

_title,_content=...

local debug_time_create_n=os.clock()

function onCreate()
  if _title==nil then
    _title="代码调试"
  end
  if _content==nil then
    _content="--代码调试自带xpcall\n\n\n"
  end

  layout=
  {
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    orientation="vertical";
    background=backgroundc;
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
        text=_title;
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
      RelativeLayout;
      layout_width="-1";
      background=backgroundc;
      layout_height="-1";
      id="_root";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        orientation="vertical";
        --[[{
          CardView;
          CardElevation="0dp";
          CardBackgroundColor=cardbackc;
          Radius="8dp";
          layout_width="-1";
          layout_height="-2";
          layout_margin="16dp";
          layout_marginTop="8dp";
          layout_marginBottom="72dp";]]
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-1";
          orientation="vertical";
          background=cardbackc;
          --padding="16dp";
          {
            LuaEditor;
            text=_content;
            textColor=textc;
            layout_width="-1";
            layout_height="-1";
            id="editor";
            --textSize="14sp";
            --Typeface=字体("product");
            --paddingLeft="32dp";
          };
        };
        --};
        --};
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        orientation="vertical";
        gravity="bottom|right";
        paddingBottom="80dp";
        {
          CardView;
          layout_width="-2";
          layout_height="42%h";
          radius="20dp";
          layout_margin="8dp";
          layout_marginBottom="8dp";
          Elevation="1dp";
          background=barbackgroundc;
          id="opi";
          {
            LinearLayout;
            layout_width="40dp";
            layout_height="-1";
            background="#00ffffff";
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-1";
              gravity="left|center";
              layout_marginTop="8dp";
              orientation="vertical";
              layout_marginBottom="8dp";
              {
                ImageView;
                src=图标("select_all");
                layout_height="-2";
                layout_width="-1";
                layout_weight="1";
                padding="10dp";
                colorFilter=textc;
                id="qx";
              };
              {
                ImageView;
                src=图标("crop");
                layout_height="-2";
                layout_width="-1";
                layout_weight="1";
                padding="10dp";
                colorFilter=textc;
                id="jq";
              };
              {
                ImageView;
                src=图标("file_copy");
                layout_height="-2";
                layout_width="-1";
                layout_weight="1";
                padding="10dp";
                colorFilter=textc;
                id="fz";
              };
              {
                ImageView;
                src=图标("assignment");
                layout_height="-2";
                layout_width="-1";
                layout_weight="1";
                padding="10dp";
                colorFilter=textc;
                id="zt";
              };
              {
                ImageView;
                src=图标("close");
                layout_height="-2";
                layout_width="-1";
                layout_weight="1";
                padding="10dp";
                colorFilter=textc;
                id="gb";
              };
            };
          };
        };
      };
      {
        RelativeLayout,
        layout_width="-1",
        layout_height="-1",
        id="llb",
        gravity="bottom";
        {
          RelativeLayout,
          layout_width="fill",
          layout_height="56dp",
          clickable="true",
          id="ll",
          {
            LinearLayout;
            layout_width="-1";
            layout_height="-1";
            gravity="left|center";
            paddingLeft="8dp";
            paddingRight="8dp";
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-2";
              layout_weight="1";
              id="undo";
              onClick=function()editor.undo()end;
              gravity="center";
              {
                ImageView;
                src=图标("undo");
                layout_height="24dp";
                layout_width="24dp";
                colorFilter=textc;
              };
            };
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-2";
              layout_weight="1";
              id="redo";
              onClick=function()editor.redo()end;
              gravity="center";
              {
                ImageView;
                src=图标("redo");
                layout_height="24dp";
                layout_width="24dp";
                colorFilter=textc;
              };
            };
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-2";
              layout_weight="1";
              id="share";
              onClick=function()share()end;
              gravity="center";
              {
                ImageView;
                src=图标("open_in_new");
                layout_height="24dp";
                layout_width="24dp";
                colorFilter=textc;
              };
            };
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-2";
              layout_weight="1";
              id="format";
              onClick=function()editor.format()end;
              gravity="center";
              {
                ImageView;
                src=图标("format_align_left");
                layout_height="24dp";
                layout_width="24dp";
                colorFilter=textc;
              };
            };
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-2";
              layout_weight="1";
              id="play";
              onClick=function()
                local _, data = loadstring(tostring(editor.Text))
                if data then
                  local _, _, line, data = data:find(".(%d+).(.+)")
                  editor.gotoLine(tonumber(line))
                  双按钮对话框("语法错误",
                  "第"..line.."行,"..data,
                  "好的",
                  "Google翻译",
                  function()
                    关闭对话框(an)
                  end,
                  function()
                    双按钮对话框内容("正在翻译…")
                    翻译(data,function(n)
                      pcall(function()双按钮对话框内容(JSON.decode(n)[1][1][1])end)
                    end)
                  end)
                  return true
                end
                跳转页面("code-play",{editor.Text})
              end;
              gravity="center";
              {
                ImageView;
                src=图标("play_arrow");
                layout_height="24dp";
                layout_width="24dp";
                colorFilter=textc;
              };
            };
            {
              TextView;
              layout_height="-1";
              layout_width="56dp";
              layout_marginRight="20dp";
              layout_marginLeft="8dp";
              --background=grayc;
            };
          };
        };
      },
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        orientation="vertical";
        gravity="right|bottom";
        {
          CardView;
          layout_width="56dp",
          layout_height="56dp",
          radius="28dp";
          layout_margin="28dp";
          CardBackgroundColor=backgroundc;
          elevation="0";
          translationZ="4dp";
          alpha=1;
          id="xf1";
          {
            ImageView;
            src=图标("file_copy");
            layout_height="-1";
            layout_width="-1";
            padding="16dp";
            colorFilter=primaryc;
            id="copy";
            onClick=function()复制文本(editor.Text)Snakebar("已复制代码","100dp")end;
          };
        };
      };
    };

  }

  activity.setContentView(loadlayout(layout))

  波纹({fh},"圆主题")
  波纹({copy},"方主题")
  波纹({undo,redo,share,format,play,qx,jq,fz,zt,gb},"圆自适应")

  图标注释(fh,"返回")
  图标注释(copy,"复制")
  图标注释(undo,"撤销")
  图标注释(redo,"重做")
  图标注释(share,"分享")
  图标注释(format,"格式化")
  图标注释(play,"运行")

  if _content=="" then
    控件隐藏(share)
  end

  local myLuaDrawable=LuaDrawable(function(mCanvas,mPaint,mDrawable)

    mPaint.setColor(转0x(backgroundc))
    mPaint.setAntiAlias(true)
    mPaint.setStrokeWidth(20)
    mPaint.setStyle(Paint.Style.FILL)
    mPaint.setStrokeCap(Paint.Cap.ROUND)

    w=mDrawable.getBounds().right
    h=mDrawable.getBounds().bottom

    mPath=Path()

    mPath.moveTo(w, h);
    mPath.lineTo(0, h);
    mPath.lineTo(0, h-dp2px(56));

    mPath.lineTo(w-dp2px(56+16+16+8), h-dp2px(56));
    mPath.rQuadTo(dp2px(8), dp2px(0),dp2px(8+1), dp2px(8))
    mPath.rCubicTo(dp2px(8-1), dp2px(28+4),dp2px(56-1), dp2px(28+4),dp2px(56+8-2), dp2px(0))
    mPath.rQuadTo(dp2px(1), dp2px(-8),dp2px(8+1), dp2px(-8))
    mPath.rLineTo(w, 0);

    mCanvas.drawColor(0x00000000)
    mCanvas.drawPath(mPath, mPaint);

    mPath.close();
  end)

  ll.background=myLuaDrawable

  local myLuaDrawable=LuaDrawable(function(mCanvas,mPaint,mDrawable)

    mPaint.setColor(0x21000000)
    mPaint.setAntiAlias(true)
    mPaint.setStrokeWidth(dp2px(4))
    mPaint.setStyle(Paint.Style.FILL)
    mPaint.setStrokeCap(Paint.Cap.ROUND)

    w=mDrawable.getBounds().right
    h=mDrawable.getBounds().bottom

    mPath=Path()

    mPath.moveTo(w, h);
    mPath.lineTo(0, h);
    mPath.lineTo(0, h-dp2px(56));

    mPath.lineTo(w-dp2px(56+16+16+8), h-dp2px(56));
    mPath.rQuadTo(dp2px(8), dp2px(0),dp2px(8+1), dp2px(8))
    mPath.rCubicTo(dp2px(8-1), dp2px(28+4),dp2px(56-1), dp2px(28+4),dp2px(56+8-2), dp2px(0))
    mPath.rQuadTo(dp2px(1), dp2px(-8),dp2px(8+1), dp2px(-8))
    mPath.rLineTo(w, 0);

    mCanvas.drawColor(0x00000000)
    if 全局主题值=="Night" then
      mPaint.setShadowLayer(dp2px(1), 0, dp2px(-1), 0x70000000);
     else
      mPaint.setShadowLayer(dp2px(1), 0, dp2px(-1), 0x70FFFFFF);
    end

    mCanvas.drawPath(mPath, mPaint);

    mPath.close();
  end)

  llb.background=myLuaDrawable

  editor.OnSelectionChangedListener=function(status,Start,End)
    ed=End
    if status == true then--判断是否选中
      if jtbkg then
       else
        kjtb()
      end
     else
      if sskz then
       else
        theY=nil
        gjtb()
      end
    end
  end

  --全选
  qx.onClick = function()
    editor.selectAll()
  end

  --剪切
  jq.onClick = function()
    editor.cut()
    gjtb()
  end

  --复制
  fz.onClick = function()
    editor.copy()
    gjtb()
  end

  --粘贴
  zt.onClick = function()
    editor.paste()
    gjtb()
  end

  --关闭
  gb.onClick = function()
    editor.setSelection(ed)
    gjtb()
  end

  opi.Visibility=8

  function kjtb(lx)
    jtbkg=true
    if lx==nil then
      控件可见(qx)
      控件可见(gb)
     else
      控件隐藏(qx)
      控件隐藏(gb)
    end
    opi.setVisibility(View.VISIBLE)
    opi.startAnimation(AlphaAnimation(0,1).setDuration(256).setAnimationListener(AnimationListener{
      onAnimationEnd=function()
      end}))
  end

  function gjtb()
    jtbkg=false
    opi.startAnimation(AlphaAnimation(1,0).setDuration(256).setAnimationListener(AnimationListener{
      onAnimationEnd=function()
        opi.setVisibility(View.GONE)
      end}))
  end

  activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE|WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

  editor.setBasewordColor(转0x(primaryc))
  editor.setDrawingCacheBackgroundColor(转0x(stextc))
  editor.setPanelBackgroundColor(转0x(barbackgroundc))
  editor.setPanelTextColor(转0x(textc))
  editor.setStringColor(转0x("#ff4081"))
  editor.setTextColor(转0x(textc))
  editor.setTextHighlightColor(转0x(stextc))
  editor.setUserwordColor(转0x("#009688"))
  if 全局主题值=="Day" then
    editor.setCommentColor(转0x("#7f212121"))
   elseif 全局主题值=="Night" then
    editor.setCommentColor(转0x("#9fffffff"))
  end
  editor.setTextSize(sp2px(14))

  editor.format()

  function share()
    text="  -- ".._title.." --  \n".._content.."\n--MLua手册--"
    intent=Intent(Intent.ACTION_SEND);
    intent.setType("text/plain");
    intent.putExtra(Intent.EXTRA_SUBJECT, "分享".._title.."代码");
    intent.putExtra(Intent.EXTRA_TEXT, text);
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    activity.startActivity(Intent.createChooser(intent,"将".._title.."分享到:"));
  end

  copy.setOnTouchListener({
    onTouch=function(v,n)
      if tostring(n):find("ACTION_DOWN") then
        ObjectAnimator.ofFloat(xf1, "translationZ", {xf1.translationZ, dp2px(8)})
        .setDuration(128)--设置动画时间
        .setInterpolator(DecelerateInterpolator())--设置动画插入器，减速
        .start()
       elseif tostring(n):find("ACTION_UP") then
        ObjectAnimator.ofFloat(xf1, "translationZ", {xf1.translationZ, dp2px(4)})
        .setDuration(128)--设置动画时间
        .setInterpolator(AccelerateInterpolator())--设置动画插入器，减速
        .start()
      end
    end})

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
