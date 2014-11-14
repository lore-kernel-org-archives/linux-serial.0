From: Craig McQueen <craig.mcqueen@beamcommunications.com>
Subject: i.MX28 AUART driver can break when switching to hardware flow control
Date: Fri, 14 Nov 2014 12:23:28 +1100
Message-ID: <54655990.6000104@beamcommunications.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-hk1on0078.outbound.protection.outlook.com ([134.170.140.78]:37959
	"EHLO APAC01-HK1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934544AbaKNBje (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Nov 2014 20:39:34 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I've been testing a 3.14.19 kernel on i.MX28 EVK, and subsequently 
confirmed this with 3.18-rc4.

I've found that the AUART driver seems to work okay with no flow 
control, but when hardware flow control is turned on, it causes repeated 
and/or missing characters on RX. E.g. when connected to a modem from 
picocom:

     picocom v1.6

     port is        : /dev/ttyAPP0
     flowcontrol    : none
     baudrate is    : 9600
     parity is      : none
     databits are   : 8
     escape is      : C-a
     local echo is  : no
     noinit is      : no
     noreset is     : no
     nolock is      : no
     send_cmd is    : sz -vv
     receive_cmd is : rz -vv
     imap is        :
     omap is        :
     emap is        : crcrlf,delbs,

     Terminal ready
     at
     OK
     at
     OK

     *** flow: RTS/CTS ***

     OK
     OK
     OK
     OK
     OK
     OK
     OK
     OK

     OK
     OK
     OK
     ...

I had pressed Ctrl-A, Ctrl-F in picocom to turn on hardware flow 
control. Then I typed at[LF] again, and got forever-scrolling OK, with a 
sample shown above.


Then I tried quitting and restarting picocom (with -f h option in this 
case to select HW flow control), and got a kernel crash:


     picocom v1.6

     port is        : /dev/ttyAPP0
     flowcontrol    : RTS/CTS
     baudrate is    : 9600
     parity i[  720.546303] Unable to handle kernel paging request at 
virtual address c9065e00
     [  720.555590] pgd = c6a9c000
     [  720.558318] [c9065e00] *pgd=00000000
     [  720.561939] Internal error: Oops: 5 [#1] ARM
     [  720.566235] Modules linked in:
     [  720.569336] CPU: 0 PID: 307 Comm: picocom Tainted: G W      
3.18.0-rc4-00204-g206c5f6 #3
     [  720.578066] task: c685a500 ti: c745c000 task.ti: c745c000
     [  720.583515] PC is at kmem_cache_free+0x34/0x1a8
     [  720.588082] LR is at final_putname+0x34/0x44
     [  720.592377] pc : [<c00d3f90>]    lr : [<c00e73c8>]    psr: a0000013
     [  720.592377] sp : c745df48  ip : c685a500  fp : 00000000
     [  720.603876] r10: 00000000  r9 : 00000020  r8 : c6e6c2c8
     [  720.609119] r7 : 00000003  r6 : c00e73c8  r5 : 4b4f0a0d  r4 : 
c7401a80
     [  720.615663] r3 : c7efc000  r2 : 0008b4f0  r1 : 4b4f0a0d  r0 : 
c7401a80
     [  720.622209] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment user
     [  720.629363] Control: 0005317f  Table: 46a9c000  DAC: 00000015
     [  720.635130] Process picocom (pid: 307, stack limit = 0xc745c1c0)
     [  720.641157] Stack: (0xc745df48 to 0xc745e000)
     [  720.645551] df40:                   c6955000 c6955000 c7599488 
00000003 c6e6c2c8 c00e73c8
     [  720.653765] df60: c7599480 c00d8ebc 00000000 00000000 c00096ac 
00000802 c0000000 00000026
     [  720.661977] df80: 00000100 00000001 00009240 0001572c 0001572c 
00009240 00000005 c00097e4
     [  720.670186] dfa0: c745c000 c0009620 0001572c 0001572c 00015774 
00000802 00000005 00000000
     [  720.678397] dfc0: 0001572c 0001572c 00009240 00000005 00000000 
00000000 496e7000 00000000
     [  720.686609] dfe0: 00000000 bef63cb4 00008fd4 497bb66c 60000010 
00015774 aaaaaaaa aaaaaaaa
     [  720.694841] [<c00d3f90>] (kmem_cache_free) from [<c00e73c8>] 
(final_putname+0x34/0x44)
     [  720.702808] [<c00e73c8>] (final_putname) from [<c00d8ebc>] 
(do_sys_open+0x168/0x1cc)
     [  720.710601] [<c00d8ebc>] (do_sys_open) from [<c0009620>] 
(ret_fast_syscall+0x0/0x44)
     [  720.718384] Code: e59f3174 e2852101 e5933000 e1a02622 (e7931282)
     [  720.743734] ---[ end trace 3d747b1a70c92711 ]---
     s      : none
     databits are   : [  720.749660] UDP: bad checksum. From 
192.168.1.3:17500 to 192.168.1.255:17500 ulen 133
     8
     escape is      : C-a
     local echo is  : no
     noinit is      : no
     noreset is     : no
     nolock is      : no
     send_cmd is    : sz -vv
     receive_cmd is : rz -vv
     imap is        :
     omap is        :
     emap is        : crcrlf,delbs,

     Segmentation fault


This bug doesn't seem to occur if the serial port is switched to 
hardware flow control before any bytes are received, and then kept in 
that mode continuously. That means early in boot-up:

     stty -F /dev/ttyAPP0 crtscts

Then whenever starting picocom:

     picocom -f h /dev/ttyAPP0

When picocom exits, it will restore the previous port state, so it stays 
in hardware flow control mode.

In this scenario, the serial port seems to function normally without the 
bug in received bytes and without any kernel crash.

So I am guessing that the bug occurs when switching the flow control 
mode from 'none' to 'hardware', after some bytes have been received, and 
causes some sort of receive buffer misalignment.

-- 
Craig McQueen

