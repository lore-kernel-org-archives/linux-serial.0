From: Eric Valette <eric.valette@free.fr>
Subject: Re: ST16C554 Serial device driver
Date: Tue, 21 Sep 2004 15:13:19 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <415028EF.7000703@free.fr>
References: <41500508.9010004@free.fr> <20040921130957.B16836@flint.arm.linux.org.uk> <4150200F.7020407@free.fr> <20040921135414.C16836@flint.arm.linux.org.uk>
Reply-To: eric.valette@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [217.167.0.1] ([217.167.0.1]:19088 "EHLO mail.basystemes.fr")
	by vger.kernel.org with ESMTP id S267666AbUIUNNT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Sep 2004 09:13:19 -0400
In-Reply-To: <20040921135414.C16836@flint.arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

Russell King wrote:
> On Tue, Sep 21, 2004 at 02:35:27PM +0200, Eric Valette wrote:
> 
>>Russell King wrote:
>>
>>>What is the result of an autodetect at the correct address?  What are
>>>the commands you're issuing to tell the kernel where this port is?
>>>Do you get any kernel messages, and what are they?
>>
>>What is more suspect is the 0x287 (0x2a7) and register address that is 
>>described in the manufacturer documentation of the PC104 board that says 
>>: "When the same IRQ is shared by the 4 ports, the card uses 2 registers 
>>at 287H, one to valid the interrupts and the other to read back the 4 
>>interrupt status". The attached pictures gives the signification of the 
>>register.
> 
> 
> Ok the above shouldn't be a problem.
> 
> 
>>regarding configuration I basically said :
>>	setserial /dev/ttyS2 port 0x280 irq 10 autoconfig
>>
>>(same with the four ports) and
>>
>>	setserial /dev/ttyS6 port 0x2a0 irq 11 autoconfig
>>
>>(same with the four ports)
> 
> 
> Can you run:
> 
> 	setserial -bav /dev/ttyS2
> 
> so we can see what the kernel has done?

setserial -bav /dev/ttyS2
/dev/ttyS2, Line 2, UART: 16550A, Port: 0x0280, IRQ: 10
         Baud_base: 115200, close_delay: 50000, divisor: 0
         closing_wait: 50880
         Flags: spd_normal


So it seems to correctly have detected the uart.

> Do you get any kernel messages, either when you ask it to do the
> autoconfig or when you try to use the port(s)?

 >
 > In addition, looking at /proc/tty/driver/serial and /proc/interrupts
 > may provide some extra information, especially the before and after
 > sending characters.
 >

A) at autoconfig time :

1) dmesg contains nothing related to tty execpt the two legacy serial 
line ttyS0 and ttyS1.

2) cat /proc/interrupts
            CPU0
   0:     360857          XT-PIC  timer
   1:          8          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:        693          XT-PIC  eth0
  12:         58          XT-PIC  i8042
  13:          0          XT-PIC  fpu
  14:      17935          XT-PIC  ide0
NMI:          0
ERR:          0

3) cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16450 port:000003F8 irq:4 tx:0 rx:0
1: uart:16450 port:000002F8 irq:3 tx:0 rx:0
2: uart:16550A port:00000280 irq:10 tx:0 rx:0 CD
3: uart:unknown port:000002E8 irq:3
4: uart:unknown port:000001A0 irq:9
5: uart:unknown port:000001A8 irq:9
6: uart:unknown port:000002A0 irq:11
7: uart:unknown port:000001B8 irq:9
8: uart:unknown port:000002A0 irq:5
9: uart:unknown port:000002A8 irq:5
10: uart:unknown port:000002B0 irq:5
11: uart:unknown port:000002B8 irq:5
12: uart:unknown port:00000330 irq:4
13: uart:unknown port:00000338 irq:4
14: uart:unknown port:00000000 irq:0
15: uart:unknown port:00000000 irq:0
16: uart:unknown port:00000100 irq:12
17: uart:unknown port:00000108 irq:12
18: uart:unknown port:00000110 irq:12
19: uart:unknown port:00000118 irq:12
20: uart:unknown port:00000120 irq:12
21: uart:unknown port:00000128 irq:12
22: uart:unknown port:00000130 irq:12
23: uart:unknown port:00000138 irq:12
24: uart:unknown port:00000140 irq:12
25: uart:unknown port:00000148 irq:12
26: uart:unknown port:00000150 irq:12
27: uart:unknown port:00000158 irq:12
28: uart:unknown port:00000160 irq:12
29: uart:unknown port:00000168 irq:12
30: uart:unknown port:00000170 irq:12
31: uart:unknown port:00000178 irq:12
32: uart:unknown port:00000302 irq:3
33: uart:unknown port:00000302 irq:3
34: uart:unknown port:00000302 irq:3
35: uart:unknown port:00000302 irq:3
36: uart:unknown port:00000302 irq:3
37: uart:unknown port:00000302 irq:3
38: uart:unknown port:00000302 irq:3
39: uart:unknown port:00000302 irq:3
40: uart:unknown port:00000302 irq:3
41: uart:unknown port:00000302 irq:3
42: uart:unknown port:00000302 irq:3
43: uart:unknown port:00000302 irq:3
44: uart:unknown port:00000000 irq:0
45: uart:unknown port:00000000 irq:0
46: uart:unknown port:00000000 irq:0
47: uart:unknown port:00000000 irq:0
48: uart:unknown port:00000000 irq:0
49: uart:unknown port:00000000 irq:0
50: uart:unknown port:00000000 irq:0
51: uart:unknown port:00000000 irq:0
ciblePortage:/home/valette#


then I do cat /etc/passwd > /dev/ttyS2 (I have a serial line analyser 
connected) that gets the caracter if I use ttyS0 instead of S2, the 
sesion hangs when trying to flush the buffer as if there were no 
transmit interrupt...

strace cat /etc/passwd > /dev/ttyS2
execve("/bin/cat", ["cat", "/etc/passwd"], [/* 14 vars */]) = 0
uname({sys="Linux", node="ciblePortage", ...}) = 0
brk(0)                                  = 0x804d000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0xb7fe9 000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8278, ...}) = 0
old_mmap(NULL, 8278, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fe6000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340X\1"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1279076, ...}) = 0
old_mmap(NULL, 1289388, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7eab000
old_mmap(0xb7fdb000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 
3, 0x12f000) = 0xb7fdb000
old_mmap(0xb7fe4000, 7340, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fe4000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0xb7eaa 000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7eaa080, 
limit:1048575, seg_32bit: 1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7fe6000, 8278)                = 0
brk(0)                                  = 0x804d000
brk(0x806e000)                          = 0x806e000
brk(0)                                  = 0x806e000
fstat64(1, {st_mode=S_IFCHR|0660, st_rdev=makedev(4, 66), ...}) = 0
open("/etc/passwd", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=866, ...}) = 0
read(3, "root:x:0:0:root:/root:/bin/bash\n"..., 4096) = 866
write(1, "root:x:0:0:root:/root:/bin/bash\n"..., 866) = 866
read(3, "", 4096)                       = 0
close(3)                                = 0
close(1)                                = 0
exit_group(0)   <=== hung here

cat /proc/interrupts

            CPU0
   0:     802459          XT-PIC  timer
   1:          8          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:       1647          XT-PIC  eth0
  10:          0          XT-PIC  serial  <===============
  12:         58          XT-PIC  i8042
  13:          0          XT-PIC  fpu
  14:      18323          XT-PIC  ide0
NMI:          0
ERR:          0

cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16450 port:000003F8 irq:4 tx:0 rx:0
1: uart:16450 port:000002F8 irq:3 tx:0 rx:0
2: uart:16550A port:00000280 irq:10 tx:0 rx:0 RTS|DTR|CD
3: uart:unknown port:000002E8 irq:3
4: uart:unknown port:000001A0 irq:9
5: uart:unknown port:000001A8 irq:9
6: uart:unknown port:000002A0 irq:11
7: uart:unknown port:000001B8 irq:9
8: uart:unknown port:000002A0 irq:5
9: uart:unknown port:000002A8 irq:5
10: uart:unknown port:000002B0 irq:5
11: uart:unknown port:000002B8 irq:5
12: uart:unknown port:00000330 irq:4
13: uart:unknown port:00000338 irq:4
14: uart:unknown port:00000000 irq:0
15: uart:unknown port:00000000 irq:0
16: uart:unknown port:00000100 irq:12
17: uart:unknown port:00000108 irq:12
18: uart:unknown port:00000110 irq:12
19: uart:unknown port:00000118 irq:12
20: uart:unknown port:00000120 irq:12
21: uart:unknown port:00000128 irq:12
22: uart:unknown port:00000130 irq:12
23: uart:unknown port:00000138 irq:12
24: uart:unknown port:00000140 irq:12
25: uart:unknown port:00000148 irq:12
26: uart:unknown port:00000150 irq:12
27: uart:unknown port:00000158 irq:12
28: uart:unknown port:00000160 irq:12
29: uart:unknown port:00000168 irq:12
30: uart:unknown port:00000170 irq:12
31: uart:unknown port:00000178 irq:12
32: uart:unknown port:00000302 irq:3
33: uart:unknown port:00000302 irq:3
34: uart:unknown port:00000302 irq:3
35: uart:unknown port:00000302 irq:3
36: uart:unknown port:00000302 irq:3
37: uart:unknown port:00000302 irq:3
38: uart:unknown port:00000302 irq:3
39: uart:unknown port:00000302 irq:3
40: uart:unknown port:00000302 irq:3
41: uart:unknown port:00000302 irq:3
42: uart:unknown port:00000302 irq:3
43: uart:unknown port:00000302 irq:3
44: uart:unknown port:00000000 irq:0
45: uart:unknown port:00000000 irq:0
46: uart:unknown port:00000000 irq:0
47: uart:unknown port:00000000 irq:0
48: uart:unknown port:00000000 irq:0
49: uart:unknown port:00000000 irq:0
50: uart:unknown port:00000000 irq:0
51: uart:unknown port:00000000 irq:0

Do not hesitate to ask more, I can recompile a kernel also if you want...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr
