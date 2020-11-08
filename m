Return-Path: <SRS0=hQyk=EO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB84C388F9
	for <linux-serial@archiver.kernel.org>; Sun,  8 Nov 2020 18:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0D5206CB
	for <linux-serial@archiver.kernel.org>; Sun,  8 Nov 2020 18:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgKHSAi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 8 Nov 2020 13:00:38 -0500
Received: from [202.37.96.23] ([202.37.96.23]:44686 "HELO smtp1.taitradio.net"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
        id S1727570AbgKHSAi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Nov 2020 13:00:38 -0500
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2020 13:00:37 EST
Received: from ws3539.taitradio.net (unknown [10.200.21.55])
        by smtp1.taitradio.net (Postfix) with ESMTP id ED8B71C0002;
        Mon,  9 Nov 2020 06:55:03 +1300 (NZDT)
From:   Sam Nobs <samuel.nobs@taitradio.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Sam Nobs <samuel.nobs@taitradio.com>
Subject: [PATCH] tty: serial: imx: fix potential deadlock
Date:   Mon,  9 Nov 2020 06:54:55 +1300
Message-Id: <1604858095-12477-1-git-send-email-samuel.nobs@taitradio.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Enabling the lock dependency validator has revealed
that the way spinlocks are used in the IMX serial
port could result in a deadlock. Note that the configuration
I'm using has the IRQs forced to run in threads via
the kernel parameter threadirqs.

Specifically, imx_uart_int() acquires a spinlock
without disabling the interrupts, meaning that another
interrupt could come along and try to acquire the same
spinlock, potentially causing the two to wait for each
other indefinitely.

Use spin_lock_irqsave() instead to disable interrupts
upon acquisition of the spinlock.

Signed-off-by: Sam Nobs <samuel.nobs@taitradio.com>
---
Here's the lockdep splat for reference:

   ================================
   WARNING: inconsistent lock state
   5.4.46 #1 Not tainted
   --------------------------------
   inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
   irq/26-30860000/992 [HC0[0]:SC0[2]:HE1:SE0] takes:
   ffff00006671d098 (&port_lock_key){?...}, at: imx_uart_int+0x28/0x338
   {IN-HARDIRQ-W} state was registered at:
     lock_acquire+0xd0/0x288
     _raw_spin_lock_irqsave+0x58/0x80
     imx_uart_console_write+0x1e4/0x220
     console_unlock+0x2ac/0x610
     vprintk_emit+0x178/0x330
     vprintk_default+0x48/0x58
     vprintk_func+0xe4/0x248
     printk+0x70/0x90
     crng_fast_load+0x1c4/0x1c8
     add_interrupt_randomness+0x348/0x3e8
     handle_irq_event_percpu+0x50/0x98
     handle_irq_event+0x4c/0xd0
     handle_fasteoi_irq+0xe0/0x188
     generic_handle_irq+0x34/0x50
     __handle_domain_irq+0x98/0x108
     gic_handle_irq+0xd4/0x178
     el1_irq+0xbc/0x180
     arch_cpu_idle+0x34/0x220
     default_idle_call+0x40/0x4c
     do_idle+0x254/0x268
     cpu_startup_entry+0x28/0x48
     rest_init+0x1b4/0x284
     arch_call_rest_init+0x14/0x1c
     start_kernel+0x48c/0x4bc
   irq event stamp: 30
   hardirqs last  enabled at (29): [<ffff800010b22a60>] _raw_spin_unlock_irq+0x38/0x70
   hardirqs last disabled at (28): [<ffff800010b1b060>] __schedule+0xb0/0x770
   softirqs last  enabled at (0): [<ffff8000100b28c0>] copy_process+0x8d8/0x19b0
   softirqs last disabled at (30): [<ffff8000101343f8>] irq_forced_thread_fn+0x0/0xc0

   other info that might help us debug this:
    Possible unsafe locking scenario:

          CPU0
          ----
     lock(&port_lock_key);
     <Interrupt>
       lock(&port_lock_key);

    *** DEADLOCK ***

   no locks held by irq/26-30860000/992.

   stack backtrace:
   CPU: 0 PID: 992 Comm: irq/26-30860000 Not tainted 5.4.46 #1
   Hardware name: Tait i.MX8MM smarc-rcb (DT)
   Call trace:
    dump_backtrace+0x0/0x178
    show_stack+0x24/0x30
    dump_stack+0xdc/0x144
    print_usage_bug+0x1c8/0x1e0
    mark_lock+0x57c/0x740
    __lock_acquire+0x684/0x16d0
    lock_acquire+0xd0/0x288
    _raw_spin_lock+0x44/0x58
    imx_uart_int+0x28/0x338
    irq_forced_thread_fn+0x40/0xc0
    irq_thread+0x1ac/0x280
    kthread+0x138/0x140
    ret_from_fork+0x10/0x18

 drivers/tty/serial/imx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1731d97..29ceaea 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -942,8 +942,9 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	unsigned int usr1, usr2, ucr1, ucr2, ucr3, ucr4;
 	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags = 0;
 
-	spin_lock(&sport->port.lock);
+	spin_lock_irqsave(&sport->port.lock, flags);
 
 	usr1 = imx_uart_readl(sport, USR1);
 	usr2 = imx_uart_readl(sport, USR2);
@@ -1013,7 +1014,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 	}
 
-	spin_unlock(&sport->port.lock);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	return ret;
 }
-- 
2.7.4

