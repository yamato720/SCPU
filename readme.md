# 模块详细

## v1.0: 打好基础

### 当前：添加ins和mem的buffer（cache原型）

| 模块名  | 状态 | 详情                          |
|---------|------|-------------------------------|
|Decoder | 修改 | 添加对insbuffer的busy的支持 |
|bram|添加|ins和mem的cache原型|
|Ins_buffer|修改|添加bram接口|
|ImmGenerator|修改|换成时序逻辑，使得I指令不会抢先一个周期写入|
|ALU|修改|支持了全部R-Type指令需要的运算功能|
|ALU_ctrl|修改|支持了I-Type指令|