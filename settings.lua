require "import"
require "permission"
import "mods.muk"

local debug_time_create_n=os.clock()

function onCreate()
  layout={
    LinearLayout,
    layout_width="fill",
    orientation="vertical",
    background=backgroundc;
    {
      LinearLayout,
      layout_width="fill",
      layout_height="56dp",
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
          onClick=function()退出()end;
        };
      };
      {
        LinearLayout,
        layout_width="-1",
        layout_height="-1",
        gravity="center|left";
        orientation="vertical";
        paddingLeft="16dp";
        layout_weight="1",
        {
          TextView;
          text="软件设置";
          textColor=primaryc;
          Typeface=字体("product-Bold");
          textSize="20sp";
        };
      };
    };

    {
      ListView,
      id="listView",
      DividerHeight=0;
      layout_width="fill",
      layout_height="fill",
    }
  }

  setting={
    {--标题
      LinearLayout;
      Focusable=true;
      layout_width="fill";
      layout_height="wrap";
      {
        TextView;
        id="title";
        textSize="14sp";
        textColor=primaryc;
        Typeface=字体("product-Bold");
        layout_marginTop="16dp";
        layout_marginLeft="16dp";
        layout_marginBottom="8dp";
      };
    };

    {--设置项(标题,简介)
      LinearLayout;
      layout_width="fill";
      layout_height="56dp";
      orientation="vertical";
      gravity="center_vertical";
      {
        TextView;
        id="subtitle";
        textSize="16sp";
        textColor=textc;
        Typeface=字体("product-Bold");
        layout_marginLeft="16dp";
      };
      {
        TextView;
        id="message";
        layout_marginLeft="16dp";
        textSize="14sp";
        textColor=stextc;
      };
    };

    {--设置项(标题)
      LinearLayout;
      layout_width="fill";
      layout_height="56dp";
      gravity="center_vertical";
      {
        TextView;
        id="subtitle";
        textSize="16sp";
        textColor="#AA000000";
        layout_marginLeft="16dp";
        Typeface=字体("product-Bold");
        textColor=textc;
      };
    };

    {--设置项(标题,简介,开关)
      LinearLayout;
      gravity="center";
      layout_width="fill";
      layout_height="56dp";
      {
        LinearLayout;
        orientation="vertical";
        layout_height="fill";
        gravity="center_vertical";
        layout_weight="1";
        {
          TextView;
          layout_marginLeft="16dp";
          textSize="16sp";
          textColor="#AA000000";
          id="subtitle";
          textColor=textc;
          Typeface=字体("product-Bold");
        };
        {
          TextView;
          id="message";
          layout_marginLeft="16dp";
          textColor=stextc;
          textSize="14sp";
        };
      };
      {
        Switch;
        clickable=false;
        Focusable=false;
        layout_marginRight="16dp";
        id="status";
      };
    };


    {--设置项(标题,开关)
      LinearLayout;
      gravity="center";
      layout_width="fill";
      layout_height="56dp";
      {
        TextView;
        id="subtitle";
        textSize="16sp";
        gravity="center_vertical";
        layout_weight="1";
        layout_height="fill";
        layout_marginLeft="16dp";
        Typeface=字体("product-Bold");
        textColor=textc;
      };
      {
        Switch;
        id="status";
        Focusable=false;
        clickable=false;
        layout_marginRight="16dp";
        textColor=stextc;
      };
    };

  };

  activity.setContentView(loadlayout(layout))

  波纹({back},"圆主题")

  图标注释(back,"返回")

  跟随系统夜间模式=mukactivity.getData("Setting_Auto_Night_Mode")
  夜间模式=mukactivity.getData("Setting_Night_Mode")
  自动检测更新=mukactivity.getData("Setting_Auto_Update")
  页面加载时间显示=mukactivity.getData("Setting_Activity_LoadTime")
  开启启动页=mukactivity.getData("Setting_Main_Enabled")


  data={}
  adp=LuaMultiAdapter(activity,data,setting)
  adp.add{__type=4,subtitle="自动检测更新",message="软件启动时自动检测新版本",status={
      Checked=Boolean.valueOf(自动检测更新);
    }}
  adp.add{__type=4,subtitle="跟随系统夜间模式",message="此项启用时“夜间模式”设置项不生效，若开启此项不跟随系统夜间模式，则您的系统不支持原生夜间模式API",status={Checked=Boolean.valueOf(跟随系统夜间模式)}}
  adp.add{__type=5,subtitle="夜间模式",status={Checked=Boolean.valueOf(夜间模式)}}
  adp.add{__type=1,title="开发人员选项"}
  adp.add{__type=5,subtitle="页面加载时间显示",status={Checked=Boolean.valueOf(页面加载时间显示)}}
  --adp.add{__type=1,title="未开放功能"}
  --adp.add{__type=5,subtitle="自动备份开关",status={Checked=自动备份}}
  --adp.add{__type=2,subtitle="备份时间",message="设置多长时间执行一次自动备份"}
  --adp.add{__type=4,subtitle="退出时自动备份",message="",status={Checked=退出备份}}
  --adp.add{__type=2,subtitle="语言/Language",message="设置软件语言"}
  listView.setAdapter(adp)

  --列表点击事件
  listView.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(id,v,zero,one)
      更改设置=true
      if v.Tag.status ~= nil then
        if v.Tag.status.Checked then
          data[one].status["Checked"]=false
         else
          data[one].status["Checked"]=true
        end
        if v.Tag.subtitle.Text=="夜间模式" then
          夜间模式=data[one].status["Checked"]
        end
        if v.Tag.subtitle.Text=="跟随系统夜间模式" then
          跟随系统夜间模式=data[one].status["Checked"]
        end
        if v.Tag.subtitle.Text=="自动检测更新" then
          自动检测更新=data[one].status["Checked"]
        end
        if v.Tag.subtitle.Text=="页面加载时间显示" then
          页面加载时间显示=data[one].status["Checked"]
        end
      end
      adp.notifyDataSetChanged()
    end
  })

  listalpha=AlphaAnimation(0,1)
  listalpha.setDuration(256)
  controller=LayoutAnimationController(listalpha)
  controller.setDelay(0.4)
  controller.setOrder(LayoutAnimationController.ORDER_NORMAL)
  listView.setLayoutAnimation(controller)

  if mukactivity.getData("Setting_Home_PlayerBar")~=nil then
    mukactivity.setData("Setting_Home_PlayerBar",nil)
  end

  分屏()

  local debug_time_create=os.clock()-debug_time_create_n
  if mukactivity.getData("Setting_Activity_LoadTime")=="true" then
    print(debug_time_create)
  end
end

function 退出()
  if 更改设置 then
    mukactivity.setData("Setting_Night_Mode",tostring(夜间模式))
    mukactivity.setData("Setting_Auto_Update",tostring(自动检测更新))
    mukactivity.setData("Setting_Activity_LoadTime",tostring(页面加载时间显示))
    mukactivity.setData("Setting_Auto_Night_Mode",tostring(跟随系统夜间模式))
    mukactivity.setData("Setting_Main_Enabled",tostring(开启启动页))
    activity.result({})
   else
    关闭页面()
  end
end

function onKeyDown(e)
  if e == 4 then
    退出()
    return true
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
