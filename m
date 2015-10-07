From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: imx serial driver commit breaks system boot on i.MX6 boards
Date: Wed, 7 Oct 2015 16:39:05 +0200
Message-ID: <20151007143904.GA11573@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, fabio.estevam@freescale.com, edubezval@gmail.com, jslaby@suse.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

the imx serial driver is broken after the "serial: imx: remove unbalanced
clk_prepare" commit 9e7b399d6528eac33a6fbfceb2b92af209c3454d.

My i.MX6Q boards do not boot anymore due to aforementioned commit.

The error looks like this:
...
[    0.510764] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 21, base_baud = 5000000) is a IMX
[    0.513005] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 286, base_baud = 5000000) is a IMX
[    1.295637] console [ttymxc1] enabled
[    1.295662] BUG: scheduling while atomic: swapper/0/1/0x00000002
[    1.295668] 4 locks held by swapper/0/1:
[    1.295693]  #0:  (&dev->mutex){......}, at: [<802e8fbc>] __driver_attach+0x48/0x98
[    1.295712]  #1:  (&dev->mutex){......}, at: [<802e8fcc>] __driver_attach+0x58/0x98
[    1.295737]  #2:  (port_mutex){+.+.+.}, at: [<802dad8c>] uart_add_one_port+0x78/0x4c8
[    1.295756]  #3:  (&port->mutex){+.+.+.}, at: [<802dad98>] uart_add_one_port+0x84/0x4c8
[    1.295762] Modules linked in:
[    1.295765] irq event stamp: 236325
[    1.295779] hardirqs last  enabled at (236325): [<80081fdc>] vprintk_emit+0x23c/0x624
[    1.295788] hardirqs last disabled at (236324): [<80081df0>] vprintk_emit+0x50/0x624
[    1.295806] softirqs last  enabled at (236300): [<800353f4>] __do_softirq+0x228/0x2ac
[    1.295816] softirqs last disabled at (236293): [<800357ac>] irq_exit+0xd8/0x114
[    1.295823] Preemption disabled at:[<  (null)>]   (null)
[    1.295825] 
[    1.295835] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.3.0-rc4-00037-g9751522 #41
[    1.295839] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    1.295868] [<80017a0c>] (unwind_backtrace) from [<80013fa4>] (show_stack+0x10/0x14)
[    1.295888] [<80013fa4>] (show_stack) from [<8027bd94>] (dump_stack+0x84/0xc4)
[    1.295908] [<8027bd94>] (dump_stack) from [<80055b7c>] (__schedule_bug+0x7c/0xdc)
[    1.295931] [<80055b7c>] (__schedule_bug) from [<80548bf4>] (__schedule+0x4dc/0x5f8)
[    1.295942] [<80548bf4>] (__schedule) from [<80548dc4>] (schedule+0x48/0xa8)
[    1.295956] [<80548dc4>] (schedule) from [<8054dd6c>] (schedule_hrtimeout_range_clock+0xb4/0x138)
[    1.295971] [<8054dd6c>] (schedule_hrtimeout_range_clock) from [<8054d874>] (usleep_range+0x68/0x84)
[    1.295994] [<8054d874>] (usleep_range) from [<803e95d8>] (clk_pllv3_wait_lock+0x78/0xac)
[    1.296008] [<803e95d8>] (clk_pllv3_wait_lock) from [<803e2c88>] (clk_core_prepare+0x98/0xbc)
[    1.296019] [<803e2c88>] (clk_core_prepare) from [<803e2c68>] (clk_core_prepare+0x78/0xbc)
...

After that it shows the same error, starting again with "BUG: scheduling while
atomic.."

A revert patch from Fabio Estevam was sent on Aug 18th of 2015.

Is there a reason why that revert patch has not been merged yet?
Hopefully this will be fixed before the 4.3 release.

Thanks,
Clemens
