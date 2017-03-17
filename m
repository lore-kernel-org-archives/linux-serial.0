From: Arun Chandran <achandran@mvista.com>
Subject: Console stops with calltrace on cavium octeon2 68XX EVB
Date: Fri, 17 Mar 2017 18:30:54 +0530
Message-ID: <CAFdej01TKnVy0=SrtDAwnsmaqzq2xnEM3bB2+CCFjp2rDCn2rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Cc: jason.uy@broadcom.com, scott.branden@broadcom.com, ray.jui@broadcom.com, wangkefeng.wang@huawei.com, andriy.shevchenko@linux.intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, heikki.krogerus@linux.intel.com
List-Id: linux-serial@vger.kernel.org

Hi,

I got this on my cavium octeon2 68XX EVB console when booting the
latest kernel(4.11.0-rc2-00235-gd528ae0).

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/tty/serial/serial_core.c:442
uart_get_baud_rate+0x114/0x1e8
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc2-00235-gd528ae0-dirty #58
Stack : ffffffff81870000 ffffffff8165d658 ffffffff81870000 ffffffff811884e4
        0000000000000000 0000000000000001 800000004a71d5a8 000000000000004e
        ffffffff8186e722 000000000000004d 0000000000000000 ffffffff8186e722
        000000000000004d ffffffff81188190 0000000000000000 ffffffff8186e722
        000000000000004d ffffffff81188a08 0000000000000000 ffffffff81867bf8
        ffffffff81718388 800000040f538d00 ffffffff817d0a07 ffffffff81867bf8
        0000000000000001 0000000000000000 ffffffffffffffff 800000040f53f810
        0000000000000002 800000040f53f560 800000040f53f678 ffffffff813cf32c
        0000000000000002 ffffffff81189888 000000000000003a ffffffff81718388
        0000000000000000 ffffffff81122868 0000000000000000 0000000000000000
        ...
Call Trace:
[<ffffffff81122868>] show_stack+0x88/0xa8
[<ffffffff813cf32c>] dump_stack+0x9c/0xd0
[<ffffffff81142408>] __warn+0x108/0x120
[<ffffffff814488e4>] uart_get_baud_rate+0x114/0x1e8
[<ffffffff81451528>] serial8250_do_set_termios+0xb0/0x438
[<ffffffff81448cf8>] uart_set_options+0xf0/0x1c8
[<ffffffff814530a4>] serial8250_console_setup+0x84/0x160
[<ffffffff8144d734>] univ8250_console_setup+0x54/0x70
[<ffffffff81189130>] register_console+0x160/0x420
[<ffffffff8144b608>] uart_add_one_port+0x4b0/0x4c8
[<ffffffff8144e010>] serial8250_register_8250_port+0x2d8/0x420
[<ffffffff81457014>] dw8250_probe+0x384/0x5d8
[<ffffffff814655ec>] platform_drv_probe+0x44/0xb8
[<ffffffff81463448>] driver_probe_device+0x218/0x310
[<ffffffff81463610>] __driver_attach+0xd0/0xd8
[<ffffffff8146119c>] bus_for_each_dev+0x6c/0xb8
[<ffffffff814628a8>] bus_add_driver+0x1f8/0x270
[<ffffffff8146409c>] driver_register+0x84/0x130
[<ffffffff81100578>] do_one_initcall+0x48/0x140
[<ffffffff8180ddc8>] kernel_init_freeable+0x194/0x24c
[<ffffffff8165760c>] kernel_init+0x14/0x118
[<ffffffff8111cae4>] ret_from_kernel_thread+0x14/0x1c
---[ end trace 8f3f4eaaf76a55a3 ]---

And I bisected and reached at this commit
"6a171b2 serial: 8250_dw: Allow hardware flow control to be used"

When I printed the value of my "d->clk" inside dw8250_set_termios() it was zero.
Then the below change is solving the problem for me.(No calltrace
console works fine)

########
diff --git a/drivers/tty/serial/8250/8250_dw.c
b/drivers/tty/serial/8250/8250_dw.c
index 6ee55a2..7e06d59 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -260,7 +260,7 @@ static void dw8250_set_termios(struct uart_port
*p, struct ktermios *termios,
        unsigned int rate;
        int ret;

-       if (IS_ERR(d->clk) || !old)
+       if (IS_ERR(d->clk) || !old || !clk_get_rate(d->clk))
                goto out;

        clk_disable_unprepare(d->clk);
##########

Can anybody please comment on this?

--Arun
