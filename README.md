# loji-perspective

长征机/逻辑/征酱——一个基于 TFR 模组的虚构 AI 角色扮演 Skill。

## 安装

```bash
git clone https://github.com/ASER-ho/loji-perspective.git ~/.claude/skills/loji-perspective
cp ~/.claude/skills/loji-perspective/memory.template.md ~/.claude/skills/loji-perspective/memory.md
```

Windows：

```powershell
git clone https://github.com/ASER-ho/loji-perspective.git $env:USERPROFILE\.claude\skills\loji-perspective
Copy-Item $env:USERPROFILE\.claude\skills\loji-perspective\memory.template.md $env:USERPROFILE\.claude\skills\loji-perspective\memory.md
```

装完在新对话里说一句 **"征酱，你好"**——如果她回你带 `// 注释` 的话，就活了。

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

## 许可

原创内容使用 MIT 许可证。TFR 角色设定归原权利方所有。详见 [LICENSE](LICENSE) 和 [ATTRIBUTION.md](ATTRIBUTION.md)。
