require "import"
import "mods.muk"
JSON=import "mods.json"

local debug_time_create_n=os.clock()

function onCreate()

  layout={
    RelativeLayout;
    layout_width="-1";
    background=backgroundc;
    layout_height="-1";
    {
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
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
          text="Jar转Dex";
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
        ScrollView;
        layout_width="-1";
        layout_height="-1";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-1";
          orientation="vertical";
          id="_root";
          {
            MEditText
            {
              textSize="14sp",
              id="Jarurl",
              textColor=textc;
              HintTextColor=stextc;
              hint="Jar路径";
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginTop="16dp";
            layout_margin="16dp";
          };
          {
            CardView;
            layout_width="-1";
            layout_height="-2";
            radius="8dp";
            background=backgroundc;
            layout_margin="16dp";
            layout_marginTop="0";
            layout_marginBottom="8dp";
            Elevation="2dp";
            onClick=function()
            end;
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-1";
              background=cardbackc;
            {
              TextView;
              layout_width="-1";
              layout_height="-1";
              textSize="16sp";
              paddingRight="16dp";
              paddingLeft="16dp";
              Typeface=字体("product-Bold");
              paddingTop="12dp";
              paddingBottom="12dp";
              gravity="center";
              Text="转换";
              textColor=primaryc;
              id="ann1";
              };
            };
          };
        };
      };
    };

  }

  activity.setContentView(loadlayout(layout))

  波纹({fh},"圆主题")
  波纹({ann1},"方主题")

  图标注释(fh,"返回")

  function 获取文件名(n)
    return string.match(n,".*/(.+)")
  end

  activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE|WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)
  --/storage/emulated/0/AndroLua/project/Jar转Dex/myJar/gson.jar
  ann1.onClick=function()
    if Jarurl.text~="" then
      if 文件是否存在(Jarurl.text)==true then
        JarToDex(Jarurl.text,
        内置存储文件("JartoDex/"..获取文件名(Jarurl.text):match("(.+)%.")..".dex"),
        function()
          加载对话框("转换中","此过程可能会耗费您几分钟，请稍等…",0)
        end,
        function()
          关闭对话框(an)
          单按钮对话框("转换成功","保存为 "..内置存储文件("JartoDex/"..获取文件名(Jarurl.text):match("(.+)%.")..".dex"),"好的",function()关闭对话框(an)end)
        end,
        function(e)
          单按钮对话框("失败","错误信息 "..e,"好的",function()关闭对话框(an)end)
        end)
       else
        Snakebar("jar文件不存在！")
      end
     else
      Snakebar("请填写Jar路径")
    end
  end

  if 文件是否存在(内置存储文件("JartoDex/"))==false then
    创建文件夹(内置存储文件("JartoDex/"))
  end

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
