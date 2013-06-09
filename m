From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] serial: imx: enable the clocks for console
Date: Sun, 9 Jun 2013 21:05:47 +0800
Message-ID: <20130609130544.GC20780@S2101-09.ap.freescale.net>
References: <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
 <1370743279-15941-1-git-send-email-b32955@freescale.com>
 <20130609083409.GA32485@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:53961 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753932Ab3FINFg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Jun 2013 09:05:36 -0400
Content-Disposition: inline
In-Reply-To: <20130609083409.GA32485@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, shc_work@mail.ru, festevam@gmail.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Jun 09, 2013 at 04:34:11PM +0800, Shawn Guo wrote:
> On Sun, Jun 09, 2013 at 10:01:19AM +0800, Huang Shijie wrote:
> > The console's clocks are disabled after the uart driver is probed.
> > It makes that we can see less log from the console now
> > (though we still can get all the log by the `dmesg`).
> > 
> > So enable the clocks for console, and we can see all the log again.
> > 
> > This patch also disables the sport->clk_per when we fail to enable
> > the sport->clk_ipg;
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> 
> Tested-by: Shawn Guo <shawn.guo@linaro.org>

Sorry.  I have to take that back.

Though it works fine with BusyBox, I'm getting the following warnings
when booting with an Ubuntu 13.04 rootfs, in which case imx_startup()
and imx_shutdown() will be called for a number of iterations.  That
causes unbalanced clk_prepare_enable vs. clk_disable_unprepare, since
the clk_prepare_enable is under condition if (!uart_console(port)) in
imx_startup(), while clk_disable_unprepare in imx_shutdown() is not.

Shawn

------------[ cut here ]------------
WARNING: CPU: 0 PID: 70 at /home/r65073/repos/next/linux-next/drivers/clk/clk.c:780 __clk_disable+0x68/0x84()
Modules linked in:
CPU: 0 PID: 70 Comm: mountall Not tainted 3.10.0-rc4-next-20130607+ #435
Backtrace: 
[<800116a4>] (dump_backtrace+0x0/0x10c) from [<80011844>] (show_stack+0x18/0x1c)
 r6:8069f4e8 r5:0000030c r4:00000000 r3:00000000
[<8001182c>] (show_stack+0x0/0x1c) from [<8053bce0>] (dump_stack+0x78/0x94)
[<8053bc68>] (dump_stack+0x0/0x94) from [<80023df8>] (warn_slowpath_common+0x6c/0x8c)
 r4:00000000 r3:00000000
[<80023d8c>] (warn_slowpath_common+0x0/0x8c) from [<80023e3c>] (warn_slowpath_null+0x24/0x2c)
 r8:bf2ed008 r7:bfaa9810 r6:000f0013 r5:bf824b80 r4:bf824b80
[<80023e18>] (warn_slowpath_null+0x0/0x2c) from [<8041af84>] (__clk_disable+0x68/0x84)
[<8041af1c>] (__clk_disable+0x0/0x84) from [<8041b098>] (clk_disable+0x20/0x2c)
 r4:600f0013 r3:00000001
[<8041b078>] (clk_disable+0x0/0x2c) from [<802c93e8>] (imx_shutdown+0xbc/0xec)
 r5:bf824b80 r4:bfaa9810
[<802c932c>] (imx_shutdown+0x0/0xec) from [<802c63a0>] (uart_port_shutdown+0x34/0x40)
 r5:bf86f860 r4:bfaa9810
[<802c636c>] (uart_port_shutdown+0x0/0x40) from [<802c68c0>] (uart_shutdown+0x98/0xc4)
 r4:bf86f800 r3:00000000
[<802c6828>] (uart_shutdown+0x0/0xc4) from [<802c7514>] (uart_close+0x5c/0x198)
 r7:bfaa9810 r6:bf274400 r5:bf86f86c r4:bf86f800
[<802c74b8>] (uart_close+0x0/0x198) from [<802ac648>] (tty_release+0xf8/0x500)
[<802ac550>] (tty_release+0x0/0x500) from [<800c5a30>] (__fput+0x9c/0x208)
[<800c5994>] (__fput+0x0/0x208) from [<800c5bac>] (____fput+0x10/0x14)
[<800c5b9c>] (____fput+0x0/0x14) from [<80040234>] (task_work_run+0xb4/0xec)
[<80040180>] (task_work_run+0x0/0xec) from [<80029238>] (do_exit+0x2b0/0x920)
 r8:8000e144 r7:000000f8 r6:bf306300 r5:00000000 r4:bfac1180
[<80028f88>] (do_exit+0x0/0x920) from [<80029a4c>] (do_group_exit+0x50/0xd4)
 r7:000000f8
[<800299fc>] (do_group_exit+0x0/0xd4) from [<80029ae8>] (__wake_up_parent+0x0/0x28)
 r7:000000f8 r6:00000001 r5:0006f7ae r4:0006f79a
[<80029ad0>] (SyS_exit_group+0x0/0x18) from [<8000dfc0>] (ret_fast_syscall+0x0/0x30)
---[ end trace 16d080eb7efea4e9 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 70 at /home/r65073/repos/next/linux-next/drivers/clk/clk.c:689 __clk_unprepare+0x6c/0x8c()
Modules linked in:
CPU: 0 PID: 70 Comm: mountall Tainted: G        W    3.10.0-rc4-next-20130607+ #435
Backtrace: 
[<800116a4>] (dump_backtrace+0x0/0x10c) from [<80011844>] (show_stack+0x18/0x1c)
 r6:8069f4e8 r5:000002b1 r4:00000000 r3:00000000
[<8001182c>] (show_stack+0x0/0x1c) from [<8053bce0>] (dump_stack+0x78/0x94)
[<8053bc68>] (dump_stack+0x0/0x94) from [<80023df8>] (warn_slowpath_common+0x6c/0x8c)
 r4:00000000 r3:00000000
[<80023d8c>] (warn_slowpath_common+0x0/0x8c) from [<80023e3c>] (warn_slowpath_null+0x24/0x2c)
 r8:bf2ed008 r7:bfaa9810 r6:000f0013 r5:bf824b80 r4:bf824b80
[<80023e18>] (warn_slowpath_null+0x0/0x2c) from [<8041b68c>] (__clk_unprepare+0x6c/0x8c)
[<8041b620>] (__clk_unprepare+0x0/0x8c) from [<8041b6c8>] (clk_unprepare+0x1c/0x24)
 r4:bf824b80 r3:00000000
[<8041b6ac>] (clk_unprepare+0x0/0x24) from [<802c93f0>] (imx_shutdown+0xc4/0xec)
 r4:bfaa9810 r3:00000000
[<802c932c>] (imx_shutdown+0x0/0xec) from [<802c63a0>] (uart_port_shutdown+0x34/0x40)
 r5:bf86f860 r4:bfaa9810
[<802c636c>] (uart_port_shutdown+0x0/0x40) from [<802c68c0>] (uart_shutdown+0x98/0xc4)
 r4:bf86f800 r3:00000000
[<802c6828>] (uart_shutdown+0x0/0xc4) from [<802c7514>] (uart_close+0x5c/0x198)
 r7:bfaa9810 r6:bf274400 r5:bf86f86c r4:bf86f800
[<802c74b8>] (uart_close+0x0/0x198) from [<802ac648>] (tty_release+0xf8/0x500)
[<802ac550>] (tty_release+0x0/0x500) from [<800c5a30>] (__fput+0x9c/0x208)
[<800c5994>] (__fput+0x0/0x208) from [<800c5bac>] (____fput+0x10/0x14)
[<800c5b9c>] (____fput+0x0/0x14) from [<80040234>] (task_work_run+0xb4/0xec)
[<80040180>] (task_work_run+0x0/0xec) from [<80029238>] (do_exit+0x2b0/0x920)
 r8:8000e144 r7:000000f8 r6:bf306300 r5:00000000 r4:bfac1180
[<80028f88>] (do_exit+0x0/0x920) from [<80029a4c>] (do_group_exit+0x50/0xd4)
 r7:000000f8
[<800299fc>] (do_group_exit+0x0/0xd4) from [<80029ae8>] (__wake_up_parent+0x0/0x28)
 r7:000000f8 r6:00000001 r5:0006f7ae r4:0006f79a
[<80029ad0>] (SyS_exit_group+0x0/0x18) from [<8000dfc0>] (ret_fast_syscall+0x0/0x30)
---[ end trace 16d080eb7efea4ea ]---
------------[ cut here ]------------

