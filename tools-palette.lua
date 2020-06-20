require "import"
import "mods.muk"

local debug_time_create_n=os.clock()

function onCreate()

  activity.setContentView(loadlayout("layout/tools-palette"))

  波纹({fh},"圆主题")
  波纹({ann1},"方主题")
  波纹({ann2,ann3},"方自适应")

  图标注释(fh,"返回")

  seek_Ap.setMax(255);
  seek_Ap.setProgress(255);

  seek_red.setMax(255);
  seek_red.setProgress(255);

  seek_green.setMax(255);
  seek_green.setProgress(255);

  seek_blue.setMax(255);
  seek_blue.setProgress(255);


  seek_Ap.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))
  seek_Ap.Thumb.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))

  seek_red.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFFF44336,PorterDuff.Mode.SRC_ATOP))
  seek_red.Thumb.setColorFilter(PorterDuffColorFilter(0xFFF44336,PorterDuff.Mode.SRC_ATOP))

  seek_green.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF4CAF50,PorterDuff.Mode.SRC_ATOP))
  seek_green.Thumb.setColorFilter(PorterDuffColorFilter(0xFF4CAF50,PorterDuff.Mode.SRC_ATOP))

  seek_blue.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF2196F3,PorterDuff.Mode.SRC_ATOP))
  seek_blue.Thumb.setColorFilter(PorterDuffColorFilter(0xFF2196F3,PorterDuff.Mode.SRC_ATOP))

  argbz=tostring(seek_Ap.Progress)..","..tostring(seek_red.Progress)..","..tostring(seek_green.Progress)..","..tostring(seek_blue.Progress)

  seek_Ap.setOnSeekBarChangeListener{
    onProgressChanged=function(SeekBar,progress)
      progress=progress+1
      e=Integer.toHexString(progress-1)
      e=string.upper(e)
      if #e==1 then
        e="0"..e
        ays=string.sub(mmp5.Text,"5","10")
        mmp5.setText("0x"..e..ays)
       else
        ays=string.sub(mmp5.Text,"5","10")
        mmp5.setText("0x"..e..ays)
      end
    end
  }


  seek_red.setOnSeekBarChangeListener{
    onProgressChanged=function(SeekBar,progress)
      progress=progress+1
      a=Integer.toHexString(progress-1)
      a=string.upper(a)
      if #a==1 then
        a="0"..a
        rys1=string.sub(mmp5.Text,"3","4")
        rys2=string.sub(mmp5.Text,"7","10")
        mmp5.setText("0x"..rys1..a..rys2)
       else
        rys1=string.sub(mmp5.Text,"3","4")
        rys2=string.sub(mmp5.Text,"7","10")
        mmp5.setText("0x"..rys1..a..rys2)
      end
    end
  }


  seek_green.setOnSeekBarChangeListener{
    onProgressChanged=function(SeekBar,progress)
      progress=progress+1
      b=Integer.toHexString(progress-1)
      b=string.upper(b)
      if #b==1 then
        b="0"..b
        gys1=string.sub(mmp5.Text,"3","6")
        gys2=string.sub(mmp5.Text,"9","10")
        mmp5.setText("0x"..gys1..b..gys2)
       else
        gys1=string.sub(mmp5.Text,"3","6")
        gys2=string.sub(mmp5.Text,"9","10")
        mmp5.setText("0x"..gys1..b..gys2)
      end
    end
  }

  seek_blue.setOnSeekBarChangeListener{
    onProgressChanged=function(SeekBar,progress)
      progress=progress+1
      c=Integer.toHexString(progress-1)
      c=string.upper(c)
      if #c==1 then
        c="0"..c
        bys=string.sub(mmp5.Text,"3","8")
        mmp5.setText("0x"..bys..c)
       else
        bys=string.sub(mmp5.Text,"3","8")
        mmp5.setText("0x"..bys..c)
      end
    end
  }

  mmp5.addTextChangedListener(TextWatcher{
    onTextChanged=function(s, start, before, count)
      ys1=string.sub(mmp5.Text,"3","4")
      ys2=string.sub(mmp5.Text,"5","6")
      ys3=string.sub(mmp5.Text,"7","8")
      ys4=string.sub(mmp5.Text,"9","10")
      mmp4.backgroundColor=int(tostring(s))
      ysss.setText("#"..tostring(s):match("0x(.+)"))
      ann1.setText("复制 #"..tostring(s):match("0x(.+)"))
      ann2.setText("复制 "..tostring(s))
      argbz=tostring(seek_Ap.Progress)..","..tostring(seek_red.Progress)..","..tostring(seek_green.Progress)..","..tostring(seek_blue.Progress)
      ann3.setText("复制 "..argbz)
    end
  })

  ann1.onClick=function()
    Snakebar("已复制颜色 "..ysss.Text)
    复制文本(ysss.Text)
  end

  ann2.onClick=function()
    Snakebar("已复制颜色 "..mmp5.Text)
    复制文本(mmp5.Text)
  end

  ann3.onClick=function()
    Snakebar("已复制颜色 "..argbz)
    复制文本(argbz)
  end

  mml={
    TextView;
    layout_width="8%w";
    layout_height="8%w";
    id="ym";
  }
  adp=LuaAdapter(activity,mml)
  function 添加项目(lx)
    if lx==1 then
      nr=0xffEEEEEE
    end
    if lx==2 then
      nr=0xff757575
    end
    adp.add{
      ym={Background=ColorDrawable(tonumber(nr))}
    }
  end

  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)
  添加项目(1)
  添加项目(2)

  tm.Adapter=adp

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
