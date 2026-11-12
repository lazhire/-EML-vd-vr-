# 第一人称 · VR 界面保护 0.1.0-vr-ui-guard-056

这是 E Mod Loader 第一人称示例的修改版，基于工作区保存的上游提交 `113405816cf8f7628e03dfe68d7f6ea6866ccf9a` 源码。采用 AGPL-3.0-only，见 LICENSE；不是作者官方发行版。

与 quest3.vrvd 0.5.6 同时导入 EML，退出并重启游戏后使用。模块 ID 保持 example.first-person，因此更新原条目，不要并行加载重复的第一人称模块。

新增游戏线程上的 VR 界面暂停协作：查询配套 VR 模块的状态，在菜单期间调用原有退出/清理逻辑，保留用户意图；返回玩法恢复，用户主动退出或禁用优先。没有配套 VR 运行时保持普通第一人称功能。

默认 active=false，不自动启动游戏。原减号热键、模块页面的切换/退出，以及保存默认进入第一人称都可用。暂停状态可在页面查看 vr_menu_resume_pending。

对应源码包含 native 全部源文件；所需 EML ABI/nlohmann 头文件随同一总包 VR 源码 vendor 目录提供。构建用相邻 eml-ui-routing-056/tools/build_pair.py。离线构建与暂停意图测试通过与否以总包 BUILD_CHECKS.json 为准；未做本版游戏内视觉验证。
