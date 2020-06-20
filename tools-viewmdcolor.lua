require "import"
import "mods.muk"

ys,ll,yw=...

local debug_time_create_n=os.clock()

function onCreate()
  zyba=tonumber(ll)
  --状态栏颜色(zyba)
  mln=ll:match("0xFF(.+)")
  zybs='#'..mln
  zybw=tonumber("0x3F"..ll:match("0xFF(.+)"))

  设置视图("layout/tools-viewmdcolor")

  ztskp={
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
      layout_height="128dp";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        gravity="bottom";
        onClick=function()
          Snakebar("已复制颜色 "..bz.Text)
          复制文本(bz.Text)
        end;
        background=zybs;
        {
          RelativeLayout;
          layout_width="-1";
          layout_height="-2";
          {
            TextView;
            layout_height="-1";
            layout_width="-1";
            textColor="#ffffffff";
            textSize="14sp";
            gravity="right|bottom";
            text="基本色";
            layout_margin="16dp";
            Typeface=字体("product-Bold");
            id="jbs";
          };
          {
            TextView;
            textColor="#ffffffff";
            textSize="16sp";
            layout_height="-1";
            gravity="left|bottom";
            layout_width="-1";
            layout_margin="16dp";
            Typeface=字体("product-Bold");
            id="bz";
          };
          {
            LinearLayout;
            layout_height="-1";
            layout_width="-1";
            id="ripped";
          };
        };
      };
    };
  };

  local footerview =loadlayout(ztskp)
  footerview.setLayoutParams(AbsListView.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,ViewGroup.LayoutParams.WRAP_CONTENT--[[dp2px(120)--[[+dp(56)]]))
  lv.addHeaderView(footerview)

  bz.setText(zybs)
  波纹({ripped},"方黑")

  if ys=="黄色" then
    if 全局主题值=="日" then
      --window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
      --window.setStatusBarColor(zyba)
      fh.setColorFilter(0xff212121)
      bt.setTextColor(0xff212121)
      jbs.setTextColor(0xff212121)
      bz.setTextColor(0xff212121)
    end
  end

  mml={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
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
          id="dm";
          Typeface=字体("product-Bold");
        };
        {
          TextView;
          layout_width="-1";
          layout_height="-1";
          textColor="#ff212121";
          textSize="12sp";
          padding="8dp";
          layout_weight="1";
          gravity="right|top";
          id="md";
          Typeface=字体("product");
        };
      };
    };
  };

  adp=LuaAdapter(activity,mml)
  function 添加项目(nr,sz)
    local zsml=nr:match("0xFF(.+)")
    local zsll='#'..zsml
    if sz=="50" or sz=="100" or sz=="200" or sz=="300" or sz=="400" or sz=="500" or sz=="600" or sz=="700" or sz=="800" or sz=="900" then
      if tonumber(sz)>=500 then
        zs=0xffffffff
       else
        zs=0xff212121
      end
     else
      if sz=="A100" or sz=="A200" then
        zs=0xff212121
       else
        zs=0xffffffff
      end
    end
    if sz=="500" then
      sz="基本色 500"
     elseif sz=="700" then
      sz="基本色深色 700"
     elseif sz=="A200" then
      sz="强调色 A200"
    end
    adp.add{
      dm={text=zsll,textColor=zs},
      ym={Background=ColorDrawable(tonumber(nr))},
      md={text=sz,textColor=zs}
    }
  end

  if ys=="红色" then
    添加项目("0xFFFFEBEE","50")
    添加项目("0xFFFFCDD2","100")
    添加项目("0xFFEF9A9A","200")
    添加项目("0xFFE57373","300")
    添加项目("0xFFEF5350","400")
    添加项目("0xFFF44336","500")
    添加项目("0xFFE53935","600")
    添加项目("0xFFD32F2F","700")
    添加项目("0xFFC62828","800")
    添加项目("0xFFB71C1C","900")
    添加项目("0xFFFF8A80","A100")
    添加项目("0xFFFF5252","A200")
    添加项目("0xFFFF1744","A400")
    添加项目("0xFFD50000","A700")
  end
  if ys=="粉色" then
    添加项目("0xFFFCE4EC","50")
    添加项目("0xFFF8BBD0","100")
    添加项目("0xFFF48FB1","200")
    添加项目("0xFFF06292","300")
    添加项目("0xFFEC407A","400")
    添加项目("0xFFE91E63","500")
    添加项目("0xFFD81B60","600")
    添加项目("0xFFC2185B","700")
    添加项目("0xFFAD1457","800")
    添加项目("0xFF880E4F","900")
    添加项目("0xFFFF80AB","A100")
    添加项目("0xFFFF4081","A200")
    添加项目("0xFFF50057","A400")
    添加项目("0xFFC51162","A700")
  end
  if ys=="紫色" then
    添加项目("0xFFF3E5F5","50")
    添加项目("0xFFE1BEE7","100")
    添加项目("0xFFCE93D8","200")
    添加项目("0xFFBA68C8","300")
    添加项目("0xFFAB47BC","400")
    添加项目("0xFF9C27B0","500")
    添加项目("0xFF8E24AA","600")
    添加项目("0xFF7B1FA2","700")
    添加项目("0xFF6A1B9A","800")
    添加项目("0xFF4A148C","900")
    添加项目("0xFFEA80FC","A100")
    添加项目("0xFFE040FB","A200")
    添加项目("0xFFD500F9","A400")
    添加项目("0xFFAA00FF","A700")
  end
  if ys=="深紫" then
    添加项目("0xFFEDE7F6","50")
    添加项目("0xFFD1C4E9","100")
    添加项目("0xFFB39DDB","200")
    添加项目("0xFF9575CD","300")
    添加项目("0xFF7E57C2","400")
    添加项目("0xFF673AB7","500")
    添加项目("0xFF5E35B1","600")
    添加项目("0xFF512DA8","700")
    添加项目("0xFF4527A0","800")
    添加项目("0xFF311B92","900")
    添加项目("0xFFB388FF","A100")
    添加项目("0xFF7C4DFF","A200")
    添加项目("0xFF651FFF","A400")
    添加项目("0xFF6200EA","A700")
  end
  if ys=="靛蓝" then
    添加项目("0xFFE8EAF6","50")
    添加项目("0xFFC5CAE9","100")
    添加项目("0xFF9FA8DA","200")
    添加项目("0xFF7986CB","300")
    添加项目("0xFF5C6BC0","400")
    添加项目("0xFF3F51B5","500")
    添加项目("0xFF3949AB","600")
    添加项目("0xFF303F9F","700")
    添加项目("0xFF283593","800")
    添加项目("0xFF1A237E","900")
    添加项目("0xFF8C9EFF","A100")
    添加项目("0xFF536DFE","A200")
    添加项目("0xFF3D5AFE","A400")
    添加项目("0xFF304FFE","A700")
  end
  if ys=="蓝色" then
    添加项目("0xFFE3F2FD","50")
    添加项目("0xFFBBDEFB","100")
    添加项目("0xFF90CAF9","200")
    添加项目("0xFF64B5F6","300")
    添加项目("0xFF42A5F5","400")
    添加项目("0xFF2196F3","500")
    添加项目("0xFF1E88E5","600")
    添加项目("0xFF1976D2","700")
    添加项目("0xFF1565C0","800")
    添加项目("0xFF0D47A1","900")
    添加项目("0xFF82B1FF","A100")
    添加项目("0xFF448AFF","A200")
    添加项目("0xFF2979FF","A400")
    添加项目("0xFF2962FF","A700")
  end
  if ys=="亮蓝" then
    添加项目("0xFFE1F5FE","50")
    添加项目("0xFFB3E5FC","100")
    添加项目("0xFF81D4FA","200")
    添加项目("0xFF4FC3F7","300")
    添加项目("0xFF29B6F6","400")
    添加项目("0xFF03A9F4","500")
    添加项目("0xFF039BE5","600")
    添加项目("0xFF0288D1","700")
    添加项目("0xFF0277BD","800")
    添加项目("0xFF01579B","900")
    添加项目("0xFF80D8FF","A100")
    添加项目("0xFF40C4FF","A200")
    添加项目("0xFF00B0FF","A400")
    添加项目("0xFF0091EA","A700")
  end
  if ys=="青色" then
    添加项目("0xFFE0F7FA","50")
    添加项目("0xFFB2EBF2","100")
    添加项目("0xFF80DEEA","200")
    添加项目("0xFF4DD0E1","300")
    添加项目("0xFF26C6DA","400")
    添加项目("0xFF00BCD4","500")
    添加项目("0xFF00ACC1","600")
    添加项目("0xFF0097A7","700")
    添加项目("0xFF00838F","800")
    添加项目("0xFF006064","900")
    添加项目("0xFF84FFFF","A100")
    添加项目("0xFF18FFFF","A200")
    添加项目("0xFF00E5FF","A400")
    添加项目("0xFF00B8D4","A700")
  end
  if ys=="鸭绿" then
    添加项目("0xFFE0F2F1","50")
    添加项目("0xFFB2DFDB","100")
    添加项目("0xFF80CBC4","200")
    添加项目("0xFF4DB6AC","300")
    添加项目("0xFF26A69A","400")
    添加项目("0xFF009688","500")
    添加项目("0xFF00897B","600")
    添加项目("0xFF00796B","700")
    添加项目("0xFF00695C","800")
    添加项目("0xFF004D40","900")
    添加项目("0xFFA7FFEB","A100")
    添加项目("0xFF64FFDA","A200")
    添加项目("0xFF1DE9B6","A400")
    添加项目("0xFF00BFA5","A700")
  end
  if ys=="绿色" then
    添加项目("0xFFE8F5E9","50")
    添加项目("0xFFC8E6C9","100")
    添加项目("0xFFA5D6A7","200")
    添加项目("0xFF81C784","300")
    添加项目("0xFF66BB6A","400")
    添加项目("0xFF4CAF50","500")
    添加项目("0xFF43A047","600")
    添加项目("0xFF388E3C","700")
    添加项目("0xFF2E7D32","800")
    添加项目("0xFF1B5E20","900")
    添加项目("0xFFB9F6CA","A100")
    添加项目("0xFF69F0AE","A200")
    添加项目("0xFF00E676","A400")
    添加项目("0xFF00C853","A700")
  end
  if ys=="亮绿" then
    添加项目("0xFFF1F8E9","50")
    添加项目("0xFFDCEDC8","100")
    添加项目("0xFFC5E1A5","200")
    添加项目("0xFFAED581","300")
    添加项目("0xFF9CCC65","400")
    添加项目("0xFF8BC34A","500")
    添加项目("0xFF7CB342","600")
    添加项目("0xFF689F38","700")
    添加项目("0xFF558B2F","800")
    添加项目("0xFF33691E","900")
    添加项目("0xFFCCFF90","A100")
    添加项目("0xFFB2FF59","A200")
    添加项目("0xFF76FF03","A400")
    添加项目("0xFF64DD17","A700")
  end
  if ys=="青柠" then
    添加项目("0xFFF9FBE7","50")
    添加项目("0xFFF0F4C3","100")
    添加项目("0xFFE6EE9C","200")
    添加项目("0xFFDCE775","300")
    添加项目("0xFFD4E157","400")
    添加项目("0xFFCDDC39","500")
    添加项目("0xFFC0CA33","600")
    添加项目("0xFFAFB42B","700")
    添加项目("0xFF9E9D24","800")
    添加项目("0xFF827717","900")
    添加项目("0xFFF4FF81","A100")
    添加项目("0xFFEEFF41","A200")
    添加项目("0xFFC6FF00","A400")
    添加项目("0xFFAEEA00","A700")
  end
  if ys=="黄色" then
    添加项目("0xFFFFFDE7","50")
    添加项目("0xFFFFF9C4","100")
    添加项目("0xFFFFF59D","200")
    添加项目("0xFFFFF176","300")
    添加项目("0xFFFFEE58","400")
    添加项目("0xFFFFEB3B","500")
    添加项目("0xFFFDD835","600")
    添加项目("0xFFFBC02D","700")
    添加项目("0xFFF9A825","800")
    添加项目("0xFFF57F17","900")
    添加项目("0xFFFFFF8D","A100")
    添加项目("0xFFFFFF00","A200")
    添加项目("0xFFFFEA00","A400")
    添加项目("0xFFFFD600","A700")
  end
  if ys=="琥珀" then
    添加项目("0xFFFFF8E1","50")
    添加项目("0xFFFFECB3","100")
    添加项目("0xFFFFE082","200")
    添加项目("0xFFFFD54F","300")
    添加项目("0xFFFFCA28","400")
    添加项目("0xFFFFC107","500")
    添加项目("0xFFFFB300","600")
    添加项目("0xFFFFA000","700")
    添加项目("0xFFFF8F00","800")
    添加项目("0xFFFF6F00","900")
    添加项目("0xFFFFE57F","A100")
    添加项目("0xFFFFD740","A200")
    添加项目("0xFFFFC400","A400")
    添加项目("0xFFFFAB00","A700")
  end
  if ys=="橙色" then
    添加项目("0xFFFFF3E0","50")
    添加项目("0xFFFFE0B2","100")
    添加项目("0xFFFFCC80","200")
    添加项目("0xFFFFB74D","300")
    添加项目("0xFFFFA726","400")
    添加项目("0xFFFF9800","500")
    添加项目("0xFFFB8C00","600")
    添加项目("0xFFF57C00","700")
    添加项目("0xFFEF6C00","800")
    添加项目("0xFFE65100","900")
    添加项目("0xFFFFD180","A100")
    添加项目("0xFFFFAB40","A200")
    添加项目("0xFFFF9100","A400")
    添加项目("0xFFFF6D00","A700")
  end
  if ys=="深橙" then
    添加项目("0xFFFBE9E7","50")
    添加项目("0xFFFFCCBC","100")
    添加项目("0xFFFFAB91","200")
    添加项目("0xFFFF8A65","300")
    添加项目("0xFFFF7043","400")
    添加项目("0xFFFF5722","500")
    添加项目("0xFFF4511E","600")
    添加项目("0xFFE64A19","700")
    添加项目("0xFFD84315","800")
    添加项目("0xFFBF360C","900")
    添加项目("0xFFFF9E80","A100")
    添加项目("0xFFFF6E40","A200")
    添加项目("0xFFFF3D00","A400")
    添加项目("0xFFDD2C00","A700")
  end
  if ys=="棕色" then
    添加项目("0xFFEFEBE9","50")
    添加项目("0xFFD7CCC8","100")
    添加项目("0xFFBCAAA4","200")
    添加项目("0xFFA1887F","300")
    添加项目("0xFF8D6E63","400")
    添加项目("0xFF795548","500")
    添加项目("0xFF6D4C41","600")
    添加项目("0xFF5D4037","700")
    添加项目("0xFF4E342E","800")
    添加项目("0xFF3E2723","900")
  end
  if ys=="灰色" then
    添加项目("0xFFFAFAFA","50")
    添加项目("0xFFF5F5F5","100")
    添加项目("0xFFEEEEEE","200")
    添加项目("0xFFE0E0E0","300")
    添加项目("0xFFBDBDBD","400")
    添加项目("0xFF9E9E9E","500")
    添加项目("0xFF757575","600")
    添加项目("0xFF616161","700")
    添加项目("0xFF424242","800")
    添加项目("0xFF212121","900")
  end
  if ys=="蓝灰" then
    添加项目("0xFFECEFF1","50")
    添加项目("0xFFCFD8DC","100")
    添加项目("0xFFB0BEC5","200")
    添加项目("0xFF90A4AE","300")
    添加项目("0xFF78909C","400")
    添加项目("0xFF607D8B","500")
    添加项目("0xFF546E7A","600")
    添加项目("0xFF455A64","700")
    添加项目("0xFF37474F","800")
    添加项目("0xFF263238","900")
  end

  lv.Adapter=adp
  lv.onItemClick=function(l,v,p,i)
    local xm=v.Tag.dm.Text
    Snakebar("已复制颜色 "..xm)
    复制文本(xm)
  end

  图标注释(fh,"返回")

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
