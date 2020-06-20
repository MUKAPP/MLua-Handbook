require "import"
import "mods.muk"

local debug_time_create_n=os.clock()

function onCreate()

  activity.setContentView(loadlayout("layout/tools-mdcolor"))

  波纹({fh},"圆主题")

  图标注释(fh,"返回")

  mml={
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
          gravity="left|center";
          layout_height="-1";
          {
            CardView;
            radius="24dp";
            layout_width="48dp";
            layout_height="48dp";
            layout_margin="16dp";
            elevation="1dp";
            {
              TextView;
              layout_width="-1";
              layout_height="-1";
              id="yb";
            };
          };
          {
            LinearLayout;
            layout_width="-1";
            layout_height="-1";
            orientation="vertical";
            gravity="left|center";
            {
              TextView;
              textSize="16sp";
              layout_height="-2";
              layout_width="-1";
              layout_marginTop="16dp";
              layout_marginLeft="16dp";
              layout_marginRight="16dp";
              id="bt";
              Typeface=字体("product-Bold");
            };
            {
              TextView;
              textColor="#ff424242";
              textSize="14sp";
              layout_height="-2";
              layout_width="-1";
              layout_marginTop="4dp";
              layout_marginBottom="16dp";
              layout_marginLeft="16dp";
              layout_marginRight="16dp";
              id="nr";
              Typeface=字体("product");
            };
            {
              TextView;
              layout_height="0";
              layout_width="0";
              id="ys";
              Typeface=字体("product");
            };
          };
        };
    };
  };

  adp=LuaAdapter(activity,mml)

  function 添加项目(bt,yw,ysn)
    adp.add{
      bt={text=bt,textColor=tonumber(ysn)},
      yb={Background=ColorDrawable(tonumber(ysn))},
      nr={text=yw,textColor=tonumber(ysn)},
      ys=ysn
    }
  end

  添加项目("红色","Red","0xFFF44336")
  添加项目("粉色","Pink","0xFFE91E63")
  添加项目("紫色","Purple","0xFF9C27B0")
  添加项目("深紫","Deep Purple","0xFF673AB7")
  添加项目("靛蓝","Indigo","0xFF3F51B5")
  添加项目("蓝色","Blue","0xFF2196F3")
  添加项目("亮蓝","Light Blue","0xFF03A9F4")
  添加项目("青色","Cyan","0xFF00BCD4")
  添加项目("鸭绿","Teal","0xFF009688")
  添加项目("绿色","Green","0xFF4CAF50")
  添加项目("亮绿","Light Green","0xFF8BC34A")
  添加项目("青柠","Lime","0xFFCDDC39")
  添加项目("黄色","Yello","0xFFFFEB3B")
  添加项目("琥珀","Amber","0xFFFFC107")
  添加项目("橙色","Orange","0xFFFF9800")
  添加项目("深橙","Deep Orange","0xFFFF5722")
  添加项目("棕色","Brown","0xFF795548")
  添加项目("灰色","Grey","0xFF9E9E9E")
  添加项目("蓝灰","Blue Grey","0xFF607D8B")

  lv.Adapter=adp
  lv.onItemClick=function(l,v,p,i)
    跳转页面("tools-viewmdcolor",{v.Tag.bt.Text,v.Tag.ys.Text,v.Tag.nr.Text})
  end

  listalpha=AlphaAnimation(0,1)
  listalpha.setDuration(256)
  controller=LayoutAnimationController(listalpha)
  controller.setDelay(0.4)
  controller.setOrder(LayoutAnimationController.ORDER_NORMAL)
  lv.setLayoutAnimation(controller)

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
