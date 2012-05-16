From: helpmelearn <joeshmoeypeter@yahoo.com>
Subject: Excessive logging causing rcu_sched_state stall (wait_for_xmitr
 8250.c)
Date: Tue, 15 May 2012 17:02:36 -0700 (PDT)
Message-ID: <33854911.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sam.nabble.com ([216.139.236.26]:54729 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966148Ab2EPACg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 20:02:36 -0400
Received: from telerig.nabble.com ([192.168.236.162])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <lists@nabble.com>)
	id 1SURhM-000792-0m
	for linux-serial@vger.kernel.org; Tue, 15 May 2012 17:02:36 -0700
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hi,
It's been more than a week since I am stuck with this. I am relatively a
newbie venturing into linux
kernel, so please be gentle.

I have a non-tained 2.6.35.14 kernel that needs to output a lot using the
serial console. To reproduce I 
simply run klogd -2 -c 7 and this causes rcu_sched_state to detect stall
with a trace such as pasted 
below. 

Please note that I had enabled CONFIG_PROVE_RCU, CONFIG_RCU_TRACE and
related flags as well as 
bumped RCU_STALL_RAT_DELAY to 20 while debugging. This makes RCU wait 15020
jiffies until it 
complains. Otherwise, it complains in 10002 jiffies (with default config).

The trace points to the wait_for_xmitr() loop in 8250.c (from another run):

(gdb) list *(wait_for_xmitr+0x56)
0x5ae is in wait_for_xmitr (drivers/serial/8250.c:1863).
1858    {
1859            unsigned int status, tmout = 10000;
1860
1861            /* Wait up to 10ms for the character(s) to be sent. */
1862            do {
1863                    status = serial_in(up, UART_LSR);
1864
1865                    up->lsr_saved_flags |= status & LSR_SAVE_FLAGS;
1866
1867                    if (--tmout == 0)
(gdb)

AFAICT, this piece of code is run with interrupts disabled. So is the issue
here simply that too much 
output is causing wait_for_xmitr() loop to run for longer than
rcu_sched_state() is happy with?

In rcu/stallwarn.txt, Paul notes that rcu_sched_state() will get unhappy
should the CPU loop with 
interrupts disabled.

IF this is indeed the case, what would be a potential fix for this? Any
help/guidance much appreciated. 
Thank you!

[  346.664471] INFO: rcu_sched_state detected stalls on CPUs/tasks: { 5}
(detected by 0, t=15020 jiffies)
[  346.664477] sending NMI to all CPUs:
[  346.666532] NMI backtrace for cpu 5
[  346.666534] CPU 5
[  346.666535] Modules linked in: ipmi_devintf ipmi_si ipmi_msghandler
iscsi_scst crc32c_intel iptable_filter xt_NOTRACK iptable_nat nf_nat
nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 iptable_raw ip_tables x_tables
bonding qla2x00tgt qla2xxx scsi_transport_fc scst_vdisk scst vtms softdog
coretemp hwmon dm_mod video backlight output serio_raw rtc_cmos rtc_core
rtc_lib button ixgbe i2c_i801 i2c_core uhci_hcd pcspkr
[  346.666559]
[  346.666562] Pid: 0, comm: swapper Not tainted 2.6.35-14EIsmp
X8DTH/X8DTH-i/6/iF/6F
[  346.666565] RIP: 0010:[<ffffffff812939b4>]  [<ffffffff812939b4>]
io_serial_in+0x10/0x15
[  346.666571] RSP: 0018:ffff880144223a70  EFLAGS: 00000002
[  346.666574] RAX: 0000000000000900 RBX: ffffffff82a5c8c0 RCX:
0000000000000000
[  346.666576] RDX: 00000000000003fd RSI: 0000000000000005 RDI:
ffffffff82a5c8c0
[  346.666579] RBP: ffff880144223a70 R08: 0000000098a41ff0 R09:
ffffffff81293831
[  346.666581] R10: ffffffff81d4db2b R11: 0000000000000000 R12:
0000000000000000
[  346.666583] R13: 00000000000025af R14: 0000000000000020 R15:
000000000000003e
[  346.666586] FS:  0000000000000000(0000) GS:ffff880144220000(0000)
knlGS:0000000000000000
[  346.666589] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  346.666591] CR2: 00007fff5f13d464 CR3: 0000000074531000 CR4:
00000000000006e0
[  346.666594] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  346.666596] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400
[  346.666599] Process swapper (pid: 0, threadinfo ffff88013fb44000, task
ffff88023fb1e000)
[  346.666600] Stack:
[  346.666602]  ffff880144223aa0 ffffffff81291b6d ffffffff82a5c8c0
000000000000000a
[  346.666605] <0> ffffffff81291bd6 ffffffff82a5c8c0 ffff880144223ac0
ffffffff81291bf5
[  346.666608] <0> ffffffff81d4dc59 000000000000003e ffff880144223b00
ffffffff8128e79b
[  346.666612] Call Trace:
[  346.666614]  <IRQ>
[  346.666617]  [<ffffffff81291b6d>] wait_for_xmitr+0x38/0xa1
[  346.666621]  [<ffffffff81291bd6>] ? serial8250_console_putchar+0x0/0x34
[  346.666624]  [<ffffffff81291bf5>] serial8250_console_putchar+0x1f/0x34
[  346.666627]  [<ffffffff8128e79b>] uart_console_write+0x41/0x52
[  346.666631]  [<ffffffff8129388c>] serial8250_console_write+0xb2/0x116
[  346.666635]  [<ffffffff8103e4dd>] __call_console_drivers+0x67/0x79
[  346.666638]  [<ffffffff8103e54a>] _call_console_drivers+0x5b/0x5f
[  346.666641]  [<ffffffff8103e937>] release_console_sem+0x12a/0x1c5
[  346.666644]  [<ffffffff8103efaf>] vprintk+0x373/0x3a3
[  346.666648]  [<ffffffff8103f046>] ? printk+0x67/0x69
[  346.666651]  [<ffffffff8103f046>] printk+0x67/0x69
[  346.666655]  [<ffffffff81214645>] ? __delay+0xa/0xc
[  346.666659]  [<ffffffff8105b3ef>] ? up+0xf/0x39
[  346.666663]  [<ffffffff8106597e>] ? trace_hardirqs_on+0xd/0xf
[  346.666692]  [<ffffffffa011b2d2>] ? debug_print_prefix+0x135/0x146 [scst]
[  346.666706]  [<ffffffffa00f6ad3>] scst_process_redirect_cmd+0x97/0x323
[scst]
[  346.666720]  [<ffffffffa00f8807>] scst_cmd_done_local+0x227/0x280 [scst]
[  346.666726]  [<ffffffffa0186d61>] blockio_endio+0xcf/0xee [scst_vdisk]
[  346.666733]  [<ffffffffa0085324>] ? end_io_acct+0x0/0x147 [dm_mod]
[  346.666736]  [<ffffffff811026a7>] bio_endio+0x26/0x28
[  346.666742]  [<ffffffffa00855c5>] dec_pending+0x15a/0x163 [dm_mod]
[  346.666748]  [<ffffffffa008576a>] clone_endio+0xa1/0xae [dm_mod]
[  346.666752]  [<ffffffff811026a7>] bio_endio+0x26/0x28
[  346.666759]  [<ffffffffa00bff51>] vtms_softirq_done+0xeb/0x107 [vtms]
[  346.666764]  [<ffffffff8120127f>] blk_done_softirq+0x6d/0x7e
[  346.666767]  [<ffffffff810439fc>] __do_softirq+0xe9/0x1c7
[  346.666771]  [<ffffffff8100384c>] call_softirq+0x1c/0x34
[  346.666774]  [<ffffffff81004e15>] do_softirq+0x38/0x83
[  346.666777]  [<ffffffff81043911>] irq_exit+0x45/0x47
[  346.666780]  [<ffffffff81017c43>]
smp_call_function_single_interrupt+0x2f/0x31
[  346.666784]  [<ffffffff810034b3>]
call_function_single_interrupt+0x13/0x20
[  346.666786]  <EOI>

-- 
View this message in context: http://old.nabble.com/Excessive-logging-causing-rcu_sched_state-stall-%28wait_for_xmitr-8250.c%29-tp33854911p33854911.html
Sent from the linux-serial mailing list archive at Nabble.com.

