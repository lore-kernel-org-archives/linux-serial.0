Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33778C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 01:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F324420771
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 01:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VopjB/Lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHNBjF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHNBjE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 21:39:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C999CC061757;
        Thu, 13 Aug 2020 18:39:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so3769142pgq.1;
        Thu, 13 Aug 2020 18:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdUEpqPLAWiH76vNLm33JhozhaIzhcxHNCW7BX3+j58=;
        b=VopjB/LwDvUWbHL2HfQixXSp6Rncrg97cHKOlIjs1xXpK9pfNvUktX5zS122g7xGRS
         Z94e/AXFMI6LkpkHdgLBQzWVr7HsmKc1zodUm35zRAtjVWBgGkH09E4a6VezpxhJw2CD
         9UTLyMFf9AocCXwDdYrzkfX2hieis+qr/j5YmSs4ckijwZZzZJ35RgWEIrQ17LTtvjbf
         8l19qKEjRfh8pQJLbnxw1mWTs1dPrJZ1FYiP86KIOwHG8nk8yUFy9oq50ED1C+91KJHS
         94hILk8tEdVwlUQl4kgYV3uxBj0aJ4f8BbL05ghubJwOlfKZjzSY916UaAH/v4/BiNKW
         EeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdUEpqPLAWiH76vNLm33JhozhaIzhcxHNCW7BX3+j58=;
        b=EMERgrIXL3GYv1iCYOQzI2uJ3yIpMsUiid5JLnGlZsuNCLW9ISyosYtlXdrSNVPOdz
         2HVCX78Rlzk39geaX5cAK5lX9Nsj2qgbmlhQGugjBQ8ijhUVjhuRxwKMPl9JStbPO20U
         n/eOl0hMmJJhbADSxlyS6Gz6xXtPhG80eaY0YmtUnPhO9vAou7X7S2URRSMe+w4m/rs8
         IorxCaHP33Cm7+UCMH2tlKzBcFKzl3CQCIq9bxNbp7DivyNG9ELcwcpc8dcefLf9OzsZ
         a8uFCjydy/tFQbTPk62WV0rBlRQaGXNhp3LsEiQBu69F9X3WY57/funAiVoqOi9yMe+e
         8afA==
X-Gm-Message-State: AOAM533K/2smPLLHanTIQ/s0AoYAudpzAu8q7zf/zmpWmhp3Iy30XbAa
        62a+bMiIewajxoe7PZmqzoM=
X-Google-Smtp-Source: ABdhPJwT/Vjdx0zct9kLfDv8HYdt3tFA5tGVq7Zn6853Z20K5yw/yOo4xh0mbtPQlydV59q1rUmJWA==
X-Received: by 2002:a62:7c09:: with SMTP id x9mr110547pfc.229.1597369143988;
        Thu, 13 Aug 2020 18:39:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id i14sm6312445pjz.25.2020.08.13.18.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 18:39:03 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] uart:8250: change lock order in serial8250_do_startup()
Date:   Fri, 14 Aug 2020 10:38:02 +0900
Message-Id: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We have a number of "uart.port->desc.lock vs desc.lock->uart.port"
lockdep reports coming from 8250 driver; this causes a bit of trouble
to people, so let's fix it.

The problem is reverse lock order in two different call paths:

chain #1:

 serial8250_do_startup()
  spin_lock_irqsave(&port->lock);
   disable_irq_nosync(port->irq);
    raw_spin_lock_irqsave(&desc->lock)

chain #2:

  __report_bad_irq()
   raw_spin_lock_irqsave(&desc->lock)
    for_each_action_of_desc()
     printk()
      spin_lock_irqsave(&port->lock);

Fix this by changing the order of locks in serial8250_do_startup():
 do disable_irq_nosync() first, which grabs desc->lock, and grab
 uart->port after that, so that chain #1 and chain #2 have same lock
 order.

Full lockdep splat:

 ======================================================
 WARNING: possible circular locking dependency detected
 5.4.39 #55 Not tainted
 ------------------------------------------------------
 swapper/0/0 is trying to acquire lock:
 ffffffffab65b6c0 (console_owner){-...}, at: console_lock_spinning_enable+0x31/0x57

 but task is already holding lock:
 ffff88810a8e34c0 (&irq_desc_lock_class){-.-.}, at: __report_bad_irq+0x5b/0xba

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 (&irq_desc_lock_class){-.-.}:
        _raw_spin_lock_irqsave+0x61/0x8d
        __irq_get_desc_lock+0x65/0x89
        __disable_irq_nosync+0x3b/0x93
        serial8250_do_startup+0x451/0x75c
        uart_startup+0x1b4/0x2ff
        uart_port_activate+0x73/0xa0
        tty_port_open+0xae/0x10a
        uart_open+0x1b/0x26
        tty_open+0x24d/0x3a0
        chrdev_open+0xd5/0x1cc
        do_dentry_open+0x299/0x3c8
        path_openat+0x434/0x1100
        do_filp_open+0x9b/0x10a
        do_sys_open+0x15f/0x3d7
        kernel_init_freeable+0x157/0x1dd
        kernel_init+0xe/0x105
        ret_from_fork+0x27/0x50

 -> #1 (&port_lock_key){-.-.}:
        _raw_spin_lock_irqsave+0x61/0x8d
        serial8250_console_write+0xa7/0x2a0
        console_unlock+0x3b7/0x528
        vprintk_emit+0x111/0x17f
        printk+0x59/0x73
        register_console+0x336/0x3a4
        uart_add_one_port+0x51b/0x5be
        serial8250_register_8250_port+0x454/0x55e
        dw8250_probe+0x4dc/0x5b9
        platform_drv_probe+0x67/0x8b
        really_probe+0x14a/0x422
        driver_probe_device+0x66/0x130
        device_driver_attach+0x42/0x5b
        __driver_attach+0xca/0x139
        bus_for_each_dev+0x97/0xc9
        bus_add_driver+0x12b/0x228
        driver_register+0x64/0xed
        do_one_initcall+0x20c/0x4a6
        do_initcall_level+0xb5/0xc5
        do_basic_setup+0x4c/0x58
        kernel_init_freeable+0x13f/0x1dd
        kernel_init+0xe/0x105
        ret_from_fork+0x27/0x50

 -> #0 (console_owner){-...}:
        __lock_acquire+0x118d/0x2714
        lock_acquire+0x203/0x258
        console_lock_spinning_enable+0x51/0x57
        console_unlock+0x25d/0x528
        vprintk_emit+0x111/0x17f
        printk+0x59/0x73
        __report_bad_irq+0xa3/0xba
        note_interrupt+0x19a/0x1d6
        handle_irq_event_percpu+0x57/0x79
        handle_irq_event+0x36/0x55
        handle_fasteoi_irq+0xc2/0x18a
        do_IRQ+0xb3/0x157
        ret_from_intr+0x0/0x1d
        cpuidle_enter_state+0x12f/0x1fd
        cpuidle_enter+0x2e/0x3d
        do_idle+0x1ce/0x2ce
        cpu_startup_entry+0x1d/0x1f
        start_kernel+0x406/0x46a
        secondary_startup_64+0xa4/0xb0

 other info that might help us debug this:

 Chain exists of:
   console_owner --> &port_lock_key --> &irq_desc_lock_class

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&irq_desc_lock_class);
                                lock(&port_lock_key);
                                lock(&irq_desc_lock_class);
   lock(console_owner);

  *** DEADLOCK ***

 2 locks held by swapper/0/0:
  #0: ffff88810a8e34c0 (&irq_desc_lock_class){-.-.}, at: __report_bad_irq+0x5b/0xba
  #1: ffffffffab65b5c0 (console_lock){+.+.}, at: console_trylock_spinning+0x20/0x181

 stack backtrace:
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.39 #55
 Hardware name: XXXXXX
 Call Trace:
  <IRQ>
  dump_stack+0xbf/0x133
  ? print_circular_bug+0xd6/0xe9
  check_noncircular+0x1b9/0x1c3
  __lock_acquire+0x118d/0x2714
  lock_acquire+0x203/0x258
  ? console_lock_spinning_enable+0x31/0x57
  console_lock_spinning_enable+0x51/0x57
  ? console_lock_spinning_enable+0x31/0x57
  console_unlock+0x25d/0x528
  ? console_trylock+0x18/0x4e
  vprintk_emit+0x111/0x17f
  ? lock_acquire+0x203/0x258
  printk+0x59/0x73
  __report_bad_irq+0xa3/0xba
  note_interrupt+0x19a/0x1d6
  handle_irq_event_percpu+0x57/0x79
  handle_irq_event+0x36/0x55
  handle_fasteoi_irq+0xc2/0x18a
  do_IRQ+0xb3/0x157
  common_interrupt+0xf/0xf
  </IRQ>

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 09475695effd..67f1a4f31093 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2275,6 +2275,11 @@ int serial8250_do_startup(struct uart_port *port)
 
 	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
 		unsigned char iir1;
+		bool irq_shared = up->port.irqflags & IRQF_SHARED;
+
+		if (irq_shared)
+			disable_irq_nosync(port->irq);
+
 		/*
 		 * Test for UARTs that do not reassert THRE when the
 		 * transmitter is idle and the interrupt has already
@@ -2284,8 +2289,6 @@ int serial8250_do_startup(struct uart_port *port)
 		 * allow register changes to become visible.
 		 */
 		spin_lock_irqsave(&port->lock, flags);
-		if (up->port.irqflags & IRQF_SHARED)
-			disable_irq_nosync(port->irq);
 
 		wait_for_xmitr(up, UART_LSR_THRE);
 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
@@ -2297,9 +2300,9 @@ int serial8250_do_startup(struct uart_port *port)
 		iir = serial_port_in(port, UART_IIR);
 		serial_port_out(port, UART_IER, 0);
 
-		if (port->irqflags & IRQF_SHARED)
-			enable_irq(port->irq);
 		spin_unlock_irqrestore(&port->lock, flags);
+		if (irq_shared)
+			enable_irq(port->irq);
 
 		/*
 		 * If the interrupt is not reasserted, or we otherwise
-- 
2.28.0

