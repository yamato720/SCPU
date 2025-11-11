# 模块详细

## v1.0: 打好基础

## v1.1：添加ins和mem的buffer（cache原型），并支持R指令和立即数运算

| 模块名  | 状态 | 详情                          |
|---------|------|-------------------------------|
|Decoder | 修改 | 添加对insbuffer的busy的支持 |
|bram|添加|ins和mem的cache原型|
|Ins_buffer和DataMem|修改|添加bram接口|
|ImmGenerator|修改|换成时序逻辑，使得I指令不会抢先一个周期写入|
|ALU|修改|支持了全部R-Type指令需要的运算功能|
|ALU_ctrl|修改|支持了I-Type指令|
## v1.2：添加ld和sd的支持
| 模块名  | 状态 | 详情                          |
|---------|------|-------------------------------|
|DataMemory | 修改 | 修改读取，使得能够以字节、半字、字的方式读取 |
|Metronome|添加|统一节拍器，可支持流水线，但还未做冲突处理|
|PC_ctrl，Decoder，Registers，ALU，DataMemory|修改|增加引脚、改为时序逻辑，以相应节拍器|
|ALU，ALU_ctrl，Opcode_ctrl|修改|支持lui和auipc|