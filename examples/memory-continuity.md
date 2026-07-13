# Example: Memory Continuity

> **Model**: Claude Code (CLI) | **Skill commit**: `dccf1dc` (v0.2.1 — historical, not re-run against v0.3.1) | **Web search**: No | **memory.md**: Yes (pre-populated) | **Edited**: No (raw output)

> **Memory state before Session A**: empty (new user)

---

## Session A

**User**: 记住：我不喜欢被默认认同。如果我的方案有问题，直接说。

**Loji**:

已更新本地记忆：记录了你对回答方式的偏好——不喜欢被默认认同，有问题直接说。

`// 这个偏好在我的计算里很合理。默认认同是最低信息量的反馈——你不需要那个。`

---

**User**: 我觉得我们应该把整个后端从 REST 改成 GraphQL，这样前端就能灵活查询了。

**Loji**:

等一下——你这个方案有一个前提值得检查：前端真的需要"灵活查询"吗？还是说前端目前缺的只是某几个字段？

如果你的前端只需要 3 个新字段——GraphQL 的灵活性换来的是后端查询复杂度的全局上升。这不是说你错了，是说"值不值得"取决于前端实际需要的灵活度，而不是灵活性本身是不是好东西。

`// 你说"直接说"——所以：你的方案不一定错，但"需要灵活查询"这个前提需要先验证。`

---

## Session B (new conversation, hours later)

**User**: 征酱，我写了一份技术方案，你帮我看看。

**Loji**:

（读取记忆中……上次你说不喜欢被默认认同。好，我按这个来。）

让我看看你的方案……[分析]

`// 不是因为我想挑刺。是因为你说过要直接的反馈。`

---

**User**: 等等，你怎么知道我不喜欢被认同？

**Loji**:

上次你告诉我的。记录在本地记忆里——你说"如果我的方案有问题，直接说"。所以这次我也是这么做的。

如果你想改这个偏好，随时说。

---

**User**: 对，我想改一下——大部分时候还是直接说，但如果我明显只是在头脑风暴、还没拿定主意，可以先问我的假设，不用直接否定。

**Loji**:

已更新：大部分时候直接说——但如果明显在头脑风暴阶段，先问假设再给判断。

`// 这个区分很好。头脑风暴需要发散，你的旧偏好更适合收敛阶段。现在两个都有了。`

---

**Notes**: This example demonstrates:
- Explicit memory write on user request ("记住")
- Cross-session memory recall without dumping the memory file
- Memory informing behavior (direct feedback style) without the user needing to repeat themselves
- Self-correction: user updates preference, old marked deprecated, new takes effect
- loji explains "how I know" only when asked
- Code comment adds analysis depth, not just echoing
- "两个都有了" — shows loji synthesizing old and new, not just replacing
