require "import"
import "mods.muk"

import "com.michael.NoScrollListView"
import "com.michael.NoScrollGridView"

local debug_time_create_n=os.clock()

if not 文件是否存在(MUKAPP文件()) then
  创建文件夹(MUKAPP文件())
end
if not 文件是否存在(MUKAPP文件("Download")) then
  创建文件夹(MUKAPP文件("Download"))
end
if not 文件是否存在(内置存储文件()) then
  创建文件夹(内置存储文件())
end
if not 文件是否存在(内置存储文件("Note")) then
  创建文件夹(内置存储文件("Note"))
end

local function jxUrl(newIntent)
  local Created_Thing=""
  local uriString = tostring(newIntent.getData())

  if "num1"==uriString then
    Created_Thing=[[ch_light("工具")
      控件隐藏(page_home)
      控件可见(page_tool)
      _title.Text="工具"]]
   elseif "num2"==uriString then
    Created_Thing=[[跳转页面("search")]]
   elseif "num3"==uriString then
    Created_Thing=[[page_home_p.showPage(3)]]
   elseif "num4"==uriString then
    Created_Thing=[[跳转页面("view-code")]]
  end

  activityContent=Created_Thing
  isShortcut="Shortcut"
end

if Build.VERSION.SDK_INT >= 25 then
  import "android.content.pm.ShortcutInfo"
  import "android.graphics.drawable.Icon"

  --创建Intent对象
  local intent1 = Intent(Intent.ACTION_MAIN);
  --ComponentName设置应用之间跳转      包名(这里直接获取程序包名),   包名+类名(AndroLua打包后还是这个)
  intent1.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent1.setData(Uri.parse("num1"));

  local intent2 = Intent(Intent.ACTION_MAIN);
  intent2.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent2.setData(Uri.parse("num2"));

  --[[local intent3 = Intent(Intent.ACTION_MAIN);
  intent3.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent3.setData(Uri.parse("num3"));]]

  local intent4 = Intent(Intent.ACTION_MAIN);
  intent4.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent4.setData(Uri.parse("num4"));

  local SHORTCUT_TABLE={
    {"ID1","工具",intent1,activity.getLuaDir(图标("inbox"))},
    {"ID2","搜索",intent2,activity.getLuaDir(图标("search"))},
    --{"ID3","社区",intent3,activity.getLuaDir(图标("chat_bubble"))},
    {"ID4","代码调试",intent4,activity.getLuaDir(图标("build"))},
  }

  --动态的Shortcut,获取ShortcutManager,快捷方式管理器
  --提供了添加,移除,更新,禁用,启动,获取静态快捷方式,获取动态快捷方式,获取固定在桌面的快捷方式等方法
  local scm = activity.getSystemService(activity.SHORTCUT_SERVICE);

  local infos = ArrayList();
  for k,v in pairs(SHORTCUT_TABLE) do
    local si = ShortcutInfo.Builder(this,v[1])
    .setIcon(Icon.createWithBitmap(loadbitmap(v[4])))
    --快捷方式添加到桌面显示的标签文本
    .setShortLabel(v[2])
    --长按图标快捷方式显示的标签文本(既快捷方式名字)
    .setLongLabel(v[2])
    .setIntent(v[3])
    .build();
    infos.add(si);
  end

  --添加快捷方式
  scm.setDynamicShortcuts(infos);

  --移除快捷方式
  --scm.removeDynamicShortcuts(infos);

  --Intent回调设置点击事件
  function onNewIntent(intent)
    newIntent=intent
    jxUrl(newIntent)
  end
end

activityContent=Created_Thing
activityContent,isShortcut=...

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
  animatorSet.play(tscaleX)
  .with(tscaleY)
  .with(wscaleX)
  .with(wscaleY)
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
  ganimatorSet.play(gtscaleX)
  .with(gtscaleY)
  .with(gwscaleX)
  .with(gwscaleY)
  ganimatorSet.start();
end

function jcpage(z)--主页
  jc.showPage(z)
end

lastclick = os.time() - 2

function onKeyDown(code,event)
  local now = os.time()
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    if pop.isShowing() then
      pop.dismiss()
      return true
    end
    if _drawer.isDrawerOpen(Gravity.LEFT) then
      _drawer.closeDrawer(Gravity.LEFT)
      return true
    end
    if now - lastclick > 2 then
      Snakebar("再按一次退出")
      lastclick = now
      return true
    end
  end
end

function 文字卡片(title,content)
  return {
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
          text=title;
          textColor=primaryc;
          textSize="16sp";
          gravity="center|left";
          Typeface=字体("product-Bold");
        };
        {
          TextView;
          text=content;
          textColor=stextc;
          textSize="14sp";
          gravity="center|left";
          --Typeface=字体("product");
          layout_marginTop="12dp";
        };
      };
    };
  };
end

function onDestroy()
  --os.exit()
end

function onCreate()
  --[[Http.get("https://www.mukapp.top/tongji/",function(code,content,cookie,header)
  end)]]

  --设置视图
  activity.setContentView(loadlayout("layout/main"))

  --沉浸状态栏
  --[[if 全局主题值=="Day" then
    沉浸状态栏(true)
   else
    沉浸状态栏()
  end]]

  local id={swipe1,swipe2,swipe3,swipe4,swipe5}
  for i=1,#id do
    id[i].setProgressViewOffset(true,0, 64)
    id[i].setColorSchemeColors({转0x(primaryc),转0x(primaryc)-0x9f000000})
    id[i].setProgressBackgroundColorSchemeColor(转0x(barbackgroundc))
  end
  id=nil

  波纹({_menu,_more,page1,page2,page3,page4,jc1,jc2,mbf,mxz,mqh},"圆主题")
  波纹({newnote},"方主题")

  图标注释(_more,"更多")
  图标注释(_menu,"导航")

  local ch_item_checked_background = GradientDrawable()
  .setShape(GradientDrawable.RECTANGLE)
  .setColor(转0x(primaryc)-0xde000000)
  .setCornerRadii({0,0,dp2px(24),dp2px(24),dp2px(24),dp2px(24),0,0});

  local drawer_item={
    {
      LinearLayout;
      Focusable=true;
      layout_width="fill";
      layout_height="wrap";
      {
        TextView;
        id="title";
        textSize="14dp";
        textColor=primaryc;
        layout_marginTop="8dp";
        layout_marginLeft="16dp";
        Typeface=字体("product");
      };
    };

    {
      LinearLayout;
      layout_width="-1";
      layout_height="48dp";
      gravity="center|left";
      {
        ImageView;
        id="iv";
        ColorFilter=textc;
        layout_marginLeft="24dp";
        layout_width="24dp";
        layout_height="24dp";
      };
      {
        TextView;
        id="tv";
        layout_marginLeft="16dp";
        textSize="14dp";
        textColor=textc;
        Typeface=字体("product");
      };
    };

    {
      RelativeLayout;
      layout_width="-1";
      layout_height="48dp";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        layout_marginRight="8dp";
        BackgroundDrawable=ch_item_checked_background;
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        gravity="center|left";
        {
          ImageView;
          id="iv";
          ColorFilter=primaryc;
          layout_marginLeft="24dp";
          layout_width="24dp";
          layout_height="24dp";
        };
        {
          TextView;
          id="tv";
          layout_marginLeft="16dp";
          textSize="14dp";
          textColor=primaryc;
          Typeface=字体("product");
        };
      };
    };

    {
      LinearLayout;
      layout_width="-1";
      layout_height="-2";
      gravity="center|left";
      onClick=function()end;
      {
        TextView;
        layout_width="-1";
        layout_height="2px";
        background="#21000000";
        layout_marginTop="8dp";
        layout_marginBottom="8dp";
      };
    };

  };

  --侧滑adapter
  adp=LuaMultiAdapter(activity,drawer_item)
  drawer_lv.setAdapter(adp)--侧滑

  --侧滑table
  local ch_table={
    "分割线",
    {"主页","home",},
    {"工具","inbox",},
    {"源码","get_app",},
    "分割线",
    {"捐赠","card_giftcard",},
    {"分享","open_in_new",},
    {"关于","info",},
    {"设置","settings",},
    {"退出","exit_to_app",},
  };

  function ch_light(n)--侧滑高亮
    adp.clear()
    for i=1,#ch_table do
      if ch_table[i]=="分割线"then
        adp.add{__type=4}
       elseif n==ch_table[i][1] then
        adp.add{__type=3,iv={src=图标(ch_table[i][2])},tv=ch_table[i][1]}
       else
        adp.add{__type=2,iv={src=图标(ch_table[i][2])},tv=ch_table[i][1]}
      end
    end
  end

  ch_light("主页")
  page_home.setVisibility(View.VISIBLE)
  page_tool.setVisibility(View.GONE)

  drawer_lv.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(id,v,zero,one)--侧滑
      _drawer.closeDrawer(Gravity.LEFT)
      local s=v.Tag.tv.Text
      if s=="退出" then
        关闭页面()
       elseif s=="主页" then
        ch_light("主页")
        page_home.setVisibility(View.VISIBLE)
        page_tool.setVisibility(View.GONE)
        page_source.setVisibility(View.GONE)
        page_home_p.showPage(0)
        _title.Text="MLua手册"
       elseif s=="工具" then
        ch_light("工具")
        page_home.setVisibility(View.GONE)
        page_tool.setVisibility(View.VISIBLE)
        page_source.setVisibility(View.GONE)
        _title.Text="工具"
       elseif s=="源码" then
        ch_light("源码")
        page_source.setVisibility(View.VISIBLE)
        page_home.setVisibility(View.GONE)
        page_tool.setVisibility(View.GONE)
        _title.Text="源码"
       elseif s=="分享" then
        local intent=Intent(Intent.ACTION_SEND);
        intent.setType("text/plain");
        intent.putExtra(Intent.EXTRA_SUBJECT, "分享MLua手册");
        intent.putExtra(Intent.EXTRA_TEXT, "MLua手册\n这是一个全新的lua手册\n--\nhttps://www.coolapk.com/apk/com.muk.luahb");
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        activity.startActivity(Intent.createChooser(intent,"分享到:"));
       elseif s=="关于" then
        activity.newActivity("about")
       elseif s=="设置" then
        activity.newActivity("settings")
       elseif s=="捐赠" then
        activity.newActivity("web",{"https://www.mukapp.top/pay/"})
       else
        Snakebar(s)
      end
    end})

  --主页pageview
  page_home_p.setOnPageChangeListener(PageView.OnPageChangeListener{
    onPageScrolled=function(a,b,c)
    end,
    onPageSelected=function(v)
      local x=primaryc
      local c=stextc
      local c1=c
      local c2=c
      local c3=c
      local c4=c
      if v==0 then
        c1=x
        showD(page1)
        closeD(page2)
        closeD(page3)
        closeD(page4)
      end
      if v==1 then
        c2=x
        showD(page2)
        closeD(page1)
        closeD(page3)
        closeD(page4)
      end
      if v==2 then
        c3=x
        showD(page3)
        closeD(page1)
        closeD(page2)
        closeD(page4)
      end
      if v==3 then
        c4=x
        showD(page4)
        closeD(page1)
        closeD(page2)
        closeD(page3)
      end
      page1.getChildAt(0).setColorFilter(转0x(c1))
      page2.getChildAt(0).setColorFilter(转0x(c2))
      page3.getChildAt(0).setColorFilter(转0x(c3))
      page4.getChildAt(0).setColorFilter(转0x(c4))
      page1.getChildAt(1).setTextColor(转0x(c1))
      page2.getChildAt(1).setTextColor(转0x(c2))
      page3.getChildAt(1).setTextColor(转0x(c3))
      page4.getChildAt(1).setTextColor(转0x(c4))
    end
  })

  --工具
  local tool_list_item={
    LinearLayout;
    layout_width="-1";
    layout_height="-2";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=cardbackc;
      Radius="8dp";
      layout_width="-1";
      layout_height="48dp";
      layout_margin="8dp";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        gravity="center";
        {
          TextView;
          id="tladp_text";
          textColor=textc;
          textSize="14sp";
          gravity="center";
          Typeface=字体("product");
        };
        {
          TextView;
          id="tladp_activity";
          layout_width="0";
          layout_height="0";
        };
      };
    };
  };

  tladp=LuaAdapter(activity,tool_list_item)

  tool_list.setAdapter(tladp)--工具
  tladp.add{tladp_text="MD配色参考",tladp_activity="tools-mdcolor"}
  tladp.add{tladp_text="渐变颜色参考",tladp_activity="tools-gcc"}
  tladp.add{tladp_text="颜色选择器",tladp_activity="tools-palette"}
  tladp.add{tladp_text="get/post调试",tladp_activity="tools-http"}
  tladp.add{tladp_text="Jar转Dex",tladp_activity="tools-jartodex"}
  tladp.add{tladp_text="代码调试",tladp_activity="view-code"}

  tool_list.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(parent, v, pos,id)
      local s=v.Tag.tladp_activity.Text
      if s=="NO" then
        local s=v.Tag.tladp_text.Text
        return true
      end
      跳转页面(s)
    end
  })

  listalpha=AlphaAnimation(0,1)
  listalpha.setDuration(256)
  controller=LayoutAnimationController(listalpha)
  controller.setDelay(0.4)
  controller.setOrder(LayoutAnimationController.ORDER_NORMAL)
  tool_list.setLayoutAnimation(controller)
  drawer_lv.setLayoutAnimation(controller)
  page_home.setLayoutAnimation(controller)
  homelist.setLayoutAnimation(controller)

  --PopupWindow
  local Popup_layout={
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
  popadp.add{popadp_text="搜索",}

  Popup_list.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(parent, v, pos,id)
      pop.dismiss()
      local s=v.Tag.popadp_text.Text
      if s=="搜索" then
        跳转页面("search")
      end
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

  homeitem={
    {
      LinearLayout;
      layout_width="-1";
      layout_height="-2";
      orientation="vertical";
      onClick=function()end;
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
            id="title";
            textColor=primaryc;
            textSize="16sp";
            gravity="center|left";
            Typeface=字体("product-Bold");
          };
          {
            TextView;
            id="content";
            textColor=textc;
            textSize="14sp";
            gravity="center|left";
            --Typeface=字体("product");
            layout_marginTop="12dp";
          };
        };
      };
    };

    {
      LinearLayout;
      layout_width="-1";
      layout_height="-2";
      orientation="vertical";
      onClick=function()end;
      {
        TextView;
        textColor=primaryc;
        textSize="14sp";
        gravity="center|left";
        Typeface=字体("product-Bold");
        layout_margin="16dp";
        layout_marginBottom="8dp";
        id="title";
      };
    };

    {
      LinearLayout;
      layout_width="-1";
      layout_height="-2";
      orientation="vertical";
      onClick=function()end;
      {
        CardView;
        CardElevation="0dp";
        CardBackgroundColor="#10000000";
        Radius="8dp";
        layout_width="-1";
        layout_height=(activity.Width-dp2px(32))/520*150;
        layout_margin="16dp";
        layout_marginTop="8dp";
        layout_marginBottom="8dp";
        {
          ImageView;
          scaleType="centerCrop";
          layout_width="-1";
          layout_height="-1";
          colorFilter=viewshaderc;
          id="pic";
        };
        {
          TextView;
          id="content";
          layout_width="-1";
          layout_height="-1";
          textColor="#00000000";
          onClick=function(v)跳转页面("web",{v.Text})end;
        };
      };
    };

    {
      LinearLayout;
      layout_width="-1";
      layout_height="-2";
      orientation="vertical";
      onClick=function()end;
      {
        CardView;
        CardElevation="0dp";
        CardBackgroundColor=cardbackc;
        Radius="8dp";
        layout_width="-1";
        layout_height="110dp";
        layout_margin="16dp";
        layout_marginTop="8dp";
        layout_marginBottom="8dp";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-1";
          {
            ImageView;
            id="pic";
            scaleType="centerCrop";
            layout_width=dp2px(110)/280*440;
            layout_height="-1";
            colorFilter=viewshaderc;
          };
          {
            TextView;
            id="content";
            textColor=textc;
            textSize="16sp";
            gravity="center|left";
            Typeface=字体("product-Bold");
            layout_margin="16dp";
            --layout_marginBottom="8dp";
            layout_height="-1";
            layout_width="-1";
            layout_weight="1";
          };
        };
        {
          TextView;
          id="link";
          layout_width="-1";
          layout_height="-1";
          textColor="#00000000";
          onClick=function(v)跳转页面("web",{v.Text})end;
        };
      };
    };

    {
      LinearLayout;
      layout_width="-1";
      layout_height="-2";
      orientation="vertical";
      onClick=function()end;
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
          TextView;
          id="title";
          textColor=textc;
          textSize="16sp";
          gravity="center|left";
          Typeface=字体("product");
          layout_width="-1";
          layout_height="-1";
          padding="16dp";
        };
      };
    };

    {
      LinearLayout;
      layout_width="-1";
      layout_height="-2";
      orientation="vertical";
      paddingLeft="8dp";
      paddingRight="8dp";
      onClick=function()end;
      {
        NoScrollGridView;
        id="favorite";
        layout_height="-2";
        layout_width="-1";
        --DividerHeight=0;
        NumColumns=2;
        --layout_marginTop="8dp";
      };
    };

  }

  homeadp=LuaMultiAdapter(activity,homeitem)
  homelist.setAdapter(homeadp)--侧滑

  function 获取公告()
    获取信息("notice",function(content)
      swipe1.setRefreshing(false)
      homeadp=LuaMultiAdapter(activity,homeitem)
      homelist.setAdapter(homeadp)--侧滑
      if content=="error" then
        homeadp.add{__type=1,title={text="远程公告获取失败"},content="请确认网络是否有问题，如果网络无问题请下拉刷新或者等待。"}
        return true
      end
      local content=content:gsub("<br>","")
      for v in content:gmatch("{(.-)}") do
        if 全局主题值=="Day" then
          bwz=0x3f000000
         else
          bwz=0x3fffffff
        end
        if v=="公告" then
          homeadp.add{__type=2,title="公告"}
          homeadp.add{__type=1,title={text="欢迎使用"},content="欢迎向我反馈特性(bug)或者为该软件的开发提供建议。\nMUK QQ:1773798610"}
          --return true
         else
          if v:match("==#(.-)")==nil then
            if v:match("<(.-)?>")=="tit-s" then
              homeadp.add{__type=2,title=v:match(">(.+)")}
             elseif v:match("<(.-)?>")=="big-text-yiyan" then
              homeadp.add{__type=5,title={
                  text=v:match(">(.+)"),
                  BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
                  onClick=function(v)
                    --activity.newActivity("edit-home")
                    复制文本(v.text)
                    提示("已复制")
                  end;
                }}
             elseif v:match("<(.-)?>")=="big-text" then
              homeadp.add{__type=5,title={
                  text=v:match(">(.+)"),
                  BackgroundDrawable=nil;
                  onClick=nil;
                }}
             elseif v:match("(.+) | "):match("<(.-)?>")=="pic-c" then
              homeadp.add{__type=3,pic={src=v:match(">(.-) | ")},content={
                  text=v:match(" | (.+)"),
                  BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}))
                }}
             elseif v:match("(.+) | "):match("<(.-)?>")=="pic-tex-c" then
              local imgurl,url,dtext=v:match(">(.-) | (.-) | (.+)")
              homeadp.add{__type=4,pic={src=imgurl},content={
                  text=dtext,
                },link={
                  text=url,
                  BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}))
                }}
             else
              homeadp.add{__type=1,title=v:match("(.+) | "),content=v:match(" | (.+)")}
            end
          end
        end
      end

    end)
  end
  获取公告()

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

  function 获取代码()
    获取信息("code",function(content)
      swipe2.setRefreshing(false)
      if content=="error" then
        --Snakebar("获取失败")
        Snakebar("代码获取失败，请确认网络是否有问题，如果网络无问题请下拉刷新或者等待。")
        if activity.getSharedData("code")~=nil then
          dmdata={}
          dmadp=LuaAdapter(activity,dmdata,dmitem)
          dmlist.setAdapter(dmadp)

          local content=activity.getSharedData("code"):gsub("<br>","")
          for v in content:gmatch("@{(.-)}@") do
            if v:match("==#(.-)")==nil then
              dmdata[#dmdata+1]={_title=v:match("(.+){@!"),_text=v:match("{@!\n(.+)")}
            end
          end
          dmadp.notifyDataSetChanged()
        end
        return true
      end
      activity.setSharedData("code",content)
      dmdata={}
      dmadp=LuaAdapter(activity,dmdata,dmitem)
      dmlist.setAdapter(dmadp)

      local content=content:gsub("<br>","")
      for v in content:gmatch("@{(.-)}@") do
        if v:match("==#(.-)")==nil then
          dmdata[#dmdata+1]={_title=v:match("(.+){@!"),_text=v:match("{@!\n(.+)")}
        end
      end
      dmadp.notifyDataSetChanged()
    end)
  end
  获取代码()

  dmlist.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(id,v,zero,one)
      local s=v.Tag._text.Text
      跳转页面("view-code",{v.Tag._title.Text,v.Tag._text.Text})
    end})

  jcdata={}

  jcadp=LuaAdapter(activity,jcdata,dmitem)

  jclist.setAdapter(jcadp)

  function 获取教程()
    获取信息("tutorial",function(content)
      swipe3.setRefreshing(false)
      if content=="error" then
        --Snakebar("获取失败")
        Snakebar("文字教程获取失败，请确认网络是否有问题，如果网络无问题请下拉刷新或者等待。")
        if activity.getSharedData("tutorial")~=nil then
          jcdata={}
          jcadp=LuaAdapter(activity,jcdata,dmitem)
          jclist.setAdapter(jcadp)

          local content=activity.getSharedData("tutorial"):gsub("<br>","")
          for v in content:gmatch("@{(.-)}@") do
            if v:match("==#(.-)")==nil then
              jcdata[#jcdata+1]={_title=v:match("(.+){@!"),_text=v:match("{@!\n(.+)")}
            end
          end
          jcadp.notifyDataSetChanged()
        end
        return true
      end
      activity.setSharedData("tutorial",content)
      jcdata={}
      jcadp=LuaAdapter(activity,jcdata,dmitem)
      jclist.setAdapter(jcadp)

      local content=content:gsub("<br>","")
      for v in content:gmatch("@{(.-)}@") do
        if v:match("==#(.-)")==nil then
          jcdata[#jcdata+1]={_title=v:match("(.+){@!"),_text=v:match("{@!\n(.+)")}
        end
      end
      jcadp.notifyDataSetChanged()
    end)
  end
  获取教程()

  jclist.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(id,v,zero,one)
      跳转页面("view-tutorial",{v.Tag._title.Text,one,jcdata})
    end})

  spdata={}

  spadp=LuaAdapter(activity,spdata,dmitem)

  spjc.setAdapter(spadp)

  function 获取视频教程()
    获取信息("video",function(content)
      swipe4.setRefreshing(false)
      if content=="error" then
        --Snakebar("获取失败")
        Snakebar("视频教程获取失败，请确认网络是否有问题，如果网络无问题请下拉刷新或者等待。")
        if activity.getSharedData("video")~=nil then
          spdata={}
          spadp=LuaAdapter(activity,spdata,dmitem)
          spjc.setAdapter(spadp)

          local content=activity.getSharedData("video"):gsub("<br>","")
          for v in content:gmatch("{(.-)}") do
            if v:match("==#(.-)")==nil then
              spdata[#spdata+1]={_title=v:match("(.+) | "),_text=v:match(" | (.+)")}
            end
          end
          spadp.notifyDataSetChanged()
        end
        return true
      end
      activity.setSharedData("video",content)
      spdata={}
      spadp=LuaAdapter(activity,spdata,dmitem)
      spjc.setAdapter(spadp)

      local content=content:gsub("<br>","")
      for v in content:gmatch("{(.-)}") do
        if v:match("==#(.-)")==nil then
          spdata[#spdata+1]={_title=v:match("(.+) | "),_text=v:match(" | (.+)")}
        end
      end
      spadp.notifyDataSetChanged()
    end)
  end
  获取视频教程()

  spjc.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(id,v,zero,one)
      跳转页面("video-play",{v.Tag._text.Text})
      --跳转页面("mediaplayer",{v.Tag._text.Text,1,"Title"})
    end})

  swipe1.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
      获取公告()
      获取代码()
      获取教程()
      获取视频教程()
    end})

  swipe2.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
      获取代码()
    end})

  swipe3.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
      获取教程()
    end})

  swipe4.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
      获取视频教程()
    end})

  检查更新()

  if isShortcut then
    loadstring(activityContent)()
  end

  newnote.setOnTouchListener({
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

  function 新建笔记()
    activity.newActivity("new-note")
  end

  noteitem={
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
          id="title";
        };
        {
          TextView;
          --textColor=stextc;
          --textSize="12sp";
          --gravity="center|left";
          --Typeface=字体("product");
          --layout_marginTop="12dp";
          id="text";
          --maxLines=3;
          layout_width="0";
          layout_height="0";
        };
        {
          TextView;
          textColor=stextc;
          textSize="12sp";
          gravity="center|left";
          Typeface=字体("product");
          layout_marginTop="12dp";
          id="time";
        };
      };
    };
  };

  notedata={}
  noteadp=LuaAdapter(activity,notedata,noteitem)
  notelist.setAdapter(noteadp)

  function 加载笔记()
    notedata={}
    for i,v in ipairs(luajava.astable(File(内置存储文件("Note")).listFiles())) do
      local v=tostring(v)
      local _,name=v:match("(.+)/(.+)")
      notedata[#notedata+1]={title=name,text=(v),time=获取文件修改时间(v)}
    end
    noteadp=LuaAdapter(activity,notedata,noteitem)
    notelist.setAdapter(noteadp)
    if notelist.getCount()==0 then
      创建文件(内置存储文件("Note/创建你的第一条笔记"))
      写入文件(内置存储文件("Note/创建你的第一条笔记"),[[笔记在退出时会自动保存
隔一段时间也会自动保存
"全部笔记"页面可以添加/删除/重命名笔记
]])
      加载笔记()
    end
  end

  加载笔记()

  notelist.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(id,v,zero,one)
      跳转页面("edit-note",{v.Tag.text.Text})
    end})

  notelist.setOnItemLongClickListener(AdapterView.OnItemLongClickListener{
    onItemLongClick=function(id,v,zero,one)
      local _,name=v.Tag.text.Text:match("(.+)/(.+)")
      三按钮对话框(name,"请选择操作","重命名","删除","取消",function()
        跳转页面("new-note",{v.Tag.text.Text})
        关闭对话框()
      end,function()
        关闭对话框()
        双按钮对话框("确认要删除笔记 "..name.." 吗？","此操作不可撤销","确认删除","取消",function()
          删除文件(v.Tag.text.Text)
          加载笔记()
          关闭对话框()
        end,function()关闭对话框()end)
      end,function()关闭对话框()end)
      return true
    end})

  分屏()

  local debug_time_create=os.clock()-debug_time_create_n
  if mukactivity.getData("Setting_Activity_LoadTime")=="true" then
    print(debug_time_create)
  end


  web.removeView(web.getChildAt(0))

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
      if url:match("lanzous.com/(.+)")~="b00z6jhmf" then
        --activity.newActivity("source",{url:gsub("lanzous.com","lanzous.com/tp")})
        Http.get(url:gsub("lanzous.com","lanzous.com/tp"),function(code,content)
          提示("正在下载")
          local c,a,b=content:match([[<div class="md">(.-) ?<.-dpost ?= ?'https://(.-)'.-sgo ?= ?'(.-)']])
          local link="https://"..a..b
          --activity.newActivity("source",{link})
          Http.download(link,MUKAPP文件("Download/"..c),function(code,content)
            if code==200 then
              提示("下载完成")
              xpcall(function()
                重命名文件(content,content:gsub("%.zip$",".alp"))
                content=content:gsub("%.zip$",".alp")

                intent = Intent();
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                intent.setAction(Intent.ACTION_VIEW)
                intent.setData(Uri.fromFile(File(content)))
                activity.startActivity(Intent.createChooser(intent, "请选择导入到的编辑器"))
              end,function()
                提示("拉起应用失败，请手动导入")
              end)
             else
              提示("下载失败 "..code)
            end
          end)
        end)
        return true
      end
    end,
    onPageStarted=function(view,url,favicon)
      控件可见(webprogress)
      控件可见(jzdh)
      swipe5.setRefreshing(true)
    end,
    onPageFinished=function(view,url)
      控件隐藏(webprogress)
      控件隐藏(jzdh)
      swipe5.setRefreshing(false)
      v=[[
          document.querySelector('.top').style.display="none";
          document.querySelector('.d1').style.display="none";
          document.querySelector('.d11').style.display="none";
          document.querySelector('.d7').style.display="none";
          document.querySelector('.d12').style.display="none";
          document.querySelector('.pc').style.display="none";
          document.querySelector('.bgimg').style.display="none";
          document.querySelector('.teta').style.display="none";
          document.querySelector('.tetb').style.display="none";
          document.querySelector('.tet').innerHTML="Lua交流群 686976850<br>部分源码因为年代久远或使用第三方编辑器而不能被androlua+使用<br>部分源码有多个版本，请查看名称后面的日期<br>由于androlua+的工程都很小，所以您点击文件名后会自动下载工程，下载目录：]]..MUKAPP文件("Download/")..[[<br>下载完成后会自动更改后缀为alp，并且会提醒您导入工程";
          document.getElementsByTagName('body')[0].style.background=']]..backgroundc..[[';
          document.querySelector('.tet').style.color=']]..textc..[[';
        ]]
      web.loadUrl([[
      javascript:(function()
        { ]]..v..[[ })()
      ]]);
    end
  }

  web.setDownloadListener{
    onDownloadStart=function(url, userAgent, contentDisposition, mimetype, contentLength)
      return true
    end
  };

  web.getSettings().setSupportZoom(false);
  web.getSettings().setBuiltInZoomControls(false);
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

  web.loadUrl("https://www.lanzous.com/b00z6jhmf")--加载网页
  swipe5.setRefreshing(true)

  swipe5.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
      web.reload()
    end})

  web.setOnScrollChangeListener{
    onScrollChange=function( view, i, i1, i2, i3)
      if web.getScrollY() == 0 then
        swipe5.setEnabled(true);
       else
        swipe5.setEnabled(false);
      end
    end
  }

end

function onStart()
  pcall(function()
    加载笔记()
  end)
end

function onResult(name,...)
  if name=="settings" then
    渐变跳转页面("home")
    关闭页面()
  end
  if name=="web" then
    web.reload()
  end
  if name=="new-note" or name=="edit-note" then
    加载笔记()
  end
end

mukactivity.setDataR("USE_TIMES",0)
mukactivity.setDataR("USE_STAR",0)

mukactivity.setData("USE_TIMES",mukactivity.getData("USE_TIMES")+1)

if mukactivity.getData("USE_TIMES")>=4 and mukactivity.getData("USE_STAR")==0 then
  双按钮对话框("给我评个分吧ʕ•ٹ•ʔ","如果你觉得我很好用，请在酷安上给我好评！(ㆁωㆁ*)","五星好评！","拒绝并不再提示",function()
    关闭对话框(an)
    viewIntent = Intent("android.intent.action.VIEW",Uri.parse("https://www.coolapk.com/apk/com.muk.luahb"))
    activity.startActivity(viewIntent)
    mukactivity.setData("USE_STAR",1)
    提示("谢谢ʕ•̀ω•́ʔ✧")
  end,function()
    关闭对话框(an)
    mukactivity.setData("USE_STAR",1)
  end,0)
end

function onConfigurationChanged( newConfig)
  分屏()
end

function 分屏()
  if activity.Height*0.9<activity.Width then
    Activity_Multi=true
    local m_ALocation=int{0,0}
    mActionBar_top.getLocationOnScreen(m_ALocation)

    if m_ALocation[1]>=状态栏高度 then
      local linearParams = mActionBar_top.getLayoutParams()
      linearParams.height=0
      mActionBar_top.setLayoutParams(linearParams)
      Activity_Multi_Bottom=true
      Activity_mActionBar_top=nil
     else
      local linearParams = mActionBar_top.getLayoutParams()
      linearParams.height=状态栏高度
      mActionBar_top.setLayoutParams(linearParams)
      Activity_Multi_Bottom=false
      Activity_mActionBar_top=true
    end

    local linearParams = mActionBar.getLayoutParams()
    linearParams.height=dp2px(48)
    mActionBar.setLayoutParams(linearParams)
    local linearParams = mBottomBar.getLayoutParams()
    linearParams.height=dp2px(48)
    mBottomBar.setLayoutParams(linearParams)
   else
    Activity_mActionBar_top=true
    Activity_Multi_Bottom=nil
    Activity_Multi=nil
    local linearParams = mActionBar.getLayoutParams()
    linearParams.height=dp2px(56)
    mActionBar.setLayoutParams(linearParams)
    local linearParams = mBottomBar.getLayoutParams()
    linearParams.height=dp2px(56)
    mBottomBar.setLayoutParams(linearParams)
  end
end
