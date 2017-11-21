From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [serial8250_interrupt] RIP: 0010:arch_local_irq_restore+0x2/0x8
Date: Tue, 21 Nov 2017 16:39:14 +0200
Message-ID: <1511275154.25007.349.camel@linux.intel.com>
References: <20171121090529.p3bcdz5y5bs5mqk2@wfg-t540p.sh.intel.com>
         <20171121123357.bw5raz3vqkob2vgz@wfg-t540p.sh.intel.com>
         <20171121133120.43fe5ak2gct56nmp@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171121133120.43fe5ak2gct56nmp@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Sean Young <sean@mess.org>, Matthias Brugger <mbrugger@suse.com>, linux-kernel@vger.kernel.org, lkp@01.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2017-11-21 at 21:31 +0800, Fengguang Wu wrote:
> On Tue, Nov 21, 2017 at 08:33:57PM +0800, Fengguang Wu wrote:
> > Hello,
> > 
> > FYI this happens in mainline kernel 4.14.0-02748-gabc36be.
> > It shows up since v4.13 .
> 
> Sorry it actually also shows up in 4.10:

This one means that interrupt storm is occurred. Last time I saw that
was by the fact of some specific IOAPIC configuration when DMA for UART
was enabled.

I'm pretty sure that is not the case here. Though, it would be nice to
see link to the following files:

1. % acpidump -o tables.dat # tables.dat is point of interest
2. % lspci -vv -nk # output of the command
3. % dmidecode # output of the command
4. % grep -H 15 /sys/bus/acpi/devices/*/status # output of the command
5. % dmesg # when kernel command line has the 'ignore_loglevel
initcall_debug' added

Also 
% cat /proc/interrupts # if possible in both working / non-working cases


> /pkg/linux/x86_64-rhel-7.2+CONFIG_DEBUG_INFO_REDUCED/gcc-
> 6/c470abd4fde40ea6a0846a2beab642a578c0b8cd/dmesg-vm-lkp-hsw01-4G-
> 1:20171110043200:x86_64-rhel-7.2+CONFIG_DEBUG_INFO_REDUCED:4.10.0:1
> 
> [   19.902933]
> [   19.904514]
> [   19.904515]
> [   21.020567] irq 3: nobody cared (try booting with the "irqpoll"
> option)
> [   21.021466] CPU: 0 PID: 4094 Comm: dmesg Not tainted 4.10.0 #1
> [   21.022276] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1 04/01/2014
> [   21.023584] Call Trace:
> [   21.024126]  <IRQ>
> [   21.025622]  dump_stack+0x63/0x8a
> [   21.026238]  __report_bad_irq+0x35/0xc0
> [   21.026890]  note_interrupt+0x234/0x270
> [   21.027548]  handle_irq_event_percpu+0x45/0x60
> [   21.028249]  handle_irq_event+0x42/0x70
> [   21.028901]  handle_edge_irq+0x74/0x140
> [   21.029560]  handle_irq+0x73/0x120
> [   21.030177]  ? irq_exit+0x6a/0xf0
> [   21.030794]  do_IRQ+0x46/0xd0
> [   21.031380]  common_interrupt+0x8e/0x8e
> [   21.032042] RIP: 0010:_raw_spin_unlock_irqrestore+0x15/0x30
> [   21.032831] RSP: 0018:ffffc90002d9fd28 EFLAGS: 00000286 ORIG_RAX:
> ffffffffffffffcc
> [   21.034081] RAX: 0000000000000001 RBX: ffffffff82362ee8 RCX:
> 0000000000000000
> [   21.034999] RDX: 00000000000002f9 RSI: 0000000000000286 RDI:
> 0000000000000286
> [   21.035914] RBP: ffffc90002d9fd28 R08: 0000000000000004 R09:
> ffff88012e6dfc38
> [   21.036826] R10: 00007ffc8f5bb708 R11: ffff88007f542580 R12:
> ffff88007fd51c00
> [   21.037742] R13: 0000000000000286 R14: ffffc900031672a0 R15:
> 0000000000000001
> [   21.038654]  </IRQ>
> [   21.039171]  uart_start+0x73/0xe0
> [   21.039783]  uart_flush_chars+0xe/0x10
> [   21.040430]  n_tty_write+0x231/0x450
> [   21.041068]  ? __wake_up_sync+0x20/0x20
> [   21.041721]  tty_write+0x1ab/0x330
> [   21.042346]  ? n_tty_open+0xd0/0xd0
> [   21.042972]  __vfs_write+0x28/0x140
> [   21.043602]  ? security_file_permission+0x3b/0xc0
> [   21.044326]  ? rw_verify_area+0x4e/0xb0
> [   21.044977]  vfs_write+0xc8/0x1e0
> [   21.045596]  SyS_write+0x46/0xa0
> [   21.046207]  entry_SYSCALL_64_fastpath+0x1a/0xa9
> [   21.046926] RIP: 0033:0x7f7a0064a720
> [   21.047560] RSP: 002b:00007ffc8f5bb688 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [   21.048811] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
> 00007f7a0064a720
> [   21.049723] RDX: 0000000000000001 RSI: 000000000060c400 RDI:
> 0000000000000001
> [   21.050636] RBP: 00007f7a00907683 R08: 00007f7a00908760 R09:
> 00007f7a00907600
> [   21.051554] R10: 00007ffc8f5bb708 R11: 0000000000000246 R12:
> 0000000000000001
> [   21.052471] R13: 0000000000000001 R14: 00007f7a00907600 R15:
> 0000000000000001
> [   21.053383] handlers:
> [   21.053913] [<ffffffff81529190>] serial8250_interrupt
> [   21.054662] Disabling IRQ #3
> 
> Fengguang

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
