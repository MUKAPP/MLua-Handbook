require "import"
import "mods.muk"

local debug_time_create_n=os.clock()

function onCreate()
  设置视图("layout/about")

  listalpha=AlphaAnimation(0,1)
  listalpha.setDuration(256)
  controller=LayoutAnimationController(listalpha)
  controller.setDelay(0.4)
  controller.setOrder(LayoutAnimationController.ORDER_NORMAL)
  scrollviewn.setLayoutAnimation(controller)

  波纹({back},"圆主题")
  波纹({item1},"方主题")
  波纹({item2,item5,item6,item7,item8,item9},"方自适应")

  图标注释(back,"返回")

  bbh.setText("版本号："..应用版本名)
  item1.onClick=function()
    Snakebar("Always believe that good things are about to happen.")
  end

  item7.onClick=function()
    QQ群("686976850")
  end

  item8.onClick=function()
    Snakebar("正在检查更新…")
    检查更新(true)
  end

  item9.onClick=function()
    local 更新日志=[[
1.4.0 2020年2月18日
1. 优化夜间模式
2. 优化细节
3. 去除启动图
4. 修复特性

1.3.5 2020年2月14日
1. 新增源码功能
2. 优化体验
3. 修复一些特性

1.3.0 2020年1月2日
1. 新增笔记功能
2. 优化细节，添加动画
3. 修复一些特性

1.2.5 2019年12月26日
1. 修复一些特性

1.2.0 2019年12月25日
1. 更改UI、图标等
2. 夜间模式适配原生夜间模式
3. 修复一些特性
4. 由于一些原因，更改了应用包名，请手动卸载之前的版本

1.1.6 2019年9月15日
1. 紧急修复因强制https导致的302跳转

1.1.5 2019年8月28日
1. 去除社区
2. 修复特性(s)
3. 优化UI

1.1.0 2019年8月3日
1. 修复SDK版本<23时主页状态栏看不到的特性
2. 优化UI
3. 增加一些关键字(使用androlua+4.3.3打包)
4. 修复没有json等的特性

1.0.8 2019年7月24日
1. 修复部分机型系统字体过大导致软件布局错位的特性
2. 新增工具“get/post调试”
3. 新增工具“Jar转Dex”
4. 新增工具“代码调试”
5. 新增Shortcut(动态)
6. 优化流畅度
7. 去除首页播放器
8. 简单适配分屏模式
9. 修复社区看贴页面不能下载附件的特性
10. 优化UI
11. 修复小bug(s)

1.0.6 2019年7月16日
1. 新增社区
2. 优化UI

1.0.4 2019年7月6日
1. 推荐文章阅读排版优化
2. 新增夜间模式
3. 优化内置浏览器、教程视频查看等页面UI细节
4. 新增自动检查更新
5. 修复主页推荐获取报错的特性
6. 修复搜索结果中不能查看教程的特性

1.0.2 2019年6月28日
1. 教程页新增翻页
2. 设置页开放
3. 优化流畅度、优化细节

1.0.0 2019年6月23日
MLua手册正式发布]]

    跳转页面("view-tutorial",{"更新日志",更新日志})
  end

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