From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: INFO: rcu detected stall in n_tty_ioctl
Date: Wed, 14 Feb 2018 15:56:58 +0100
Message-ID: <CACT4Y+YMM8Fgj00jbyaTVhef1sWWucUPuZ+fhp0vUsTvVn+i2g@mail.gmail.com>
References: <001a113f542a3da6f10560c84350@google.com> <1513870539.7000.255.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513870539.7000.255.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: syzbot <bot+7886da36f7625ad405cd28fb3c9682f60b179cd6@syzkaller.appspotmail.com>, Alexey.Brodkin@synopsys.com, david@lechnology.com, eric@anholt.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jan.kiszka@siemens.com, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, phil@raspberrypi.org, rafael.gago@gmail.com, sean.wang@mediatek.com, syzkaller-bugs@googlegroups.com, tomas.melin@vaisala.com
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 21, 2017 at 4:35 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2017-12-20 at 08:42 -0800, syzbot wrote:
>> Hello,
>>
>> syzkaller hit the following crash on
>> 82bcf1def3b5f1251177ad47c44f7e17af039b4b
>> git://git.cmpxchg.org/linux-mmots.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>>
>> Unfortunately, I don't have any reproducer for this bug yet.
>>
>>
>> device gre0 entered promiscuous mode
>> INFO: rcu_sched self-detected stall on CPU
>> INFO: rcu_sched detected stalls on CPUs/tasks:
>>       0-....: (125000 ticks this GP) idle=40e/1/4611686018427387906
>> softirq=15450/15450 fqs=31230
>>       (detected by 1, t=125002 jiffies, g=8122, c=8121, q=540)
>> Sending NMI from CPU 1 to CPUs 0:
>> NMI backtrace for cpu 0
>> CPU: 0 PID: 5998 Comm: syz-executor3 Not tainted 4.15.0-rc2-mm1+ #39
>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>> BIOS
>> Google 01/01/2011
>> RIP: 0010:inb arch/x86/include/asm/io.h:348 [inline]
>> RIP: 0010:io_serial_in+0x6b/0x90
>> drivers/tty/serial/8250/8250_port.c:434
>> RSP: 0018:ffff8801db206ff8 EFLAGS: 00000002
>> RAX: dffffc0000000000 RBX: 00000000000003fd RCX: 0000000000000000
>> RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffff880f6980
>> RBP: ffff8801db207008 R08: ffff8801db206b88 R09: ffff8801c00c4540
>> R10: 000000000000000b R11: ffffed003b640d73 R12: ffffffff880f6940
>> R13: 0000000000000020 R14: fffffbfff101ed6f R15: fffffbfff101ed32
>> FS:  00007efcfdd21700(0000) GS:ffff8801db200000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f180504d000 CR3: 00000001ac67d002 CR4: 00000000001606f0
>> DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
>> Call Trace:
>>   <IRQ>
>>   serial_in drivers/tty/serial/8250/8250.h:111 [inline]
>>   wait_for_xmitr+0x93/0x1e0 drivers/tty/serial/8250/8250_port.c:2033
>
> Here we are testing LSR register for a THRE bit to be set and it seems
> by some reason we end up in a back trace in IO.
>
> KVM side effect of some change there?

I think this is fixed with:

#syz fix: n_tty: fix EXTPROC vs ICANON interaction with TIOCINQ (aka FIONREAD)


>>   serial8250_console_putchar+0x1f/0x60
>> drivers/tty/serial/8250/8250_port.c:3170
>>   uart_console_write+0xac/0xe0 drivers/tty/serial/serial_core.c:1858
>>   serial8250_console_write+0x647/0xa20
>> drivers/tty/serial/8250/8250_port.c:3236
>>   univ8250_console_write+0x5f/0x70
>> drivers/tty/serial/8250/8250_core.c:590
>>   call_console_drivers kernel/printk/printk.c:1574 [inline]
>>   console_unlock+0x788/0xd70 kernel/printk/printk.c:2233
>>   vprintk_emit+0x4ad/0x590 kernel/printk/printk.c:1757
>>   vprintk_default+0x28/0x30 kernel/printk/printk.c:1796
>>   vprintk_func+0x57/0xc0 kernel/printk/printk_safe.c:379
>>   printk+0xaa/0xca kernel/printk/printk.c:1829
>>   print_cpu_stall_info_begin kernel/rcu/tree_plugin.h:1685 [inline]
>>   print_cpu_stall kernel/rcu/tree.c:1510 [inline]
>>   check_cpu_stall.isra.65+0x845/0x15b0 kernel/rcu/tree.c:1592
>>   __rcu_pending kernel/rcu/tree.c:3362 [inline]
>>   rcu_pending kernel/rcu/tree.c:3424 [inline]
>>   rcu_check_callbacks+0x238/0xd20 kernel/rcu/tree.c:2764
>>   update_process_times+0x30/0x60 kernel/time/timer.c:1630
>>   tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
>>   tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1148
>>   __run_hrtimer kernel/time/hrtimer.c:1211 [inline]
>>   __hrtimer_run_queues+0x349/0xe10 kernel/time/hrtimer.c:1275
>>   hrtimer_interrupt+0x1d4/0x5f0 kernel/time/hrtimer.c:1309
>>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>>   smp_apic_timer_interrupt+0x14a/0x700
>> arch/x86/kernel/apic/apic.c:1050
>>   apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:920
>>   </IRQ>
>> RIP: 0010:__sanitizer_cov_trace_pc+0xd/0x50 kernel/kcov.c:94
>> RSP: 0018:ffff8801c0ff7b38 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff11
>> RAX: ffff8801c00c4540 RBX: ffffc90001329060 RCX: ffffffff8286efc6
>> RDX: 0000000000010000 RSI: ffffc900021f9000 RDI: ffffc9000132a260
>> RBP: ffff8801c0ff7b38 R08: 0000000000000000 R09: 0000000000000000
>> R10: 1ffff100381fee80 R11: ffffed00381feeb5 R12: ffffc90001328000
>> R13: 000000041fbe821b R14: 0000000020520ffc R15: ffff8801c08fe338
>>   inq_canon drivers/tty/n_tty.c:2409 [inline]
>>   n_tty_ioctl+0x20c/0x2d0 drivers/tty/n_tty.c:2429
>>   tty_ioctl+0x32e/0x1600 drivers/tty/tty_io.c:2638
>>   vfs_ioctl fs/ioctl.c:46 [inline]
>>   do_vfs_ioctl+0x1b1/0x1530 fs/ioctl.c:686
>>   SYSC_ioctl fs/ioctl.c:701 [inline]
>>   SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>>   entry_SYSCALL_64_fastpath+0x1f/0x96
>> RIP: 0033:0x452a09
>> RSP: 002b:00007efcfdd20c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000452a09
>> RDX: 0000000020520ffc RSI: 000000000000541b RDI: 0000000000000015
>> RBP: 00000000000001bf R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006efa88
>> R13: 00000000ffffffff R14: 00007efcfdd216d4 R15: 0000000000000000
>> Code: 24 d9 00 00 00 49 8d 7c 24 40 48 b8 00 00 00 00 00 fc ff df 48
>> 89 fa
>> 48 c1 ea 03 d3 e3 80 3c 02 00 75 17 41 03 5c 24 40 89 da ec <5b> 0f b6
>> c0
>> 41 5c 5d c3 e8 88 b0 18 ff eb c2 e8 e1 b0 18 ff eb
>>       0-....: (125000 ticks this GP) idle=40e/1/4611686018427387906
>> softirq=15450/15450 fqs=31396
>>        (t=125675 jiffies g=8122 c=8121 q=540)
>> NMI backtrace for cpu 0
>> CPU: 0 PID: 5998 Comm: syz-executor3 Not tainted 4.15.0-rc2-mm1+ #39
>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>> BIOS
>> Google 01/01/2011
>> Call Trace:
>>   <IRQ>
>>   __dump_stack lib/dump_stack.c:17 [inline]
>>   dump_stack+0x194/0x257 lib/dump_stack.c:53
>>   nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
>>   nmi_trigger_cpumask_backtrace+0x122/0x180 lib/nmi_backtrace.c:62
>>   arch_trigger_cpumask_backtrace+0x14/0x20
>> arch/x86/kernel/apic/hw_nmi.c:38
>>   trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>>   rcu_dump_cpu_stacks+0x186/0x1da kernel/rcu/tree.c:1375
>>   print_cpu_stall kernel/rcu/tree.c:1524 [inline]
>>   check_cpu_stall.isra.65+0xbb8/0x15b0 kernel/rcu/tree.c:1592
>>   __rcu_pending kernel/rcu/tree.c:3362 [inline]
>>   rcu_pending kernel/rcu/tree.c:3424 [inline]
>>   rcu_check_callbacks+0x238/0xd20 kernel/rcu/tree.c:2764
>>   update_process_times+0x30/0x60 kernel/time/timer.c:1630
>>   tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
>>   tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1148
>>   __run_hrtimer kernel/time/hrtimer.c:1211 [inline]
>>   __hrtimer_run_queues+0x349/0xe10 kernel/time/hrtimer.c:1275
>>   hrtimer_interrupt+0x1d4/0x5f0 kernel/time/hrtimer.c:1309
>>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>>   smp_apic_timer_interrupt+0x14a/0x700
>> arch/x86/kernel/apic/apic.c:1050
>>   apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:920
>>   </IRQ>
>> RIP: 0010:__sanitizer_cov_trace_pc+0xd/0x50 kernel/kcov.c:94
>> RSP: 0018:ffff8801c0ff7b38 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff11
>> RAX: ffff8801c00c4540 RBX: ffffc90001329060 RCX: ffffffff8286efc6
>> RDX: 0000000000010000 RSI: ffffc900021f9000 RDI: ffffc9000132a260
>> RBP: ffff8801c0ff7b38 R08: 0000000000000000 R09: 0000000000000000
>> R10: 1ffff100381fee80 R11: ffffed00381feeb5 R12: ffffc90001328000
>> R13: 000000041fbe821b R14: 0000000020520ffc R15: ffff8801c08fe338
>>   inq_canon drivers/tty/n_tty.c:2409 [inline]
>>   n_tty_ioctl+0x20c/0x2d0 drivers/tty/n_tty.c:2429
>>   tty_ioctl+0x32e/0x1600 drivers/tty/tty_io.c:2638
>>   vfs_ioctl fs/ioctl.c:46 [inline]
>>   do_vfs_ioctl+0x1b1/0x1530 fs/ioctl.c:686
>>   SYSC_ioctl fs/ioctl.c:701 [inline]
>>   SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>>   entry_SYSCALL_64_fastpath+0x1f/0x96
>> RIP: 0033:0x452a09
>> RSP: 002b:00007efcfdd20c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000452a09
>> RDX: 0000000020520ffc RSI: 000000000000541b RDI: 0000000000000015
>> RBP: 00000000000001bf R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006efa88
>> R13: 00000000ffffffff R14: 00007efcfdd216d4 R15: 0000000000000000
