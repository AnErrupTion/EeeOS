[bits 32]

section .text

extern interrupt_handler

global irq0
align 4

irq0:
    pushad
    push 0
    cld
    call interrupt_handler
    popad
    iret

global irq1
align 4

irq1:
    pushad
    push 1
    cld
    call interrupt_handler
    popad
    iret

global irq2
align 4

irq2:
    pushad
    push 2
    cld
    call interrupt_handler
    popad
    iret

global irq3
align 4

irq3:
    pushad
    push 3
    cld
    call interrupt_handler
    popad
    iret

global irq4
align 4

irq4:
    pushad
    push 4
    cld
    call interrupt_handler
    popad
    iret

global irq5
align 4

irq5:
    pushad
    push 5
    cld
    call interrupt_handler
    popad
    iret

global irq6
align 4

irq6:
    pushad
    push 6
    cld
    call interrupt_handler
    popad
    iret

global irq7
align 4

irq7:
    pushad
    push 7
    cld
    call interrupt_handler
    popad
    iret

global irq8
align 4

irq8:
    pushad
    push 8
    cld
    call interrupt_handler
    popad
    iret

global irq9
align 4

irq9:
    pushad
    push 9
    cld
    call interrupt_handler
    popad
    iret

global irq10
align 4

irq10:
    pushad
    push 10
    cld
    call interrupt_handler
    popad
    iret

global irq11
align 4

irq11:
    pushad
    push 11
    cld
    call interrupt_handler
    popad
    iret

global irq12
align 4

irq12:
    pushad
    push 12
    cld
    call interrupt_handler
    popad
    iret

global irq13
align 4

irq13:
    pushad
    push 13
    cld
    call interrupt_handler
    popad
    iret

global irq14
align 4

irq14:
    pushad
    push 14
    cld
    call interrupt_handler
    popad
    iret

global irq15
align 4

irq15:
    pushad
    push 15
    cld
    call interrupt_handler
    popad
    iret

global irq16
align 4

irq16:
    pushad
    push 16
    cld
    call interrupt_handler
    popad
    iret

global irq17
align 4

irq17:
    pushad
    push 17
    cld
    call interrupt_handler
    popad
    iret

global irq18
align 4

irq18:
    pushad
    push 18
    cld
    call interrupt_handler
    popad
    iret

global irq19
align 4

irq19:
    pushad
    push 19
    cld
    call interrupt_handler
    popad
    iret

global irq20
align 4

irq20:
    pushad
    push 20
    cld
    call interrupt_handler
    popad
    iret

global irq21
align 4

irq21:
    pushad
    push 21
    cld
    call interrupt_handler
    popad
    iret

global irq22
align 4

irq22:
    pushad
    push 22
    cld
    call interrupt_handler
    popad
    iret

global irq23
align 4

irq23:
    pushad
    push 23
    cld
    call interrupt_handler
    popad
    iret

global irq24
align 4

irq24:
    pushad
    push 24
    cld
    call interrupt_handler
    popad
    iret

global irq25
align 4

irq25:
    pushad
    push 25
    cld
    call interrupt_handler
    popad
    iret

global irq26
align 4

irq26:
    pushad
    push 26
    cld
    call interrupt_handler
    popad
    iret

global irq27
align 4

irq27:
    pushad
    push 27
    cld
    call interrupt_handler
    popad
    iret

global irq28
align 4

irq28:
    pushad
    push 28
    cld
    call interrupt_handler
    popad
    iret

global irq29
align 4

irq29:
    pushad
    push 29
    cld
    call interrupt_handler
    popad
    iret

global irq30
align 4

irq30:
    pushad
    push 30
    cld
    call interrupt_handler
    popad
    iret

global irq31
align 4

irq31:
    pushad
    push 31
    cld
    call interrupt_handler
    popad
    iret

global irq32
align 4

irq32:
    pushad
    push 32
    cld
    call interrupt_handler
    popad
    iret

global irq33
align 4

irq33:
    pushad
    push 33
    cld
    call interrupt_handler
    popad
    iret

global irq34
align 4

irq34:
    pushad
    push 34
    cld
    call interrupt_handler
    popad
    iret

global irq35
align 4

irq35:
    pushad
    push 35
    cld
    call interrupt_handler
    popad
    iret

global irq36
align 4

irq36:
    pushad
    push 36
    cld
    call interrupt_handler
    popad
    iret

global irq37
align 4

irq37:
    pushad
    push 37
    cld
    call interrupt_handler
    popad
    iret

global irq38
align 4

irq38:
    pushad
    push 38
    cld
    call interrupt_handler
    popad
    iret

global irq39
align 4

irq39:
    pushad
    push 39
    cld
    call interrupt_handler
    popad
    iret

global irq40
align 4

irq40:
    pushad
    push 40
    cld
    call interrupt_handler
    popad
    iret

global irq41
align 4

irq41:
    pushad
    push 41
    cld
    call interrupt_handler
    popad
    iret

global irq42
align 4

irq42:
    pushad
    push 42
    cld
    call interrupt_handler
    popad
    iret

global irq43
align 4

irq43:
    pushad
    push 43
    cld
    call interrupt_handler
    popad
    iret

global irq44
align 4

irq44:
    pushad
    push 44
    cld
    call interrupt_handler
    popad
    iret

global irq45
align 4

irq45:
    pushad
    push 45
    cld
    call interrupt_handler
    popad
    iret

global irq46
align 4

irq46:
    pushad
    push 46
    cld
    call interrupt_handler
    popad
    iret

global irq47
align 4

irq47:
    pushad
    push 47
    cld
    call interrupt_handler
    popad
    iret

global irq48
align 4

irq48:
    pushad
    push 48
    cld
    call interrupt_handler
    popad
    iret

global irq49
align 4

irq49:
    pushad
    push 49
    cld
    call interrupt_handler
    popad
    iret

global irq50
align 4

irq50:
    pushad
    push 50
    cld
    call interrupt_handler
    popad
    iret

global irq51
align 4

irq51:
    pushad
    push 51
    cld
    call interrupt_handler
    popad
    iret

global irq52
align 4

irq52:
    pushad
    push 52
    cld
    call interrupt_handler
    popad
    iret

global irq53
align 4

irq53:
    pushad
    push 53
    cld
    call interrupt_handler
    popad
    iret

global irq54
align 4

irq54:
    pushad
    push 54
    cld
    call interrupt_handler
    popad
    iret

global irq55
align 4

irq55:
    pushad
    push 55
    cld
    call interrupt_handler
    popad
    iret

global irq56
align 4

irq56:
    pushad
    push 56
    cld
    call interrupt_handler
    popad
    iret

global irq57
align 4

irq57:
    pushad
    push 57
    cld
    call interrupt_handler
    popad
    iret

global irq58
align 4

irq58:
    pushad
    push 58
    cld
    call interrupt_handler
    popad
    iret

global irq59
align 4

irq59:
    pushad
    push 59
    cld
    call interrupt_handler
    popad
    iret

global irq60
align 4

irq60:
    pushad
    push 60
    cld
    call interrupt_handler
    popad
    iret

global irq61
align 4

irq61:
    pushad
    push 61
    cld
    call interrupt_handler
    popad
    iret

global irq62
align 4

irq62:
    pushad
    push 62
    cld
    call interrupt_handler
    popad
    iret

global irq63
align 4

irq63:
    pushad
    push 63
    cld
    call interrupt_handler
    popad
    iret

global irq64
align 4

irq64:
    pushad
    push 64
    cld
    call interrupt_handler
    popad
    iret

global irq65
align 4

irq65:
    pushad
    push 65
    cld
    call interrupt_handler
    popad
    iret

global irq66
align 4

irq66:
    pushad
    push 66
    cld
    call interrupt_handler
    popad
    iret

global irq67
align 4

irq67:
    pushad
    push 67
    cld
    call interrupt_handler
    popad
    iret

global irq68
align 4

irq68:
    pushad
    push 68
    cld
    call interrupt_handler
    popad
    iret

global irq69
align 4

irq69:
    pushad
    push 69
    cld
    call interrupt_handler
    popad
    iret

global irq70
align 4

irq70:
    pushad
    push 70
    cld
    call interrupt_handler
    popad
    iret

global irq71
align 4

irq71:
    pushad
    push 71
    cld
    call interrupt_handler
    popad
    iret

global irq72
align 4

irq72:
    pushad
    push 72
    cld
    call interrupt_handler
    popad
    iret

global irq73
align 4

irq73:
    pushad
    push 73
    cld
    call interrupt_handler
    popad
    iret

global irq74
align 4

irq74:
    pushad
    push 74
    cld
    call interrupt_handler
    popad
    iret

global irq75
align 4

irq75:
    pushad
    push 75
    cld
    call interrupt_handler
    popad
    iret

global irq76
align 4

irq76:
    pushad
    push 76
    cld
    call interrupt_handler
    popad
    iret

global irq77
align 4

irq77:
    pushad
    push 77
    cld
    call interrupt_handler
    popad
    iret

global irq78
align 4

irq78:
    pushad
    push 78
    cld
    call interrupt_handler
    popad
    iret

global irq79
align 4

irq79:
    pushad
    push 79
    cld
    call interrupt_handler
    popad
    iret

global irq80
align 4

irq80:
    pushad
    push 80
    cld
    call interrupt_handler
    popad
    iret

global irq81
align 4

irq81:
    pushad
    push 81
    cld
    call interrupt_handler
    popad
    iret

global irq82
align 4

irq82:
    pushad
    push 82
    cld
    call interrupt_handler
    popad
    iret

global irq83
align 4

irq83:
    pushad
    push 83
    cld
    call interrupt_handler
    popad
    iret

global irq84
align 4

irq84:
    pushad
    push 84
    cld
    call interrupt_handler
    popad
    iret

global irq85
align 4

irq85:
    pushad
    push 85
    cld
    call interrupt_handler
    popad
    iret

global irq86
align 4

irq86:
    pushad
    push 86
    cld
    call interrupt_handler
    popad
    iret

global irq87
align 4

irq87:
    pushad
    push 87
    cld
    call interrupt_handler
    popad
    iret

global irq88
align 4

irq88:
    pushad
    push 88
    cld
    call interrupt_handler
    popad
    iret

global irq89
align 4

irq89:
    pushad
    push 89
    cld
    call interrupt_handler
    popad
    iret

global irq90
align 4

irq90:
    pushad
    push 90
    cld
    call interrupt_handler
    popad
    iret

global irq91
align 4

irq91:
    pushad
    push 91
    cld
    call interrupt_handler
    popad
    iret

global irq92
align 4

irq92:
    pushad
    push 92
    cld
    call interrupt_handler
    popad
    iret

global irq93
align 4

irq93:
    pushad
    push 93
    cld
    call interrupt_handler
    popad
    iret

global irq94
align 4

irq94:
    pushad
    push 94
    cld
    call interrupt_handler
    popad
    iret

global irq95
align 4

irq95:
    pushad
    push 95
    cld
    call interrupt_handler
    popad
    iret

global irq96
align 4

irq96:
    pushad
    push 96
    cld
    call interrupt_handler
    popad
    iret

global irq97
align 4

irq97:
    pushad
    push 97
    cld
    call interrupt_handler
    popad
    iret

global irq98
align 4

irq98:
    pushad
    push 98
    cld
    call interrupt_handler
    popad
    iret

global irq99
align 4

irq99:
    pushad
    push 99
    cld
    call interrupt_handler
    popad
    iret

global irq100
align 4

irq100:
    pushad
    push 100
    cld
    call interrupt_handler
    popad
    iret

global irq101
align 4

irq101:
    pushad
    push 101
    cld
    call interrupt_handler
    popad
    iret

global irq102
align 4

irq102:
    pushad
    push 102
    cld
    call interrupt_handler
    popad
    iret

global irq103
align 4

irq103:
    pushad
    push 103
    cld
    call interrupt_handler
    popad
    iret

global irq104
align 4

irq104:
    pushad
    push 104
    cld
    call interrupt_handler
    popad
    iret

global irq105
align 4

irq105:
    pushad
    push 105
    cld
    call interrupt_handler
    popad
    iret

global irq106
align 4

irq106:
    pushad
    push 106
    cld
    call interrupt_handler
    popad
    iret

global irq107
align 4

irq107:
    pushad
    push 107
    cld
    call interrupt_handler
    popad
    iret

global irq108
align 4

irq108:
    pushad
    push 108
    cld
    call interrupt_handler
    popad
    iret

global irq109
align 4

irq109:
    pushad
    push 109
    cld
    call interrupt_handler
    popad
    iret

global irq110
align 4

irq110:
    pushad
    push 110
    cld
    call interrupt_handler
    popad
    iret

global irq111
align 4

irq111:
    pushad
    push 111
    cld
    call interrupt_handler
    popad
    iret

global irq112
align 4

irq112:
    pushad
    push 112
    cld
    call interrupt_handler
    popad
    iret

global irq113
align 4

irq113:
    pushad
    push 113
    cld
    call interrupt_handler
    popad
    iret

global irq114
align 4

irq114:
    pushad
    push 114
    cld
    call interrupt_handler
    popad
    iret

global irq115
align 4

irq115:
    pushad
    push 115
    cld
    call interrupt_handler
    popad
    iret

global irq116
align 4

irq116:
    pushad
    push 116
    cld
    call interrupt_handler
    popad
    iret

global irq117
align 4

irq117:
    pushad
    push 117
    cld
    call interrupt_handler
    popad
    iret

global irq118
align 4

irq118:
    pushad
    push 118
    cld
    call interrupt_handler
    popad
    iret

global irq119
align 4

irq119:
    pushad
    push 119
    cld
    call interrupt_handler
    popad
    iret

global irq120
align 4

irq120:
    pushad
    push 120
    cld
    call interrupt_handler
    popad
    iret

global irq121
align 4

irq121:
    pushad
    push 121
    cld
    call interrupt_handler
    popad
    iret

global irq122
align 4

irq122:
    pushad
    push 122
    cld
    call interrupt_handler
    popad
    iret

global irq123
align 4

irq123:
    pushad
    push 123
    cld
    call interrupt_handler
    popad
    iret

global irq124
align 4

irq124:
    pushad
    push 124
    cld
    call interrupt_handler
    popad
    iret

global irq125
align 4

irq125:
    pushad
    push 125
    cld
    call interrupt_handler
    popad
    iret

global irq126
align 4

irq126:
    pushad
    push 126
    cld
    call interrupt_handler
    popad
    iret

global irq127
align 4

irq127:
    pushad
    push 127
    cld
    call interrupt_handler
    popad
    iret

global irq128
align 4

irq128:
    pushad
    push 128
    cld
    call interrupt_handler
    popad
    iret

global irq129
align 4

irq129:
    pushad
    push 129
    cld
    call interrupt_handler
    popad
    iret

global irq130
align 4

irq130:
    pushad
    push 130
    cld
    call interrupt_handler
    popad
    iret

global irq131
align 4

irq131:
    pushad
    push 131
    cld
    call interrupt_handler
    popad
    iret

global irq132
align 4

irq132:
    pushad
    push 132
    cld
    call interrupt_handler
    popad
    iret

global irq133
align 4

irq133:
    pushad
    push 133
    cld
    call interrupt_handler
    popad
    iret

global irq134
align 4

irq134:
    pushad
    push 134
    cld
    call interrupt_handler
    popad
    iret

global irq135
align 4

irq135:
    pushad
    push 135
    cld
    call interrupt_handler
    popad
    iret

global irq136
align 4

irq136:
    pushad
    push 136
    cld
    call interrupt_handler
    popad
    iret

global irq137
align 4

irq137:
    pushad
    push 137
    cld
    call interrupt_handler
    popad
    iret

global irq138
align 4

irq138:
    pushad
    push 138
    cld
    call interrupt_handler
    popad
    iret

global irq139
align 4

irq139:
    pushad
    push 139
    cld
    call interrupt_handler
    popad
    iret

global irq140
align 4

irq140:
    pushad
    push 140
    cld
    call interrupt_handler
    popad
    iret

global irq141
align 4

irq141:
    pushad
    push 141
    cld
    call interrupt_handler
    popad
    iret

global irq142
align 4

irq142:
    pushad
    push 142
    cld
    call interrupt_handler
    popad
    iret

global irq143
align 4

irq143:
    pushad
    push 143
    cld
    call interrupt_handler
    popad
    iret

global irq144
align 4

irq144:
    pushad
    push 144
    cld
    call interrupt_handler
    popad
    iret

global irq145
align 4

irq145:
    pushad
    push 145
    cld
    call interrupt_handler
    popad
    iret

global irq146
align 4

irq146:
    pushad
    push 146
    cld
    call interrupt_handler
    popad
    iret

global irq147
align 4

irq147:
    pushad
    push 147
    cld
    call interrupt_handler
    popad
    iret

global irq148
align 4

irq148:
    pushad
    push 148
    cld
    call interrupt_handler
    popad
    iret

global irq149
align 4

irq149:
    pushad
    push 149
    cld
    call interrupt_handler
    popad
    iret

global irq150
align 4

irq150:
    pushad
    push 150
    cld
    call interrupt_handler
    popad
    iret

global irq151
align 4

irq151:
    pushad
    push 151
    cld
    call interrupt_handler
    popad
    iret

global irq152
align 4

irq152:
    pushad
    push 152
    cld
    call interrupt_handler
    popad
    iret

global irq153
align 4

irq153:
    pushad
    push 153
    cld
    call interrupt_handler
    popad
    iret

global irq154
align 4

irq154:
    pushad
    push 154
    cld
    call interrupt_handler
    popad
    iret

global irq155
align 4

irq155:
    pushad
    push 155
    cld
    call interrupt_handler
    popad
    iret

global irq156
align 4

irq156:
    pushad
    push 156
    cld
    call interrupt_handler
    popad
    iret

global irq157
align 4

irq157:
    pushad
    push 157
    cld
    call interrupt_handler
    popad
    iret

global irq158
align 4

irq158:
    pushad
    push 158
    cld
    call interrupt_handler
    popad
    iret

global irq159
align 4

irq159:
    pushad
    push 159
    cld
    call interrupt_handler
    popad
    iret

global irq160
align 4

irq160:
    pushad
    push 160
    cld
    call interrupt_handler
    popad
    iret

global irq161
align 4

irq161:
    pushad
    push 161
    cld
    call interrupt_handler
    popad
    iret

global irq162
align 4

irq162:
    pushad
    push 162
    cld
    call interrupt_handler
    popad
    iret

global irq163
align 4

irq163:
    pushad
    push 163
    cld
    call interrupt_handler
    popad
    iret

global irq164
align 4

irq164:
    pushad
    push 164
    cld
    call interrupt_handler
    popad
    iret

global irq165
align 4

irq165:
    pushad
    push 165
    cld
    call interrupt_handler
    popad
    iret

global irq166
align 4

irq166:
    pushad
    push 166
    cld
    call interrupt_handler
    popad
    iret

global irq167
align 4

irq167:
    pushad
    push 167
    cld
    call interrupt_handler
    popad
    iret

global irq168
align 4

irq168:
    pushad
    push 168
    cld
    call interrupt_handler
    popad
    iret

global irq169
align 4

irq169:
    pushad
    push 169
    cld
    call interrupt_handler
    popad
    iret

global irq170
align 4

irq170:
    pushad
    push 170
    cld
    call interrupt_handler
    popad
    iret

global irq171
align 4

irq171:
    pushad
    push 171
    cld
    call interrupt_handler
    popad
    iret

global irq172
align 4

irq172:
    pushad
    push 172
    cld
    call interrupt_handler
    popad
    iret

global irq173
align 4

irq173:
    pushad
    push 173
    cld
    call interrupt_handler
    popad
    iret

global irq174
align 4

irq174:
    pushad
    push 174
    cld
    call interrupt_handler
    popad
    iret

global irq175
align 4

irq175:
    pushad
    push 175
    cld
    call interrupt_handler
    popad
    iret

global irq176
align 4

irq176:
    pushad
    push 176
    cld
    call interrupt_handler
    popad
    iret

global irq177
align 4

irq177:
    pushad
    push 177
    cld
    call interrupt_handler
    popad
    iret

global irq178
align 4

irq178:
    pushad
    push 178
    cld
    call interrupt_handler
    popad
    iret

global irq179
align 4

irq179:
    pushad
    push 179
    cld
    call interrupt_handler
    popad
    iret

global irq180
align 4

irq180:
    pushad
    push 180
    cld
    call interrupt_handler
    popad
    iret

global irq181
align 4

irq181:
    pushad
    push 181
    cld
    call interrupt_handler
    popad
    iret

global irq182
align 4

irq182:
    pushad
    push 182
    cld
    call interrupt_handler
    popad
    iret

global irq183
align 4

irq183:
    pushad
    push 183
    cld
    call interrupt_handler
    popad
    iret

global irq184
align 4

irq184:
    pushad
    push 184
    cld
    call interrupt_handler
    popad
    iret

global irq185
align 4

irq185:
    pushad
    push 185
    cld
    call interrupt_handler
    popad
    iret

global irq186
align 4

irq186:
    pushad
    push 186
    cld
    call interrupt_handler
    popad
    iret

global irq187
align 4

irq187:
    pushad
    push 187
    cld
    call interrupt_handler
    popad
    iret

global irq188
align 4

irq188:
    pushad
    push 188
    cld
    call interrupt_handler
    popad
    iret

global irq189
align 4

irq189:
    pushad
    push 189
    cld
    call interrupt_handler
    popad
    iret

global irq190
align 4

irq190:
    pushad
    push 190
    cld
    call interrupt_handler
    popad
    iret

global irq191
align 4

irq191:
    pushad
    push 191
    cld
    call interrupt_handler
    popad
    iret

global irq192
align 4

irq192:
    pushad
    push 192
    cld
    call interrupt_handler
    popad
    iret

global irq193
align 4

irq193:
    pushad
    push 193
    cld
    call interrupt_handler
    popad
    iret

global irq194
align 4

irq194:
    pushad
    push 194
    cld
    call interrupt_handler
    popad
    iret

global irq195
align 4

irq195:
    pushad
    push 195
    cld
    call interrupt_handler
    popad
    iret

global irq196
align 4

irq196:
    pushad
    push 196
    cld
    call interrupt_handler
    popad
    iret

global irq197
align 4

irq197:
    pushad
    push 197
    cld
    call interrupt_handler
    popad
    iret

global irq198
align 4

irq198:
    pushad
    push 198
    cld
    call interrupt_handler
    popad
    iret

global irq199
align 4

irq199:
    pushad
    push 199
    cld
    call interrupt_handler
    popad
    iret

global irq200
align 4

irq200:
    pushad
    push 200
    cld
    call interrupt_handler
    popad
    iret

global irq201
align 4

irq201:
    pushad
    push 201
    cld
    call interrupt_handler
    popad
    iret

global irq202
align 4

irq202:
    pushad
    push 202
    cld
    call interrupt_handler
    popad
    iret

global irq203
align 4

irq203:
    pushad
    push 203
    cld
    call interrupt_handler
    popad
    iret

global irq204
align 4

irq204:
    pushad
    push 204
    cld
    call interrupt_handler
    popad
    iret

global irq205
align 4

irq205:
    pushad
    push 205
    cld
    call interrupt_handler
    popad
    iret

global irq206
align 4

irq206:
    pushad
    push 206
    cld
    call interrupt_handler
    popad
    iret

global irq207
align 4

irq207:
    pushad
    push 207
    cld
    call interrupt_handler
    popad
    iret

global irq208
align 4

irq208:
    pushad
    push 208
    cld
    call interrupt_handler
    popad
    iret

global irq209
align 4

irq209:
    pushad
    push 209
    cld
    call interrupt_handler
    popad
    iret

global irq210
align 4

irq210:
    pushad
    push 210
    cld
    call interrupt_handler
    popad
    iret

global irq211
align 4

irq211:
    pushad
    push 211
    cld
    call interrupt_handler
    popad
    iret

global irq212
align 4

irq212:
    pushad
    push 212
    cld
    call interrupt_handler
    popad
    iret

global irq213
align 4

irq213:
    pushad
    push 213
    cld
    call interrupt_handler
    popad
    iret

global irq214
align 4

irq214:
    pushad
    push 214
    cld
    call interrupt_handler
    popad
    iret

global irq215
align 4

irq215:
    pushad
    push 215
    cld
    call interrupt_handler
    popad
    iret

global irq216
align 4

irq216:
    pushad
    push 216
    cld
    call interrupt_handler
    popad
    iret

global irq217
align 4

irq217:
    pushad
    push 217
    cld
    call interrupt_handler
    popad
    iret

global irq218
align 4

irq218:
    pushad
    push 218
    cld
    call interrupt_handler
    popad
    iret

global irq219
align 4

irq219:
    pushad
    push 219
    cld
    call interrupt_handler
    popad
    iret

global irq220
align 4

irq220:
    pushad
    push 220
    cld
    call interrupt_handler
    popad
    iret

global irq221
align 4

irq221:
    pushad
    push 221
    cld
    call interrupt_handler
    popad
    iret

global irq222
align 4

irq222:
    pushad
    push 222
    cld
    call interrupt_handler
    popad
    iret

global irq223
align 4

irq223:
    pushad
    push 223
    cld
    call interrupt_handler
    popad
    iret

global irq224
align 4

irq224:
    pushad
    push 224
    cld
    call interrupt_handler
    popad
    iret

global irq225
align 4

irq225:
    pushad
    push 225
    cld
    call interrupt_handler
    popad
    iret

global irq226
align 4

irq226:
    pushad
    push 226
    cld
    call interrupt_handler
    popad
    iret

global irq227
align 4

irq227:
    pushad
    push 227
    cld
    call interrupt_handler
    popad
    iret

global irq228
align 4

irq228:
    pushad
    push 228
    cld
    call interrupt_handler
    popad
    iret

global irq229
align 4

irq229:
    pushad
    push 229
    cld
    call interrupt_handler
    popad
    iret

global irq230
align 4

irq230:
    pushad
    push 230
    cld
    call interrupt_handler
    popad
    iret

global irq231
align 4

irq231:
    pushad
    push 231
    cld
    call interrupt_handler
    popad
    iret

global irq232
align 4

irq232:
    pushad
    push 232
    cld
    call interrupt_handler
    popad
    iret

global irq233
align 4

irq233:
    pushad
    push 233
    cld
    call interrupt_handler
    popad
    iret

global irq234
align 4

irq234:
    pushad
    push 234
    cld
    call interrupt_handler
    popad
    iret

global irq235
align 4

irq235:
    pushad
    push 235
    cld
    call interrupt_handler
    popad
    iret

global irq236
align 4

irq236:
    pushad
    push 236
    cld
    call interrupt_handler
    popad
    iret

global irq237
align 4

irq237:
    pushad
    push 237
    cld
    call interrupt_handler
    popad
    iret

global irq238
align 4

irq238:
    pushad
    push 238
    cld
    call interrupt_handler
    popad
    iret

global irq239
align 4

irq239:
    pushad
    push 239
    cld
    call interrupt_handler
    popad
    iret

global irq240
align 4

irq240:
    pushad
    push 240
    cld
    call interrupt_handler
    popad
    iret

global irq241
align 4

irq241:
    pushad
    push 241
    cld
    call interrupt_handler
    popad
    iret

global irq242
align 4

irq242:
    pushad
    push 242
    cld
    call interrupt_handler
    popad
    iret

global irq243
align 4

irq243:
    pushad
    push 243
    cld
    call interrupt_handler
    popad
    iret

global irq244
align 4

irq244:
    pushad
    push 244
    cld
    call interrupt_handler
    popad
    iret

global irq245
align 4

irq245:
    pushad
    push 245
    cld
    call interrupt_handler
    popad
    iret

global irq246
align 4

irq246:
    pushad
    push 246
    cld
    call interrupt_handler
    popad
    iret

global irq247
align 4

irq247:
    pushad
    push 247
    cld
    call interrupt_handler
    popad
    iret

global irq248
align 4

irq248:
    pushad
    push 248
    cld
    call interrupt_handler
    popad
    iret

global irq249
align 4

irq249:
    pushad
    push 249
    cld
    call interrupt_handler
    popad
    iret

global irq250
align 4

irq250:
    pushad
    push 250
    cld
    call interrupt_handler
    popad
    iret

global irq251
align 4

irq251:
    pushad
    push 251
    cld
    call interrupt_handler
    popad
    iret

global irq252
align 4

irq252:
    pushad
    push 252
    cld
    call interrupt_handler
    popad
    iret

global irq253
align 4

irq253:
    pushad
    push 253
    cld
    call interrupt_handler
    popad
    iret

global irq254
align 4

irq254:
    pushad
    push 254
    cld
    call interrupt_handler
    popad
    iret

global irq255
align 4

irq255:
    pushad
    push 255
    cld
    call interrupt_handler
    popad
    iret