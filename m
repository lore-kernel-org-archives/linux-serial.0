From: joe shmoe <joeshmoeypeter@yahoo.com>
Subject: Excessive logging causing rcu_sched_state stall (wait_for_xmitr 8250.c)
Date: Tue, 15 May 2012 17:41:28 -0700 (PDT)
Message-ID: <1337128888.46194.YahooMailNeo@web160804.mail.bf1.yahoo.com>
Reply-To: joe shmoe <joeshmoeypeter@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm13.bullet.mail.bf1.yahoo.com ([98.139.212.172]:20885 "HELO
	nm13.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757825Ab2EPAsW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 20:48:22 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,=20
It's been more than a week since I am stuck with this. I am relatively =
a newbie venturing into linux=20
kernel, so please be gentle.=20

I have a non-tained 2.6.35.14 kernel that needs to output a lot using t=
he serial console. To reproduce I=20
simply run klogd -2 -c 7 and this causes rcu_sched_state to detect stal=
l with a trace such as pasted=20
below.=20


Please note that I had enabled CONFIG_PROVE_RCU, CONFIG_RCU_TRACE and r=
elated flags as well as=20
bumped RCU_STALL_RAT_DELAY to 20 while debugging. This makes RCU wait 1=
5020 jiffies until it=20
complains. Otherwise, it complains in 10002 jiffies (with default confi=
g).=20

The trace points to the wait_for_xmitr() loop in 8250.c (from another r=
un):=20

(gdb) list *(wait_for_xmitr+0x56)=20
0x5ae is in wait_for_xmitr (drivers/serial/8250.c:1863).=20
1858 =A0 =A0{=20
1859 =A0 =A0 =A0 =A0 =A0 =A0unsigned int status, tmout =3D 10000;=20
1860=20
1861 =A0 =A0 =A0 =A0 =A0 =A0/* Wait up to 10ms for the character(s) to =
be sent. */=20
1862 =A0 =A0 =A0 =A0 =A0 =A0do {=20
1863 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D serial_in(up, UA=
RT_LSR);=20
1864=20
1865 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->lsr_saved_flags |=3D st=
atus & LSR_SAVE_FLAGS;=20
1866=20
1867 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (--tmout =3D=3D 0)=20
(gdb)=20

AFAICT, this piece of code is run with interrupts disabled. So is the i=
ssue here simply that too much=20
output is causing wait_for_xmitr() loop to run for longer than rcu_sche=
d_state() is happy with?=20

In rcu/stallwarn.txt, Paul notes that rcu_sched_state() will get unhapp=
y should the CPU loop with=20
interrupts disabled.=20

IF this is indeed the case, what would be a potential fix for this? Any=
 help/guidance much appreciated.=20
Thank you!=20

[ =A0346.664471] INFO: rcu_sched_state detected stalls on CPUs/tasks: {=
 5} (detected by 0, t=3D15020 jiffies)=20
[ =A0346.664477] sending NMI to all CPUs:=20
[ =A0346.666532] NMI backtrace for cpu 5=20
[ =A0346.666534] CPU 5=20
[ =A0346.666535] Modules linked in: ipmi_devintf ipmi_si=20
ipmi_msghandler iscsi_scst crc32c_intel iptable_filter xt_NOTRACK=20
iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4=20
iptable_raw ip_tables x_tables bonding qla2x00tgt qla2xxx=20
scsi_transport_fc scst_vdisk scst vtms softdog coretemp hwmon dm_mod=20
video backlight output serio_raw rtc_cmos rtc_core rtc_lib button ixgbe=
=20
i2c_i801 i2c_core uhci_hcd pcspkr=20
[ =A0346.666559]=20
[ =A0346.666562] Pid: 0, comm: swapper Not tainted 2.6.35-14EIsmp X8DTH=
/X8DTH-i/6/iF/6F=20
[ =A0346.666565] RIP: 0010:[<ffffffff812939b4>] =A0[<ffffffff812939b4>]=
 io_serial_in+0x10/0x15=20
[ =A0346.666571] RSP: 0018:ffff880144223a70 =A0EFLAGS: 00000002=20
[ =A0346.666574] RAX: 0000000000000900 RBX: ffffffff82a5c8c0 RCX: 00000=
00000000000=20
[ =A0346.666576] RDX: 00000000000003fd RSI: 0000000000000005 RDI: fffff=
fff82a5c8c0=20
[ =A0346.666579] RBP: ffff880144223a70 R08: 0000000098a41ff0 R09: fffff=
fff81293831=20
[ =A0346.666581] R10: ffffffff81d4db2b R11: 0000000000000000 R12: 00000=
00000000000=20
[ =A0346.666583] R13: 00000000000025af R14: 0000000000000020 R15: 00000=
0000000003e=20
[ =A0346.666586] FS: =A00000000000000000(0000) GS:ffff880144220000(0000=
) knlGS:0000000000000000=20
[ =A0346.666589] CS: =A00010 DS: 0000 ES: 0000 CR0: 000000008005003b=20
[ =A0346.666591] CR2: 00007fff5f13d464 CR3: 0000000074531000 CR4: 00000=
000000006e0=20
[ =A0346.666594] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000=20
[ =A0346.666596] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400=20
[ =A0346.666599] Process swapper (pid: 0, threadinfo ffff88013fb44000, =
task ffff88023fb1e000)=20
[ =A0346.666600] Stack:=20
[ =A0346.666602] =A0ffff880144223aa0 ffffffff81291b6d ffffffff82a5c8c0 =
000000000000000a=20
[ =A0346.666605] <0> ffffffff81291bd6 ffffffff82a5c8c0 ffff880144223ac0=
 ffffffff81291bf5=20
[ =A0346.666608] <0> ffffffff81d4dc59 000000000000003e ffff880144223b00=
 ffffffff8128e79b=20
[ =A0346.666612] Call Trace:=20
[ =A0346.666614] =A0<IRQ>=20
[ =A0346.666617] =A0[<ffffffff81291b6d>] wait_for_xmitr+0x38/0xa1=20
[ =A0346.666621] =A0[<ffffffff81291bd6>] ? serial8250_console_putchar+0=
x0/0x34=20
[ =A0346.666624] =A0[<ffffffff81291bf5>] serial8250_console_putchar+0x1=
f/0x34=20
[ =A0346.666627] =A0[<ffffffff8128e79b>] uart_console_write+0x41/0x52=20
[ =A0346.666631] =A0[<ffffffff8129388c>] serial8250_console_write+0xb2/=
0x116=20
[ =A0346.666635] =A0[<ffffffff8103e4dd>] __call_console_drivers+0x67/0x=
79=20
[ =A0346.666638] =A0[<ffffffff8103e54a>] _call_console_drivers+0x5b/0x5=
f=20
[ =A0346.666641] =A0[<ffffffff8103e937>] release_console_sem+0x12a/0x1c=
5=20
[ =A0346.666644] =A0[<ffffffff8103efaf>] vprintk+0x373/0x3a3=20
[ =A0346.666648] =A0[<ffffffff8103f046>] ? printk+0x67/0x69=20
[ =A0346.666651] =A0[<ffffffff8103f046>] printk+0x67/0x69=20
[ =A0346.666655] =A0[<ffffffff81214645>] ? __delay+0xa/0xc=20
[ =A0346.666659] =A0[<ffffffff8105b3ef>] ? up+0xf/0x39=20
[ =A0346.666663] =A0[<ffffffff8106597e>] ? trace_hardirqs_on+0xd/0xf=20
[ =A0346.666692] =A0[<ffffffffa011b2d2>] ? debug_print_prefix+0x135/0x1=
46 [scst]=20
[ =A0346.666706] =A0[<ffffffffa00f6ad3>] scst_process_redirect_cmd+0x97=
/0x323 [scst]=20
[ =A0346.666720] =A0[<ffffffffa00f8807>] scst_cmd_done_local+0x227/0x28=
0 [scst]=20
[ =A0346.666726] =A0[<ffffffffa0186d61>] blockio_endio+0xcf/0xee [scst_=
vdisk]=20
[ =A0346.666733] =A0[<ffffffffa0085324>] ? end_io_acct+0x0/0x147 [dm_mo=
d]=20
[ =A0346.666736] =A0[<ffffffff811026a7>] bio_endio+0x26/0x28=20
[ =A0346.666742] =A0[<ffffffffa00855c5>] dec_pending+0x15a/0x163 [dm_mo=
d]=20
[ =A0346.666748] =A0[<ffffffffa008576a>] clone_endio+0xa1/0xae [dm_mod]=
=20
[ =A0346.666752] =A0[<ffffffff811026a7>] bio_endio+0x26/0x28=20
[ =A0346.666759] =A0[<ffffffffa00bff51>] vtms_softirq_done+0xeb/0x107 [=
vtms]=20
[ =A0346.666764] =A0[<ffffffff8120127f>] blk_done_softirq+0x6d/0x7e=20
[ =A0346.666767] =A0[<ffffffff810439fc>] __do_softirq+0xe9/0x1c7=20
[ =A0346.666771] =A0[<ffffffff8100384c>] call_softirq+0x1c/0x34=20
[ =A0346.666774] =A0[<ffffffff81004e15>] do_softirq+0x38/0x83=20
[ =A0346.666777] =A0[<ffffffff81043911>] irq_exit+0x45/0x47=20
[ =A0346.666780] =A0[<ffffffff81017c43>] smp_call_function_single_inter=
rupt+0x2f/0x31=20
[ =A0346.666784] =A0[<ffffffff810034b3>] call_function_single_interrupt=
+0x13/0x20=20
[ =A0346.666786] =A0<EOI>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
