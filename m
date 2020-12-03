Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9A0C63777
	for <linux-serial@archiver.kernel.org>; Thu,  3 Dec 2020 06:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9538D20665
	for <linux-serial@archiver.kernel.org>; Thu,  3 Dec 2020 06:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgLCF74 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Dec 2020 00:59:56 -0500
Received: from ozlabs.ru ([107.174.27.60]:55810 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgLCF7z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Dec 2020 00:59:55 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 67524AE80053;
        Thu,  3 Dec 2020 00:58:37 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linux-serial@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel v2] serial_core: Check for port state when tty is in error state
Date:   Thu,  3 Dec 2020 16:58:34 +1100
Message-Id: <20201203055834.45838-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

At the moment opening a serial device node (such as /dev/ttyS3)
succeeds even if there is no actual serial device behind it.
Reading/writing/ioctls fail as expected because the uart port is not
initialized (the type is PORT_UNKNOWN) and the TTY_IO_ERROR error state
bit is set fot the tty.

However setting line discipline does not have these checks
8250_port.c (8250 is the default choice made by univ8250_console_init()).
As the result of PORT_UNKNOWN, uart_port::iobase is NULL which
a platform translates onto some address accessing which produces a crash
like below.

This adds tty_port_initialized() to uart_set_ldisc() to prevent the crash.

Found by syzkaller.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* changed to tty_port_initialized() as suggested in
https://www.spinics.net/lists/linux-serial/msg39942.html (sorry for delay)

---
The example of crash on PPC64/pseries:

BUG: Unable to handle kernel data access on write at 0xc00a000000000001
Faulting instruction address: 0xc000000000c9c9cc
cpu 0x0: Vector: 300 (Data Access) at [c00000000c6d7800]
    pc: c000000000c9c9cc: io_serial_out+0xcc/0xf0
    lr: c000000000c9c9b4: io_serial_out+0xb4/0xf0
    sp: c00000000c6d7a90
   msr: 8000000000009033
   dar: c00a000000000001
 dsisr: 42000000
  current = 0xc00000000cd22500
  paca    = 0xc0000000035c0000   irqmask: 0x03   irq_happened: 0x01
    pid   = 1371, comm = syz-executor.0
Linux version 5.8.0-rc7-le-guest_syzkaller_a+fstn1 (aik@fstn1-p1) (gcc (Ubunt
untu) 2.30) #660 SMP Tue Jul 28 22:29:22 AEST 2020
enter ? for help
[c00000000c6d7a90] c0000000018a8cc0 _raw_spin_lock_irq+0xb0/0xe0 (unreliable)
[c00000000c6d7ad0] c000000000c9bdc0 serial8250_do_set_ldisc+0x140/0x180
[c00000000c6d7b10] c000000000c9bea4 serial8250_set_ldisc+0xa4/0xb0
[c00000000c6d7b50] c000000000c91138 uart_set_ldisc+0xb8/0x160
[c00000000c6d7b90] c000000000c5a22c tty_set_ldisc+0x23c/0x330
[c00000000c6d7c20] c000000000c4c220 tty_ioctl+0x990/0x12f0
[c00000000c6d7d20] c00000000056357c ksys_ioctl+0x14c/0x180
[c00000000c6d7d70] c0000000005635f0 sys_ioctl+0x40/0x60
[c00000000c6d7db0] c00000000003b814 system_call_exception+0x1a4/0x330
[c00000000c6d7e20] c00000000000d368 system_call_common+0xe8/0x214
---
 drivers/tty/serial/serial_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f41cba10b86b..828f9ad1be49 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1467,6 +1467,10 @@ static void uart_set_ldisc(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *uport;
+	struct tty_port *port = &state->port;
+
+	if (!tty_port_initialized(port))
+		return;
 
 	mutex_lock(&state->port.mutex);
 	uport = uart_port_check(state);
-- 
2.17.1

