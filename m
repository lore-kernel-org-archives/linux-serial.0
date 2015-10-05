From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: IMX6 serial fuckage
Date: Mon, 5 Oct 2015 21:27:18 +0100
Message-ID: <20151005202718.GL21513@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Greg,

Please revert this commit:

commit 9e7b399d6528eac33a6fbfceb2b92af209c3454d
Author: Eduardo Valentin <edubezval@gmail.com>
Date:   Tue Aug 11 10:21:20 2015 -0700

@@ -1630,12 +1630,12 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
        int locked = 1;
        int retval;
 
-       retval = clk_enable(sport->clk_per);
+       retval = clk_prepare_enable(sport->clk_per);
        if (retval)
                return;
-       retval = clk_enable(sport->clk_ipg);
+       retval = clk_prepare_enable(sport->clk_ipg);
        if (retval) {
-               clk_disable(sport->clk_per);
+               clk_disable_unprepare(sport->clk_per);
                return;
        }
 
@@ -1674,8 +1674,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
        if (locked)
                spin_unlock_irqrestore(&sport->port.lock, flags);
 
-       clk_disable(sport->clk_ipg);
-       clk_disable(sport->clk_per);
+       clk_disable_unprepare(sport->clk_ipg);
+       clk_disable_unprepare(sport->clk_per);
 }
 
 /*

Which, *shock horror* and no surprise what so ever, produces this at
boot time:

WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:868 mutex_trylock+0x200/0x21c()
DEBUG_LOCKS_WARN_ON(in_interrupt())
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.3.0-rc4+ #1826
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Backtrace: 
[<c0013914>] (dump_backtrace) from [<c0013ab0>] (show_stack+0x18/0x1c)
 r6:c07654d4 r5:00000364 r4:00000000 r3:00000000
[<c0013a98>] (show_stack) from [<c0308b84>] (dump_stack+0x7c/0x98)
[<c0308b08>] (dump_stack) from [<c002a348>] (warn_slowpath_common+0x80/0xbc)
 r4:c0a73ab0 r3:c0a78bb8
[<c002a2c8>] (warn_slowpath_common) from [<c002a428>] (warn_slowpath_fmt+0x38/0x40)
 r8:00000000 r7:c14b097c r6:c053be1c r5:c14b297c r4:c0adf5b4
[<c002a3f4>] (warn_slowpath_fmt) from [<c07654d4>] (mutex_trylock+0x200/0x21c)
 r3:c09111c8 r2:c090e21c
[<c07652d4>] (mutex_trylock) from [<c053be1c>] (clk_prepare_lock+0x14/0xf4)
 r7:c14b097c r6:ee071000 r5:00000037 r4:ee071000
[<c053be08>] (clk_prepare_lock) from [<c053e2d0>] (clk_prepare+0x18/0x30)
 r5:00000037 r4:ee071000
[<c053e2b8>] (clk_prepare) from [<c037e718>] (imx_console_write+0x30/0x228)
 r4:c12b0530 r3:00000000
[<c037e6e8>] (imx_console_write) from [<c0082688>] (call_console_drivers.constprop.13+0x124/0x184)
 r10:c076c004 r9:00000000 r8:00000000 r7:c14b097c r6:00000037 r5:c12b0030
 r4:c0abdbac
[<c0082564>] (call_console_drivers.constprop.13) from [<c008427c>] (console_unlock+0x4e8/0x5b8)
 r10:00000037 r9:00000000 r8:00000001 r7:00000000 r6:000000e9 r5:c14b1828
 r4:c12b51bc
[<c0083d94>] (console_unlock) from [<c0084d30>] (vprintk_emit+0x244/0x5b4)
 r10:c12b0030 r9:600f0193 r8:00000000 r7:00000006 r6:00000027 r5:c0a80d4c
 r4:0000000f
[<c0084aec>] (vprintk_emit) from [<c00850cc>] (vprintk_default+0x2c/0x34)
 r10:600f0193 r9:00000081 r8:c0abdf60 r7:000000ce r6:00000001 r5:c0abdf60
 r4:c0abdef4
[<c00850a0>] (vprintk_default) from [<c00f093c>] (printk+0x34/0x40)
[<c00f090c>] (printk) from [<c0384494>] (credit_entropy_bits+0x1e4/0x3a0)
 r3:c0a78bb8 r2:c0abdda4 r1:c094fef4 r0:c094fd44
[<c03842b0>] (credit_entropy_bits) from [<c0386bac>] (add_interrupt_randomness+0x160/0x1ec)
 r10:0000011d r9:c0afe8dc r8:c0a73e00 r7:c0abdf28 r6:fffee471 r5:c0abdef4
 r4:eef89750
[<c0386a4c>] (add_interrupt_randomness) from [<c0086084>] (handle_irq_event_percpu+0xc8/0x228)
 r10:c0afe8c8 r8:00000001 r7:0000011d r6:ee1d03c0 r5:00000001 r4:00000000
[<c0085fbc>] (handle_irq_event_percpu) from [<c008622c>] (handle_irq_event+0x48/0x6c)
 r10:f4001100 r9:c076c004 r8:ee824000 r7:00000096 r6:ee1d03c0 r5:eea13660
 r4:eea13600
[<c00861e4>] (handle_irq_event) from [<c008920c>] (handle_fasteoi_irq+0xbc/0x194)
 r6:c0ab4814 r5:eea13660 r4:eea13600 r3:00000000
[<c0089150>] (handle_fasteoi_irq) from [<c00858a0>] (generic_handle_irq+0x20/0x30)
 r7:00000096 r6:00000000 r5:c0a73f08 r4:c0a6e6e4
[<c0085880>] (generic_handle_irq) from [<c00859d4>] (__handle_domain_irq+0x5c/0xb8)
[<c0085978>] (__handle_domain_irq) from [<c00094b4>] (gic_handle_irq+0x48/0x94)
 r8:c0a73e00 r7:c0ab47f0 r6:c0a75b18 r5:f400010c r4:f4000100 r3:c0a73e00
[<c000946c>] (gic_handle_irq) from [<c00146f8>] (__irq_svc+0x58/0x78)
Exception stack(0xc0a73e00 to 0xc0a73e48)
3e00: 00000001 00000000 00000000 00000000 c002f028 00000000 00000202 c0afe88c
3e20: ee824000 c076c004 f4001100 c0a73e9c c0a73e20 c0a73e50 c0073fd0 c002ea10
3e40: 600f0113 ffffffff
 r10:f4001100 r8:ee824000 r7:c0a73e34 r6:ffffffff r5:600f0113 r4:c002ea10
[<c002e940>] (__do_softirq) from [<c002f028>] (irq_exit+0xe0/0x14c)
 r10:f4001100 r9:c076c004 r8:ee824000 r7:0000001d r6:00000000 r5:00000000
 r4:c0a6e6e4
[<c002ef48>] (irq_exit) from [<c00859d8>] (__handle_domain_irq+0x60/0xb8)
 r4:c0a6e6e4 r3:c0089810
[<c0085978>] (__handle_domain_irq) from [<c00094b4>] (gic_handle_irq+0x48/0x94)
 r8:c0a73f08 r7:c0ab47f0 r6:c0a75b18 r5:f400010c r4:f4000100 r3:c0a73f08
[<c000946c>] (gic_handle_irq) from [<c00146f8>] (__irq_svc+0x58/0x78)
Exception stack(0xc0a73f08 to 0xc0a73f50)
3f00:                   00000001 00000001 00000000 c0021c60 c0a755a0 c0a75554
3f20: c0afee90 c0b02840 c0a6c414 c076c004 efffc940 c0a73f64 c0a73f28 c0a73f58
3f40: c0074020 c001078c 200f0013 ffffffff
 r10:efffc940 r8:c0a6c414 r7:c0a73f3c r6:ffffffff r5:200f0013 r4:c001078c
[<c0010764>] (arch_cpu_idle) from [<c006c268>] (default_idle_call+0x28/0x38)
[<c006c240>] (default_idle_call) from [<c006c3e0>] (cpu_startup_entry+0x168/0x284)
[<c006c278>] (cpu_startup_entry) from [<c0761fe4>] (rest_init+0x130/0x168)
 r7:c0b02840 r3:00000000
[<c0761eb4>] (rest_init) from [<c09f9cec>] (start_kernel+0x380/0x3e8)
 r5:00000001 r4:c0b02890
[<c09f996c>] (start_kernel) from [<1000807c>] (0x1000807c)
---[ end trace 3999d1b9ea157b43 ]---

clk_prepare() and clk_prepare_enable() must only ever be used from process
context - they _always_ take a mutex.  No exception.  It's a simple rule,
but one which must always be obeyed!  Therefore, it must never appear in
_any_ console_write() implementation.

Greg, please revert this fundamentally broken and improperly tested
commit.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
