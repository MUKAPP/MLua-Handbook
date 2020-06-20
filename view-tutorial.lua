require "import"
import "mods.muk"
import "com.github.ksoichiro.android.observablescrollview.*"--导入ObservableScrollView，容易监听滑动
JSON=import "mods.json"

_title,_code,_table=...

local debug_time_create_n=os.clock()

function onCreate()
  layout={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    orientation="vertical";

    {
      LinearLayout;
      layout_width="-1";
      layout_height="-2";
      elevation="0";
      background=backgroundc;
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
    };
    {
      RelativeLayout;
      layout_width="-1";
      background=backgroundc;
      layout_height="-1";
      id="_root";
      {
        ObservableScrollView;
        layout_width="-1";
        layout_height="-1";
        id="obs";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-1";
          orientation="vertical";
          --paddingBottom="48dp";
          {
            CardView;
            CardElevation="0dp";
            CardBackgroundColor=cardbackc;
            Radius="8dp";
            layout_width="-1";
            layout_height="-2";
            layout_margin="16dp";
            layout_marginTop="8dp";
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-1";
              orientation="vertical";
              padding="16dp";
              --[[{
                TextView;
                text="页面信息";
                textColor=textc;
                textSize="16sp";
                gravity="center|left";
                Typeface=字体("product-Bold");
              };]]
              {
                LinearLayout;
                layout_width="-1";
                layout_height="-1";
                orientation="vertical";
                --layout_marginTop="12dp";
                id="activity_rule";
              };
            };
          };
        };
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        gravity="bottom|center";
        id="_bottombar";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="48dp";
          gravity="left|center";
          paddingLeft="8dp";
          paddingRight="8dp";
          background=backgroundc;
          elevation="6dp";
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-2";
            layout_weight="1";
            id="undo";
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
            TextView;
            text="页面信息";
            textColor=stextc;
            textSize="14sp";
            gravity="center|left";
            Typeface=字体("product-Bold");
            id="ym";
          };
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-2";
            layout_weight="1";
            id="redo";
            gravity="center";
            {
              ImageView;
              src=图标("redo");
              layout_height="24dp";
              layout_width="24dp";
              colorFilter=textc;
            };
          };
        };
      };
    };

  };

  设置视图(layout)

  波纹({fh},"圆主题")
  波纹({undo,redo},"圆自适应")

  图标注释(fh,"返回")
  图标注释(undo,"上一篇")
  图标注释(redo,"下一篇")

  --obs.scrollVerticallyTo(int)
  --print(obs.getCurrentScrollY())

  undo.onClick=function()
    if _code<=1 then
      Snakebar("现在已经是第一篇啦")
      return true
    end
    跳转页面("view-tutorial",{_table[_code-1]._title,_code-1,_table})
    关闭页面()
  end

  redo.onClick=function()
    if _code>=#_table then
      Snakebar("现在已经是最后一篇啦")
      return true
    end
    跳转页面("view-tutorial",{_table[_code+1]._title,_code+1,_table})
    关闭页面()
  end

  if _title~="更新日志" then
    _content=_table[_code]._text
    ym.Text=_code.."/"..tostring(#_table)

    obs.setScrollViewCallbacks(ObservableScrollViewCallbacks{
      --滚动时
      onScrollChanged=function(scrollY,firstScroll,dragging)
        --print(scrollY,firstScroll,dragging)
        obs2_lst=scrollY
        -- param scrollY 在Y轴滚动位置。
        -- firstScroll 是否是第一次（刚开始）滑动
        -- dragging 当前视图是否是因为拖拽而产生滑动
      end,

      --按下
      onDownMotionEvent=function()
        --print("按下")
      end,

      --拖拽结束或者取消时
      onUpOrCancelMotionEvent=function(scrollState)
        --print(scrollState)
        if(scrollState==ScrollState.DOWN) then
          --print("向下滚动1");
          translationUp = ObjectAnimator.ofFloat(_bottombar, "Y",{_bottombar.getY(), 0})
          translationUp.setInterpolator(DecelerateInterpolator())
          translationUp.setDuration(256)
          translationUp.start()
          obs_p_bot = obs.getChildAt(obs.getChildCount()-1)
          .getBottom()-(obs.getHeight()+obs2_lst)
          if (obs_p_bot==0) then
            --[[if _code>=#_table then
          Snakebar("现在已经是最后一篇啦")
          return true
        end
        跳转页面("view-tutorial",{_table[_code+1]._title,_code+1,_table})
        关闭页面()]]
          end
         elseif(scrollState==ScrollState.UP) then
          if obs2_lst>=5 then
            --print("向上滚动");
            translationUp = ObjectAnimator.ofFloat(_bottombar, "Y",{_bottombar.getY(),dp2px(48)})
            translationUp.setInterpolator(DecelerateInterpolator())
            translationUp.setDuration(256)
            translationUp.start()
           else
            --print("向下滚动2");
            translationUp = ObjectAnimator.ofFloat(_bottombar, "Y",{_bottombar.getY(), 0})
            translationUp.setInterpolator(DecelerateInterpolator())
            translationUp.setDuration(256)
            translationUp.start()
          end
         else
          --print("停止滚动");
        end
      end
    })

   else
    _content=_code
    控件隐藏(_bottombar)
  end

  if _content:find("%<muktc%?%>")~=nil then
    json=JSON.decode(_content:match("%<muktc%?%>(.+)"))

    for i,v in ipairs(json) do
      --print(v)
      if v=="k" then
        local titletext={
          LinearLayout;
          layout_width="-1";
          layout_height="16dp";
        }
        activity_rule.addView(loadlayout(titletext))
      end
      if v[1]=="p" then
        if v[3]=="BIG" then
          local titletext={
            LinearLayout;
            layout_width="-1";
            layout_height="-2";
            --orientation="vertical";
            gravity="left|center";
            {
              TextView;
              text=v[2];
              textColor=textc;
              textSize="20sp";
              gravity="center|left";
              Typeface=字体("product-Bold");
            };
          }
          activity_rule.addView(loadlayout(titletext))
         elseif v[3]=="REG" then
          local titletext={
            LinearLayout;
            layout_width="-1";
            layout_height="-2";
            --orientation="vertical";
            gravity="left|center";
            {
              TextView;
              text=v[2];
              textColor=textc;
              textSize="16sp";
              gravity="center|left";
              Typeface=字体("product-Bold");
            };
          }
          activity_rule.addView(loadlayout(titletext))
         elseif v[3]=="BOLD" then
          local titletext={
            LinearLayout;
            layout_width="-1";
            layout_height="-2";
            --orientation="vertical";
            gravity="left|center";
            {
              TextView;
              text=v[2];
              textColor=textc;
              textSize="14sp";
              gravity="center|left";
              Typeface=字体("product-Bold");
            };
          }
          activity_rule.addView(loadlayout(titletext))
         elseif v[3]=="COM" then
          local titletext={
            LinearLayout;
            layout_width="-1";
            layout_height="-2";
            --orientation="vertical";
            gravity="left|center";
            {
              TextView;
              text=v[2];
              textColor=stextc;
              textSize="12sp";
              gravity="center|left";
              Typeface=字体("product");
            };
          }
          activity_rule.addView(loadlayout(titletext))
         else
          local titletext={
            LinearLayout;
            layout_width="-1";
            layout_height="-2";
            --orientation="vertical";
            gravity="left|center";
            {
              TextView;
              text=v[2];
              textColor=textc;
              textSize="14sp";
              gravity="center|left";
              Typeface=字体("product");
            };
          }
          activity_rule.addView(loadlayout(titletext))
        end
      end
      if v[1]=="c" then
        local titletext={
          LinearLayout;
          layout_width="-1";
          layout_height="-2";
          {
            CardView;
            CardElevation="1dp";
            CardBackgroundColor=stextc;
            Radius="4dp";
            layout_width="-1";
            layout_height="-2";
            layout_margin="4dp";
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-1";
              orientation="vertical";
              gravity="left|center";
              {
                TextView;
                text=v[2];
                textColor=stextc;
                textSize="12sp";
                gravity="center|right";
                Typeface=字体("product");
                background=grayc;
                layout_width="-1";
                layout_height="-2";
                padding="4dp";
                paddingRight="8dp";
              };
              {
                TextView;
                text=v[3];
                textColor=backgroundc;
                textSize="14sp";
                gravity="center|left";
                Typeface=字体("product");
                --background=textc;
                layout_width="-1";
                layout_height="-2";
                padding="8dp";
                textIsSelectable=true;
              };
            };
            {
              TextView;
              text="复制代码";
              textColor=stextc;
              textSize="12sp";
              gravity="center|left";
              Typeface=字体("product");
              layout_width="-1";
              layout_height="-2";
              padding="4dp";
              paddingLeft="8dp";
            };
            {
              TextView;
              text=v[3];
              textColor="#00000000";
              layout_width="-1";
              layout_height="-1";
              BackgroundDrawable=(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})));
              onClick=function(v)复制文本(v.text)Snakebar("已复制代码")end;
            };
          };
        }
        activity_rule.addView(loadlayout(titletext))
      end
      if v[1]=="y" then
        local titletext={
          LinearLayout;
          layout_width="-1";
          layout_height="-2";
          {
            CardView;
            CardElevation="1dp";
            CardBackgroundColor=grayc;
            Radius="4dp";
            layout_width="-1";
            layout_height="-2";
            layout_margin="4dp";
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-1";
              gravity="left|center";
              {
                TextView;
                background=stextc;
                layout_width="16dp";
                layout_height="-1";
              };
              {
                TextView;
                text=v[2];
                textColor=textc;
                textSize="14sp";
                gravity="center|left";
                Typeface=字体("product");
                layout_width="-1";
                layout_height="-2";
                padding="16dp";
                textIsSelectable=true;
              };
            };
          };
        }
        activity_rule.addView(loadlayout(titletext))
      end
      if v[1]=="f" then
        local titletext={
          LinearLayout;
          layout_width="-1";
          layout_height="-2";
          gravity="center";
          {
            TextView;
            layout_width="-1";
            layout_height="1px";
            background=stextc;
            textSize="12sp";
            layout_weight="-1";
          };
          {
            TextView;
            text=v[2];
            textColor=stextc;
            textSize="12sp";
            gravity="center";
            Typeface=字体("product");
            layout_width="-2";
            layout_height="-2";
            padding="4dp";
          };
          {
            TextView;
            layout_width="-1";
            layout_height="1px";
            background=stextc;
            textSize="12sp";
            layout_weight="-1";
          };
        }
        activity_rule.addView(loadlayout(titletext))
      end
      if v[1]=="pic" then
        local titletext={
          LinearLayout;
          layout_width="-1";
          layout_height="-2";
          orientation="vertical";
          gravity="center";
          {
            CardView;
            CardElevation="1dp";
            CardBackgroundColor=stextc;
            Radius="4dp";
            layout_width="-1";
            layout_height="-2";
            layout_margin="4dp";
            {
              ImageView;
              layout_width="-1";
              layout_height=activity.Width/2;
              background=grayc;
              src=v[2];
              scaleType="centerCrop";
            };
          };
          {
            TextView;
            text=v[3];
            textColor=stextc;
            textSize="12sp";
            gravity="center";
            Typeface=字体("product");
            layout_width="-2";
            layout_height="-2";
            padding="4dp";
            paddingBottom="8dp";
          };
        }
        activity_rule.addView(loadlayout(titletext))
      end
      if v[1]=="link" then
        local titletext={
          LinearLayout;
          layout_width="-1";
          layout_height="-2";
          gravity="left|center";
          {
            TextView;
            text=v[3];
            textColor=primaryc;
            textSize="14sp";
            gravity="center";
            Typeface=字体("product");
            layout_width="-2";
            layout_height="-2";
            padding="4dp";
            BackgroundDrawable=(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fcb82be})));
            onClick=function()浏览器打开(v[2])end;
          };
        }
        activity_rule.addView(loadlayout(titletext))
      end
      if v[1]=="copy" then
        local titletext={
          LinearLayout;
          layout_width="-1";
          layout_height="-2";
          gravity="left|center";
          {
            CardView;
            CardElevation="1dp";
            CardBackgroundColor=grayc;
            Radius="4dp";
            layout_width="-2";
            layout_height="-2";
            layout_margin="4dp";
            {
              TextView;
              text=v[3];
              textColor=textc;
              textSize="14sp";
              gravity="center";
              Typeface=字体("product");
              layout_width="-2";
              layout_height="-2";
              padding="12dp";
              paddingTop="8dp";
              paddingBottom="8dp";
              BackgroundDrawable=(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})));
              onClick=function()复制文本(v[2])Snakebar("已复制")end;
            };
          };
        }
        activity_rule.addView(loadlayout(titletext))
      end
    end
   else
    local contenttext={
      TextView;
      text=_content;
      textColor=textc;
      textSize="14sp";
      gravity="center|left";
      --Typeface=字体("product");
      --paddingLeft="32dp";
    }
    activity_rule.addView(loadlayout(contenttext))
  end

  listalpha=AlphaAnimation(0,1)
  listalpha.setDuration(256)
  controller=LayoutAnimationController(listalpha)
  controller.setDelay(0.4)
  controller.setOrder(LayoutAnimationController.ORDER_NORMAL)
  _root.setLayoutAnimation(controller)
  activity_rule.setLayoutAnimation(controller)

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
