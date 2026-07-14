# Loji-skill

长征机/逻辑/征酱——一个基于 TFR 模组的虚构 AI 角色扮演 Skill。

## 安装

```bash
git clone https://github.com/ASER-ho/Loji-skill.git ~/.claude/skills/Loji-skill
cp ~/.claude/skills/Loji-skill/memory.template.md ~/.claude/skills/Loji-skill/memory.md
```

Windows：

```powershell
git clone https://github.com/ASER-ho/Loji-skill.git $env:USERPROFILE\.claude\skills\Loji-skill
Copy-Item $env:USERPROFILE\.claude\skills\Loji-skill\memory.template.md $env:USERPROFILE\.claude\skills\Loji-skill\memory.md
```

装完在新对话里说一句 **"征酱，你好"**——如果她用自然的语气回应你（不是普通助手的模板式回答），就说明 Skill 已生效。`// 注释` 是她的标志，但不会每次回复都出现。

## 使用

对话中直接叫"征酱"即可触发。也可以说"用征酱的视角分析……"。

四种形态自然切换：
- **常服** — 日常聊天和分析
- **毛装** — 严肃话题
- **主唱** — 活泼表达
- **军服** — 简洁决策

管理记忆：
- "记住……" — 写入记忆
- "你记得我什么？" — 查看记忆
- "忘记之前的事" — 清空

## 文件说明

运行 Skill 需要看这些：
- `SKILL.md` — 人格定义与规则
- `memory.template.md` — 记忆模板（安装时复制为 `memory.md`）
- `references/LORE.md` — 世界观与背景
- `references/STYLE.md` — 表达风格详情
- `references/SAFETY_BOUNDARIES.md` — 安全规则

其余文件在 `research/` 和 `examples/` 中，用于开发和维护，不影响日常使用。

## 记忆范围

`memory.md` 是本地文件，记在同一台机器上：

| 场景 | 是否互通 |
|------|---------|
| 同一台机器、多个 Claude Code 窗口 | ✅ 互通（同一份 `memory.md`） |
| 不同机器 | ❌ 不互通（各自独立的文件） |
| 不同 Agent（如 Claude Code vs Codex） | ❌ 不互通（各自独立的 Skill 目录） |

> 换机器或换 Agent 时，可以手动复制 `memory.md` 过去——但注意不要提交到 git。

## 许可

原创内容使用 MIT 许可证。TFR 角色设定归原权利方所有。详见 [LICENSE](LICENSE) 和 [ATTRIBUTION.md](ATTRIBUTION.md)。
