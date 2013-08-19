From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Mon, 19 Aug 2013 11:31:16 -0400
Message-ID: <52123A44.9090608@hurleysoftware.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:58835 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750793Ab3HSPbY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Aug 2013 11:31:24 -0400
In-Reply-To: <cover.1376923198.git.viresh.kumar@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>

On 08/19/2013 10:44 AM, Viresh Kumar wrote:
> Many serial driver triggers a lockdep warning for if tty_flip_buffer_push() is
> called with uart_port->lock locked. This never shows up on UP kernels and comes
> up only on SMP kernels.
>
> Crash looks like this (produced with samsung.c driver):

Please review commit 677fe555cbfb188af58cce105f4dae9505e58c31
'serial: imx: Fix recursive locking bug' to see if that is actually the problem
you're having with the samsung serial driver.

> -----
> [<c0014d58>] (unwind_backtrace+0x0/0xf8) from [<c0011908>] (show_stack+0x10/0x14)
> [<c0011908>] (show_stack+0x10/0x14) from [<c035da34>] (dump_stack+0x6c/0xac)
> [<c035da34>] (dump_stack+0x6c/0xac) from [<c01b59ac>] (do_raw_spin_unlock+0xc4/0xd8)
> [<c01b59ac>] (do_raw_spin_unlock+0xc4/0xd8) from [<c03627e4>] (_raw_spin_unlock_irqrestore+0xc/0)
> [<c03627e4>] (_raw_spin_unlock_irqrestore+0xc/0x38) from [<c020a1a8>] (s3c24xx_serial_rx_chars+0)
> [<c020a1a8>] (s3c24xx_serial_rx_chars+0x12c/0x260) from [<c020aae8>] (s3c64xx_serial_handle_irq+)
> [<c020aae8>] (s3c64xx_serial_handle_irq+0x48/0x60) from [<c006aaa0>] (handle_irq_event_percpu+0x)
> [<c006aaa0>] (handle_irq_event_percpu+0x50/0x194) from [<c006ac20>] (handle_irq_event+0x3c/0x5c)
> [<c006ac20>] (handle_irq_event+0x3c/0x5c) from [<c006d864>] (handle_fasteoi_irq+0x80/0x13c)
> [<c006d864>] (handle_fasteoi_irq+0x80/0x13c) from [<c006a4a4>] (generic_handle_irq+0x20/0x30)
> [<c006a4a4>] (generic_handle_irq+0x20/0x30) from [<c000f454>] (handle_IRQ+0x38/0x94)
> [<c000f454>] (handle_IRQ+0x38/0x94) from [<c0008538>] (gic_handle_irq+0x34/0x68)
> [<c0008538>] (gic_handle_irq+0x34/0x68) from [<c00123c0>] (__irq_svc+0x40/0x70)
> Exception stack(0xc04cdf70 to 0xc04cdfb8)
> df60:                                     00000000 00000000 0000166e 00000000
> df80: c04cc000 c050278f c050278f 00000001 c04d444c 410fc0f4 c03649b0 00000000
> dfa0: 00000001 c04cdfb8 c000f758 c000f75c 60070013 ffffffff
> [<c00123c0>] (__irq_svc+0x40/0x70) from [<c000f75c>] (arch_cpu_idle+0x28/0x30)
> [<c000f75c>] (arch_cpu_idle+0x28/0x30) from [<c0054888>] (cpu_startup_entry+0x5c/0x148)
> [<c0054888>] (cpu_startup_entry+0x5c/0x148) from [<c0497aa4>] (start_kernel+0x334/0x38c)
> BUG: spinlock lockup suspected on CPU#0, kworker/0:1/360
>   lock: s3c24xx_serial_ports+0x1d8/0x370, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
> CPU: 0 PID: 360 Comm: kworker/0:1 Not tainted 3.11.0-rc6-next-20130819-00003-g75485f1 #2
> Workqueue: events flush_to_ldisc
> [<c0014d58>] (unwind_backtrace+0x0/0xf8) from [<c0011908>] (show_stack+0x10/0x14)
> [<c0011908>] (show_stack+0x10/0x14) from [<c035da34>] (dump_stack+0x6c/0xac)
> [<c035da34>] (dump_stack+0x6c/0xac) from [<c01b581c>] (do_raw_spin_lock+0x100/0x17c)
> [<c01b581c>] (do_raw_spin_lock+0x100/0x17c) from [<c03628a0>] (_raw_spin_lock_irqsave+0x20/0x28)
> [<c03628a0>] (_raw_spin_lock_irqsave+0x20/0x28) from [<c0203224>] (uart_start+0x18/0x34)
> [<c0203224>] (uart_start+0x18/0x34) from [<c01ef890>] (__receive_buf+0x4b4/0x738)
> [<c01ef890>] (__receive_buf+0x4b4/0x738) from [<c01efb44>] (n_tty_receive_buf2+0x30/0x98)
> [<c01efb44>] (n_tty_receive_buf2+0x30/0x98) from [<c01f2ba8>] (flush_to_ldisc+0xec/0x138)
> [<c01f2ba8>] (flush_to_ldisc+0xec/0x138) from [<c0031af0>] (process_one_work+0xfc/0x348)
> [<c0031af0>] (process_one_work+0xfc/0x348) from [<c0032138>] (worker_thread+0x138/0x37c)
> [<c0032138>] (worker_thread+0x138/0x37c) from [<c0037a7c>] (kthread+0xa4/0xb0)
> [<c0037a7c>] (kthread+0xa4/0xb0) from [<c000e5f8>] (ret_from_fork+0x14/0x3c)
> -----
>
> This patchset modifies these drivers to release the port lock before calling
> tty_flip_buffer_push() and reacquire it after the call.
>
> Similar stuff was already done for few other drivers in the past, like:
>
> 	commit 2389b272168ceec056ca1d8a870a97fa9c26e11a
> 	Author: Thomas Gleixner <tglx@linutronix.de>
> 	Date:   Tue May 29 21:53:50 2007 +0100
> 	
> 	    [ARM] 4417/1: Serial: Fix AMBA drivers locking
> 	
> This is build tested for all drivers and tested on Samsung's Arndale board for
> samsung.c driver. Rebased over linux-next (Problem was reproduced on this
> branch):
>
> 	commit 1e712b0818569846d6b926ecb6bf32b3dea73609
> 	Author: Stephen Rothwell <sfr@canb.auug.org.au>
> 	Date:   Fri Aug 16 17:06:26 2013 +1000
> 	
> 	    Add linux-next specific files for 20130816
> 	
> 	    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Tony Prisk <linux@prisktech.co.nz>
>
> Viresh Kumar (25):
>    tty: serial: altera_jtag: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: altera: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: apbuart: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: ar933x: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: arc: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: bcm63xx: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: bfin_sport: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: efm32: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: icom: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: lpc32xx_hs: don't call tty_flip_buffer_push() twice
>    tty: serial: lpc32xx_hs: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: m32r_sio: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: mcf: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: mfd: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: mpsc: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: msm: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: netx: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: nwpserial: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: pnx8xxx: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: rp2: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: sa1100: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: samsung: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: tegra: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: sirfsoc: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>    tty: serial: vt8500: drop uart_port->lock before calling
>      tty_flip_buffer_push()
>
>   drivers/tty/serial/altera_jtaguart.c |  2 ++
>   drivers/tty/serial/altera_uart.c     |  2 ++
>   drivers/tty/serial/apbuart.c         |  2 ++
>   drivers/tty/serial/ar933x_uart.c     |  2 ++
>   drivers/tty/serial/arc_uart.c        |  2 ++
>   drivers/tty/serial/bcm63xx_uart.c    |  2 ++
>   drivers/tty/serial/bfin_sport_uart.c |  5 +++--
>   drivers/tty/serial/efm32-uart.c      |  4 ++--
>   drivers/tty/serial/icom.c            |  3 +++
>   drivers/tty/serial/lpc32xx_hs.c      |  7 ++++---
>   drivers/tty/serial/m32r_sio.c        |  3 +++
>   drivers/tty/serial/mcf.c             |  2 ++
>   drivers/tty/serial/mfd.c             | 14 ++++++++++----
>   drivers/tty/serial/mpsc.c            | 11 ++++++++---
>   drivers/tty/serial/msm_serial.c      |  5 +++++
>   drivers/tty/serial/netx-serial.c     |  6 ++++--
>   drivers/tty/serial/nwpserial.c       |  3 +++
>   drivers/tty/serial/pnx8xxx_uart.c    |  3 +++
>   drivers/tty/serial/rp2.c             |  2 ++
>   drivers/tty/serial/sa1100.c          |  3 +++
>   drivers/tty/serial/samsung.c         |  5 ++++-
>   drivers/tty/serial/serial-tegra.c    | 10 ++++++++--
>   drivers/tty/serial/sirfsoc_uart.c    |  3 +++
>   drivers/tty/serial/vt8500_serial.c   |  2 ++
>   24 files changed, 84 insertions(+), 19 deletions(-)
>

