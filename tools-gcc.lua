require "import"
import "mods.muk"

local debug_time_create_n=os.clock()

function onCreate()
  activity.setContentView(loadlayout("layout/tools-gcc"))

  波纹({fh},"圆主题")

  图标注释(fh,"返回")

  mml={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor="#ffffff";
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="72dp";
        gravity="left|center";
        id="ym";
        {
          TextView;
          layout_width="-1";
          layout_height="-1";
          textColor="#ff212121";
          textSize="16sp";
          padding="16dp";
          layout_weight="1";
          gravity="left|center";
          id="dml";
          Typeface=字体("product");
        };
        {
          TextView;
          layout_width="-1";
          layout_height="-1";
          textColor="#ff212121";
          textSize="16sp";
          padding="16dp";
          layout_weight="1";
          gravity="right|center";
          id="dmr";
          Typeface=字体("product");
        };
      };
    };
  };
  adp=LuaAdapter(activity,mml)
  function 添加项目(l,r)
    local ln=l:match("0xFF(.+)")
    local lj='#'..ln
    local rn=r:match("0xFF(.+)")
    local rj='#'..rn
    adp.add{
      dml={text=lj},
      ym={BackgroundDrawable=GradientDrawable(GradientDrawable.Orientation.LEFT_RIGHT,{l,r})},
      dmr={text=rj}
    }
  end

  添加项目("0xFFFDEB71","0xFFF8D800")
  添加项目("0xFFABDCFF","0xFF0396FF")
  添加项目("0xFFFEB692","0xFFEA5455")
  添加项目("0xFFCE9FFC","0xFF7367F0")
  添加项目("0xFF90F7EC","0xFF32CCBC")
  添加项目("0xFFFFF6B7","0xFFF6416C")
  添加项目("0xFF81FBB8","0xFF28C76F")
  添加项目("0xFFE2B0FF","0xFF9F44D3")
  添加项目("0xFFF97794","0xFF623AA2")
  添加项目("0xFFFCCF31","0xFFF55555")
  添加项目("0xFFF761A1","0xFF8C1BAB")
  添加项目("0xFF43CBFF","0xFF9708CC")
  添加项目("0xFF5EFCE8","0xFF736EFE")
  添加项目("0xFFFAD7A1","0xFFE96D71")
  添加项目("0xFFFFD26F","0xFF3677FF")
  添加项目("0xFF83A4D4","0xFFB6FBFF")
  添加项目("0xFFFF5E75","0xFFFF42EB")
  添加项目("0xFFFF96F9","0xFFC32BAC")
  添加项目("0xFFA050F1","0xFF8F3196")
  添加项目("0xFFEFB884","0xFFBE944D")
  添加项目("0xFF7CE084","0xFF50BF1C")
  添加项目("0xFF43CBFF","0xFF3C8CE7")
  添加项目("0xFF5F87FF","0xFF122EF1")
  添加项目("0xFF42A5F5","0xFF00C853")
  添加项目("0xFFFF6B66","0xFFF0703E")
  添加项目("0xFFCB7575","0xFFA3C9C7")
  添加项目("0xFF5CAB7D","0xFFF68657")
  添加项目("0xFFC65146","0xFF84B1ED")
  添加项目("0xFF6A60A9","0xFFFC913A")
  添加项目("0xFF1E8AE8","0xFF0075D5")
  添加项目("0xFFFB7299","0xFFF670DA")
  添加项目("0xFF3F51B3","0xFFE81C61")
  添加项目("0xFF7986CB","0xFF5EFFAE")
  添加项目("0xFF363C4A","0xFF1F8792")
  添加项目("0xFF087EA2","0xFF08BBE4")
  添加项目("0xFF544E74","0xFFE68967")
  添加项目("0xFF155F82","0xFFA5700A")

  lv.Adapter=adp
  lv.onItemClick=function(l,v,p,i)
    local lm=v.Tag.dml.Text
    local rm=v.Tag.dmr.Text
    Snakebar("已复制颜色 "..lm..","..rm)
    复制文本(lm..","..rm)
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
