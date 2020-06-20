require "import"
import "android.widget.*"
import "android.view.*"
import "android.os.*"
import "android.graphics.drawable.ColorDrawable"

activity.Title="运行代码"
--[[_window = activity.getWindow();
_window.setBackgroundDrawable(ColorDrawable(0xffffffff));
_wlp = _window.getAttributes();
_wlp.gravity = Gravity.BOTTOM;
_wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
_wlp.height = WindowManager.LayoutParams.MATCH_PARENT;--WRAP_CONTENT
_window.setAttributes(_wlp);

activity.ActionBar.setBackgroundDrawable(ColorDrawable(0xFFFFFFFF))
activity.ActionBar.setElevation(4)

window=activity.getWindow()
window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
window.setStatusBarColor(0x21000000)
if tonumber(Build.VERSION.SDK)>=23 then
  window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
  window.setStatusBarColor(0xffffffff)
end]]

code,ts=...

xpcall(loadstring(code),function(data)
  import "mods.muk"
  双按钮对话框("运行出错",
  data,
  "好的",
  "Google翻译",
  function()
    关闭对话框(an)
  end,
  function()
    双按钮对话框内容("正在翻译…")
    if data:match("(.+):(.-):(.+)") then
      _,_,data=data:match("(.+):(.-):(.+)")
    end
    翻译(data,function(n)
      pcall(function()
        双按钮对话框内容(JSON.decode(n)[1][1][1])
      end)
    end)
  end)
end)
