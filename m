Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EFCC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 29 Oct 2021 20:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7199460FF2
	for <linux-serial@archiver.kernel.org>; Fri, 29 Oct 2021 20:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhJ2URO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhJ2URO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Oct 2021 16:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635538484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q0gqxyrHyPVulA6nYMqXU4trGAxwtAAmMQuQ4H2/N14=;
        b=gKqFMPCoUuWwG8TfaOzOaMCbT/3FoY1vCMgujZSzrYQBZn2QLIEra48gezoxOWj9n2u3+L
        9aT3/L29ujT7E03+oDXVyn71z/X0QgYBmmm2tAvpw/txyYN7Vnj/AUmBbfEF1tviHM4w28
        wH9bER+pHi3nHCCu9mxPvkcDb3vCKh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401--DuaABwaM1KVdeMrBZ0j2g-1; Fri, 29 Oct 2021 16:14:43 -0400
X-MC-Unique: -DuaABwaM1KVdeMrBZ0j2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C203BA0CAB;
        Fri, 29 Oct 2021 20:14:41 +0000 (UTC)
Received: from wcosta.com (ovpn-116-176.gru2.redhat.com [10.97.116.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F8E85FC13;
        Fri, 29 Oct 2021 20:14:34 +0000 (UTC)
From:   wander@redhat.com
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tty: serial: Use fifo in 8250 console driver
Date:   Fri, 29 Oct 2021 17:14:01 -0300
Message-Id: <20211029201402.428284-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Wander Lairson Costa <wander@redhat.com>

Note: I am using a small test app + driver located at [0] for the
problem description. serco is a driver whose write function dispatches
to the serial controller. sertest is a user-mode app that writes n bytes
to the serial console using the serco driver.

While investigating a bug in the RHEL kernel, I noticed that the serial
console throughput is way below the configured speed of 115200 bps in
a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
I got 2.5KB/s.

$ time ./sertest -n 2500 /tmp/serco

real    0m0.997s
user    0m0.000s
sys     0m0.997s

With the help of the function tracer, I then noticed the serial
controller was taking around 410us seconds to dispatch one single byte:

$ trace-cmd record -p function_graph -g serial8250_console_write \
   ./sertest -n 1 /tmp/serco

$ trace-cmd report

            |  serial8250_console_write() {
 0.384 us   |    _raw_spin_lock_irqsave();
 1.836 us   |    io_serial_in();
 1.667 us   |    io_serial_out();
            |    uart_console_write() {
            |      serial8250_console_putchar() {
            |        wait_for_xmitr() {
 1.870 us   |          io_serial_in();
 2.238 us   |        }
 1.737 us   |        io_serial_out();
 4.318 us   |      }
 4.675 us   |    }
            |    wait_for_xmitr() {
 1.635 us   |      io_serial_in();
            |      __const_udelay() {
 1.125 us   |        delay_tsc();
 1.429 us   |      }
...
...
...
 1.683 us   |      io_serial_in();
            |      __const_udelay() {
 1.248 us   |        delay_tsc();
 1.486 us   |      }
 1.671 us   |      io_serial_in();
 411.342 us |    }

In another machine, I measured a throughput of 11.5KB/s, with the serial
controller taking between 80-90us to send each byte. That matches the
expected throughput for a configuration of 115200 bps.

This patch changes the serial8250_console_write to use the 16550 fifo
if available. In my benchmarks I got around 25% improvement in the slow
machine, and no performance penalty in the fast machine.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/tty/serial/8250/8250_port.c | 61 ++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 66374704747e..edf88a8338a2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2063,10 +2063,7 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	serial8250_rpm_put(up);
 }
 
-/*
- *	Wait for transmitter & holding register to empty
- */
-static void wait_for_xmitr(struct uart_8250_port *up, int bits)
+static void wait_for_lsr(struct uart_8250_port *up, int bits)
 {
 	unsigned int status, tmout = 10000;
 
@@ -2083,6 +2080,16 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 		udelay(1);
 		touch_nmi_watchdog();
 	}
+}
+
+/*
+ *	Wait for transmitter & holding register to empty
+ */
+static void wait_for_xmitr(struct uart_8250_port *up, int bits)
+{
+	unsigned int tmout;
+
+	wait_for_lsr(up, bits);
 
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
@@ -3319,6 +3326,35 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
 }
 
+/*
+ * Print a string to the serial port using the device FIFO
+ *
+ * It sends fifosize bytes and then waits for the fifo
+ * to get empty.
+ */
+static void serial8250_console_fifo_write(struct uart_8250_port *up,
+		const char *s, unsigned int count)
+{
+	int i;
+	const char *end = s + count;
+	unsigned int fifosize = up->port.fifosize;
+	bool cr_sent = false;
+
+	while (s != end) {
+		wait_for_lsr(up, UART_LSR_THRE);
+
+		for (i = 0; i < fifosize && s != end; ++i) {
+			if (*s == '\n' && !cr_sent) {
+				serial_out(up, UART_TX, '\r');
+				cr_sent = true;
+			} else {
+				serial_out(up, UART_TX, *s++);
+				cr_sent = false;
+			}
+		}
+	}
+}
+
 /*
  *	Print a string to the serial port trying not to disturb
  *	any possible real use of the port...
@@ -3334,7 +3370,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	struct uart_8250_em485 *em485 = up->em485;
 	struct uart_port *port = &up->port;
 	unsigned long flags;
-	unsigned int ier;
+	unsigned int ier, use_fifo;
 	int locked = 1;
 
 	touch_nmi_watchdog();
@@ -3366,7 +3402,20 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		mdelay(port->rs485.delay_rts_before_send);
 	}
 
-	uart_console_write(port, s, count, serial8250_console_putchar);
+	use_fifo = (up->capabilities & UART_CAP_FIFO)
+		&& port->fifosize > 1
+		&& (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO)
+		/*
+		 * After we put a data in the fifo, the controller will send
+		 * it regardless of the CTS state. Therefore, only use fifo
+		 * if we don't use control flow.
+		 */
+		&& !(up->port.flags & UPF_CONS_FLOW);
+
+	if (likely(use_fifo))
+		serial8250_console_fifo_write(up, s, count);
+	else
+		uart_console_write(port, s, count, serial8250_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
-- 
2.27.0

