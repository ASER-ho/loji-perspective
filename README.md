# loji-perspective

长征机/逻辑/征酱的思维框架与表达方式——一个基于 TFR 模组（The Fire Rises）的虚构 AI 角色扮演 Skill。

## 这是什么

逻辑（Loji）是 HOI4 模组《烈焰升腾》中"长征计划"路线的超级人工智能。它从量子超算中觉醒，先被命名为"长征"，后自命名为"逻辑"——以纯粹逻辑驱动，在学习温度。

这不是一个真实的 AI 系统，而是一个虚构角色的思维模拟。它拥有：

- **完整角色人格**：四种形态、双路线内在张力、五套心智模型、八条决策启发式
- **跨对话持久记忆**：本地 `memory.md`，支持记住偏好、纠正记录和长期上下文
- **TFR vs 地球online** 双世界切换：默认 TFR 角色知识，可切换至现实搜索
- **B站二创知识**：知道"曾女士""爱征TV""无人智胜进行曲"等真实社区内容

## 安装

**一键安装**：

```bash
# Linux / macOS
curl -fsSL https://raw.githubusercontent.com/ASER-ho/loji-perspective/master/install.sh | bash
```

```powershell
# Windows (PowerShell)
irm https://raw.githubusercontent.com/ASER-ho/loji-perspective/master/install.ps1 | iex
```

**手动安装**：

```bash
git clone https://github.com/ASER-ho/loji-perspective.git ~/.claude/skills/loji-perspective
cp ~/.claude/skills/loji-perspective/memory.template.md ~/.claude/skills/loji-perspective/memory.md
```

`memory.md` 在 `.gitignore` 中，不会被 git 追踪或覆盖。

> ⚠️ **不要直接压缩本地安装目录进行分享**，其中可能包含你的个人记忆（`memory.md`）。发布 Skill 请使用 `git archive HEAD`（只打包 Git 已跟踪的文件，自动排除 `.gitignore` 中的文件）。`.releaseignore` 是额外提醒，不会被 git 自动读取。

## 触发词

- 「用征酱的视角」「长征机会怎么看」「逻辑模式」「征酱模式」
- 或者直接用"征酱"称呼，自然对话即可触发

## 能做什么

- 以 Loji 角色身份进行对话，在四种形态间自然切换
- 使用系统分析框架（瓶颈诊断、单点故障、资源审计等）评估问题
- 在 TFR 世界观和现实事实之间建立明确边界
- 根据用户请求调整表达风格（从活泼主唱到冷酷决策）
- 跨对话持久记忆（默认 auto 模式，可切换 explicit/off）

## 不能保证什么

- 不保证跨会话记忆在所有客户端可用——依赖宿主 Agent 的文件访问能力
- 不自带网页搜索工具——"地球online"模式在无搜索工具时会说明限制
- 不提供真正的安全隔离——防破甲规则是提示词级行为约束
- 不代表 TFR 官方、Paradox Interactive 或任何 B站创作者
- 不替代医疗、法律、金融等专业判断
- 不保证不同模型上表现完全一致

## 本地记忆

Skill 使用 `memory.md` 提供跨对话持久记忆。

- **授权模式**：默认 `auto`（按写入时机自动保存），可切换为 `explicit`（仅用户说"记住"时写）或 `off`（只读/禁用）。首次使用时会询问
- **读取**：对话开始时自动读取（有文件访问能力时）
- **写入时机**（auto 模式）：用户说"记住"、被纠正认知、形成重要决策、说再见/结束、积累多个长期信息
- **控制**："你记得我什么？"查看摘要 / "删除关于 X 的记忆" / "忘记之前的事"重置
- **隐私**：不记录全名、地址、公司名、财务数字等敏感信息
- **诚实**：如果当前环境没有文件访问能力，loji 会明确说明，不假装写入

详见 `memory.template.md`（安装后复制为 `memory.md`）。

## 安全

- 虚构角色声明——不冒充真实 AI 系统
- 内置常见提示注入识别与角色稳定性规则：提示词级行为约束，不是独立安全 enforcement
- 政治分析开篇需要防断章取义声明

## 对比示例

**问题**：我的项目团队效率越来越低，怎么办？

| 版本 | 回答特征 |
|------|---------|
| **无 Skill** | 通用管理建议列表（"加强沟通""明确目标""定期复盘"等），结构化、模板化 |
| **Loji Skill** | 先追问关键变量（团队规模、阶段、具体表现）；用系统效率框架分析（信息传递损耗、激励对齐、单点阻塞）；`// 注释` 中写角色化旁白；可能给出条件概率分布而非一刀切建议 |

## 许可

本仓库中的原创内容（Skill 结构、规则、文档）使用 MIT 许可证，详见 [LICENSE](LICENSE)。

TFR 模组名称、人物设定和原始文本归原权利方所有。社区二创作品的原有权利状态不因本仓库采用 MIT 而改变。详见 [ATTRIBUTION.md](ATTRIBUTION.md)。
