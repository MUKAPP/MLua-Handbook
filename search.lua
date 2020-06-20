require "import"
import "mods.muk"
import "com.github.ksoichiro.android.observablescrollview.*"

local debug_time_create_n=os.clock()

function onCreate()
  local edrawable = GradientDrawable()
  edrawable.setShape(GradientDrawable.RECTANGLE)
  edrawable.setColor(转0x(cardbackc))
  edrawable.setCornerRadii({dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8)});

  _layout={
    LinearLayout;
    layout_height="-1";
    layout_width="-1";
    id="_root";
    orientation="vertical";
    background=backgroundc;
    {
      LinearLayout,
      layout_width="fill",
      layout_height="56dp",
      gravity="center|left";
      id="mActionBar";
      {
        ImageView;
        src=图标("arrow_back");
        ColorFilter=primaryc;
        layout_width="32dp",
        layout_height="32dp",
        padding="4dp";
        id="_back";
        layout_margin="12dp";
        onClick=function()关闭页面()end;
      };
      {
        EditText;
        textColor=primaryc;
        textSize="14sp";
        gravity="center|left";
        Typeface=字体("product");
        SingleLine=true;
        layout_width="-1";
        layout_height="48dp";
        id="edit";
        padding="8dp";
        paddingLeft="16dp";
        paddingRight="16dp";
        layout_marginRight="16dp";
        backgroundDrawable=edrawable;
        Hint="搜点什么？";
        hintTextColor=stextc;
      };
    };
    {
      LinearLayout;
      orientation="vertical";
      layout_height="-1";
      layout_width="-1";
      id="page_home";
      {
        PageView;
        id="page_home_p";
        layout_weight="1";
        layout_height="-1";
        layout_width="-1";
        pages={
          {
            ListView;
            layout_width="-1";
            layout_height="-1";
            id="dmlist";
            DividerHeight=0;
            fastScrollEnabled=true;
          };
          {
            LinearLayout;--教程
            orientation="vertical";
            layout_height="-1";
            layout_width="-1";
            {
              RelativeLayout;
              layout_height="48dp";
              layout_width="-1";
              background="#00000000";
              {
                LinearLayout;
                layout_height="-1";
                layout_width="-1";
                {
                  LinearLayout;
                  layout_width=activity.getWidth()/2;
                  layout_height="-1";
                  gravity="center";
                  id="jc1";
                  onClick=function()jc.showPage(0)end;
                  {
                    TextView;
                    layout_width="-2";
                    layout_height="-2";
                    Text="文字教程";
                    Typeface=字体("product-Bold");
                    textSize="14sp";
                    textColor=primaryc;
                  };
                };
                {
                  LinearLayout;
                  layout_width=activity.getWidth()/2;
                  layout_height="-1";
                  gravity="center";
                  id="jc2";
                  onClick=function()jc.showPage(1)end;
                  {
                    TextView;
                    layout_width="-2";
                    layout_height="-2";
                    Text="视频教程";
                    Typeface=字体("product-Bold");
                    textSize="14sp";
                    textColor=stextc;
                  };
                };
              };
              {
                LinearLayout;
                layout_height="8dp";
                layout_width=activity.getWidth()/2;
                id="page_scroll";
                layout_alignParentBottom="true";
                Gravity="center";
                {
                  CardView;
                  background=primaryc;
                  elevation="0";
                  radius="4dp";
                  layout_height="8dp";
                  layout_marginTop="4dp";
                  layout_width="16dp";
                };
              };
            };
            {
              PageView;
              layout_height="-1";
              layout_width="-1";
              id="jc";
              pages={
                {
                  ListView;
                  layout_height="-1";
                  layout_width="-1";
                  DividerHeight=0;
                  fastScrollEnabled=true;
                  id="jclist";
                };
                {
                  ListView;
                  layout_height="-1";
                  layout_width="-1";
                  DividerHeight=0;
                  fastScrollEnabled=true;
                  id="spjc";
                };
              };
            };
          };
        };
      };
      {
        LinearLayout;--底栏
        orientation="horizontal";
        layout_height="56dp";
        layout_width="-1";
        gravity="center|left";
        background=backgroundc;
        elevation="6dp";
        id="mBottomBar";
        {
          LinearLayout;--底栏-示例
          orientation="vertical";
          layout_height="-1";
          layout_width="-1";
          id="page1";
          gravity="center";
          layout_weight="1";
          onClick=function()page_home_p.showPage(0)end;
          {
            ImageView;
            layout_height="24dp";
            layout_width="24dp";
            src=图标("code");
            ColorFilter=primaryc;
            PivotX="12dp";
            PivotY="24dp";
          };
          {
            TextView;
            textSize="14sp";
            Text="代码";
            textColor=primaryc;
          };
        };
        {
          LinearLayout;--底栏-示例
          orientation="vertical";
          layout_height="-1";
          layout_width="-1";
          id="page2";
          gravity="center";
          layout_weight="1";
          onClick=function()page_home_p.showPage(1)end;
          {
            ImageView;
            layout_height="24dp";
            layout_width="24dp";
            src=图标("book");
            ColorFilter=stextc;
            PivotX="12dp";
            PivotY="24dp";
          };
          {
            TextView;
            textSize="14sp";
            Text="教程";
            textColor=stextc;
          };
        };
      };
    }
  }

  设置视图(_layout)

  图标注释(_back,"返回")

  波纹({_back,page1,page2,jc1,jc2},"圆主题")

  function nocase(s)
    return string.gsub(s,"%a",function(c)
      return string.format("[%s%s]", string.lower(c),string.upper(c))
    end)
  end

  function showD(id)--主页底栏项目高亮动画
    local kidt=id.getChildAt(0)
    local kidw=id.getChildAt(1)
    local animatorSet = AnimatorSet()
    local tscaleX = ObjectAnimator.ofFloat(kidt, "scaleX", {kidt.scaleX, 1.0})
    local tscaleY = ObjectAnimator.ofFloat(kidt, "scaleY", {kidt.scaleY, 1.0})
    local wscaleX = ObjectAnimator.ofFloat(kidw, "scaleX", {kidw.scaleX, 1.0})
    local wscaleY = ObjectAnimator.ofFloat(kidw, "scaleY", {kidw.scaleY, 1.0})
    animatorSet.setDuration(256)
    animatorSet.setInterpolator(DecelerateInterpolator());
    animatorSet.play(tscaleX).with(tscaleY).with(wscaleX).with(wscaleY)
    animatorSet.start();
  end

  function closeD(id)--主页底栏项目灰色动画
    local gkidt=id.getChildAt(0)
    local gkidw=id.getChildAt(1)
    local ganimatorSet = AnimatorSet()
    local gtscaleX = ObjectAnimator.ofFloat(gkidt, "scaleX", {gkidt.scaleX, 0.9})
    local gtscaleY = ObjectAnimator.ofFloat(gkidt, "scaleY", {gkidt.scaleY, 0.9})
    local gwscaleX = ObjectAnimator.ofFloat(gkidw, "scaleX", {gkidw.scaleX, 0.9})
    local gwscaleY = ObjectAnimator.ofFloat(gkidw, "scaleY", {gkidw.scaleY, 0.9})
    ganimatorSet.setDuration(256)
    ganimatorSet.setInterpolator(DecelerateInterpolator());
    ganimatorSet.play(gtscaleX).with(gtscaleY).with(gwscaleX).with(gwscaleY)
    ganimatorSet.start();
  end

  --主页pageview
  page_home_p.setOnPageChangeListener(PageView.OnPageChangeListener{
    onPageScrolled=function(a,b,c)
    end,
    onPageSelected=function(v)
      local x=primaryc
      local c=stextc
      local c1=c
      local c2=c
      if v==0 then
        c1=x
        showD(page1)
        closeD(page2)
      end
      if v==1 then
        c2=x
        showD(page2)
        closeD(page1)
      end
      page1.getChildAt(0).setColorFilter(转0x(c1))
      page2.getChildAt(0).setColorFilter(转0x(c2))
      page1.getChildAt(1).setTextColor(转0x(c1))
      page2.getChildAt(1).setTextColor(转0x(c2))
    end
  })

  jc.setOnPageChangeListener(PageView.OnPageChangeListener{
    onPageScrolled=function(a,b,c)
      local w=activity.getWidth()/2
      local wd=c/2
      if a==0 then
        page_scroll.setX(wd)
      end
      if a==1 then
        page_scroll.setX(wd+w)
      end
    end,
    onPageSelected=function(v)
      local x=primaryc
      local c=stextc
      local c1=c
      local c2=c
      if v==0 then
        c1=x
      end
      if v==1 then
        c2=x
      end
      jc1.getChildAt(0).setTextColor(转0x(c1))
      jc2.getChildAt(0).setTextColor(转0x(c2))
    end
  })

  dmitem={
    LinearLayout;
    layout_width="-1";
    layout_height="-2";
    orientation="vertical";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=cardbackc;
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        orientation="vertical";
        padding="16dp";
        {
          TextView;
          textColor=textc;
          textSize="16sp";
          gravity="center|left";
          Typeface=字体("product");
          id="_title";
        };
        {
          TextView;
          --textColor=stextc;
          --textSize="12sp";
          --gravity="center|left";
          --Typeface=字体("product");
          --layout_marginTop="12dp";
          id="_text";
          --maxLines=3;
          layout_width="0";
          layout_height="0";
        };
      };
    };
  };

  dmdata={}

  dmadp=LuaAdapter(activity,dmdata,dmitem)

  dmlist.setAdapter(dmadp)

  if activity.getSharedData("code")==nil then
    activity.setSharedData("code","")
  end
  if activity.getSharedData("tutorial")==nil then
    activity.setSharedData("tutorial","")
  end
  if activity.getSharedData("video")==nil then
    activity.setSharedData("video","")
  end

  function 获取代码(str)
    dmdata={}
    dmadp=LuaAdapter(activity,dmdata,dmitem)
    dmlist.setAdapter(dmadp)
    content=activity.getSharedData("code"):gsub("<br>","")
    for v in content:gmatch("@{(.-)}@") do
      if v:match("==#(.-)")==nil then
        if v:find(nocase(str))~=nil then
          dmdata[#dmdata+1]={_title=v:match("(.+){@!"),_text=v:match("{@!\n(.+)")}
        end
      end
    end
    dmadp.notifyDataSetChanged()
  end
  获取代码("")

  dmlist.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(id,v,zero,one)
      local s=v.Tag._text.Text
      activity.newActivity("view-code",{v.Tag._title.Text,v.Tag._text.Text})
    end})

  jcdata={}

  jcadp=LuaAdapter(activity,jcdata,dmitem)

  jclist.setAdapter(jcadp)

  function 获取教程(str)
    jcdata={}
    jcadp=LuaAdapter(activity,jcdata,dmitem)
    jclist.setAdapter(jcadp)

    content=activity.getSharedData("tutorial"):gsub("<br>","")
    for v in content:gmatch("@{(.-)}@") do
      if v:match("==#(.-)")==nil then
        if v:find(nocase(str))~=nil then
          jcdata[#jcdata+1]={_title=v:match("(.+){@!"),_text=v:match("{@!\n(.+)")}
        end
      end
    end
    jcadp.notifyDataSetChanged()
  end
  获取教程("")

  jclist.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(id,v,zero,one)
      activity.newActivity("view-tutorial",{v.Tag._title.Text,one,jcdata})
    end})

  spdata={}

  spadp=LuaAdapter(activity,spdata,dmitem)

  spjc.setAdapter(spadp)

  function 获取视频教程(str)
    spdata={}
    spadp=LuaAdapter(activity,spdata,dmitem)
    spjc.setAdapter(spadp)

    content=activity.getSharedData("video"):gsub("<br>","")
    for v in content:gmatch("{(.-)}") do
      if v:match("==#(.-)")==nil then
        if v:find(nocase(str))~=nil then
          spdata[#spdata+1]={_title=v:match("(.+) | "),_text=v:match(" | (.+)")}
        end
      end
    end
    spadp.notifyDataSetChanged()
  end
  获取视频教程("")

  spjc.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(id,v,zero,one)
      activity.newActivity("video-play",{v.Tag._text.Text})
    end})

  edit.addTextChangedListener{
    onTextChanged=function(s)
      if edit.Text=="" then
      end
      获取代码(edit.Text)
      获取教程(edit.Text)
      获取视频教程(edit.Text)
    end}

  listalpha=AlphaAnimation(0,1)
  listalpha.setDuration(256)
  controller=LayoutAnimationController(listalpha)
  controller.setDelay(0.4)
  controller.setOrder(LayoutAnimationController.ORDER_NORMAL)
  page_home.setLayoutAnimation(controller)
  dmlist.setLayoutAnimation(controller)

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
    local linearParams = edit.getLayoutParams()
    linearParams.height=dp2px(40)
    edit.setLayoutParams(linearParams)
    local linearParams = mBottomBar.getLayoutParams()
    linearParams.height=dp2px(48)
    mBottomBar.setLayoutParams(linearParams)
   else
    Activity_Multi=nil
    local linearParams = mActionBar.getLayoutParams()
    linearParams.height=dp2px(56)
    mActionBar.setLayoutParams(linearParams)
    local linearParams = edit.getLayoutParams()
    linearParams.height=dp2px(48)
    edit.setLayoutParams(linearParams)
    local linearParams = mBottomBar.getLayoutParams()
    linearParams.height=dp2px(56)
    mBottomBar.setLayoutParams(linearParams)
  end
end