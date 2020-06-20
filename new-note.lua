require "import"
import "mods.muk"
JSON=import "mods.json"

local debug_time_create_n=os.clock()

_link=...

_title="新建笔记"
_but="创建"
if _link~=nil then
  _,title=_link:match("(.+)/(.+)")
  _title="重命名 "..title
  _but="重命名"
end

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
              hint="笔记名称(不要带干扰文件路径的符号)";
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
                Text=_but;
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

  activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE|WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)
  --/storage/emulated/0/AndroLua/project/Jar转Dex/myJar/gson.jar
  ann1.onClick=function()
    if Jarurl.text~="" then
      if _but=="重命名" then
        重命名文件(_link,内置存储文件("Note/"..Jarurl.text))
        activity.result({"newnote"})
        return true
      end
      创建文件(内置存储文件("Note/"..Jarurl.text))
      activity.newActivity("edit-note",{内置存储文件("Note/"..Jarurl.text)})
      activity.result({"newnote"})
     else
      Snakebar("请填写笔记名称")
    end
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
