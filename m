From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH] serial: pxa: hold port.lock when reporting modem line changes
Date: Mon, 24 Nov 2014 10:48:33 +0300
Message-ID: <1416815313-20891-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:62851 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbaKXHsv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2014 02:48:51 -0500
Received: by mail-pd0-f182.google.com with SMTP id r10so9362347pdi.27
        for <linux-serial@vger.kernel.org>; Sun, 23 Nov 2014 23:48:51 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Both uart_handle_dcd_change() and uart_handle_cts_change() require a
port lock to be held and will emit a warning when lockdep is enabled.
Held corresponding lock.

This fixes the following warnings:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at drivers/tty/serial/serial_core.c:2760 uart_handle_dcd_change+0xc8/0xf8()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.0-rc5+ #26
[<c000dff8>] (unwind_backtrace) from [<c000bc70>] (show_stack+0x10/0x14)
[<c000bc70>] (show_stack) from [<c00192ac>] (warn_slowpath_common+0x6c/0x8c)
[<c00192ac>] (warn_slowpath_common) from [<c00192e8>] (warn_slowpath_null+0x1c/0x24)
[<c00192e8>] (warn_slowpath_null) from [<c0182984>] (uart_handle_dcd_change+0xc8/0xf8)
[<c0182984>] (uart_handle_dcd_change) from [<c018625c>] (serial_pxa_irq+0x268/0x3b0)
[<c018625c>] (serial_pxa_irq) from [<c004d0d4>] (handle_irq_event_percpu+0x50/0x16c)
[<c004d0d4>] (handle_irq_event_percpu) from [<c004d22c>] (handle_irq_event+0x3c/0x5c)
[<c004d22c>] (handle_irq_event) from [<c004f7d0>] (handle_level_irq+0x94/0x118)
[<c004f7d0>] (handle_level_irq) from [<c004ca0c>] (generic_handle_irq+0x20/0x30)
[<c004ca0c>] (generic_handle_irq) from [<c004cbe0>] (__handle_domain_irq+0x38/0x70)
[<c004cbe0>] (__handle_domain_irq) from [<c00085c4>] (ichp_handle_irq+0x24/0x34)
[<c00085c4>] (ichp_handle_irq) from [<c000c7e4>] (__irq_svc+0x44/0x54)
Exception stack(0xc07c7f58 to 0xc07c7fa0)
7f40:                                                       00000001 00000001
7f60: 00000000 20000013 c07c6000 00000000 00000000 c07ce0a4 c07d7798 00000000
7f80: c07e8fb8 0000004c 00000000 c07c7fa0 c0044798 c0009f20 20000013 ffffffff
[<c000c7e4>] (__irq_svc) from [<c0009f20>] (arch_cpu_idle+0x28/0x38)
[<c0009f20>] (arch_cpu_idle) from [<c003c974>] (cpu_startup_entry+0x1b8/0x220)
[<c003c974>] (cpu_startup_entry) from [<c0338c54>] (start_kernel+0x39c/0x40c)
---[ end trace 4c1b7ae03f6d9d30 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at drivers/tty/serial/serial_core.c:2791 uart_handle_cts_change+0xa0/0xdc()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Tainted: G        W      3.18.0-rc5+ #26
[<c000dff8>] (unwind_backtrace) from [<c000bc70>] (show_stack+0x10/0x14)
[<c000bc70>] (show_stack) from [<c00192ac>] (warn_slowpath_common+0x6c/0x8c)
[<c00192ac>] (warn_slowpath_common) from [<c00192e8>] (warn_slowpath_null+0x1c/0x24)
[<c00192e8>] (warn_slowpath_null) from [<c018528c>] (uart_handle_cts_change+0xa0/0xdc)
[<c018528c>] (uart_handle_cts_change) from [<c018624c>] (serial_pxa_irq+0x258/0x3b0)
[<c018624c>] (serial_pxa_irq) from [<c004d0d4>] (handle_irq_event_percpu+0x50/0x16c)
[<c004d0d4>] (handle_irq_event_percpu) from [<c004d22c>] (handle_irq_event+0x3c/0x5c)
[<c004d22c>] (handle_irq_event) from [<c004f7d0>] (handle_level_irq+0x94/0x118)
[<c004f7d0>] (handle_level_irq) from [<c004ca0c>] (generic_handle_irq+0x20/0x30)
[<c004ca0c>] (generic_handle_irq) from [<c004cbe0>] (__handle_domain_irq+0x38/0x70)
[<c004cbe0>] (__handle_domain_irq) from [<c00085c4>] (ichp_handle_irq+0x24/0x34)
[<c00085c4>] (ichp_handle_irq) from [<c000c7e4>] (__irq_svc+0x44/0x54)
Exception stack(0xc07c7f58 to 0xc07c7fa0)
7f40:                                                       00000001 00000001
7f60: 00000000 20000013 c07c6000 00000000 00000000 c07ce0a4 c07d7798 00000000
7f80: c07e8fb8 0000004c 00000000 c07c7fa0 c0044798 c0009f20 20000013 ffffffff
[<c000c7e4>] (__irq_svc) from [<c0009f20>] (arch_cpu_idle+0x28/0x38)
[<c0009f20>] (arch_cpu_idle) from [<c003c974>] (cpu_startup_entry+0x1b8/0x220)
[<c003c974>] (cpu_startup_entry) from [<c0338c54>] (start_kernel+0x39c/0x40c)
---[ end trace 4c1b7ae03f6d9d31 ]---

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/tty/serial/pxa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 2f4c329..b59dcb1 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -223,6 +223,7 @@ static void serial_pxa_start_tx(struct uart_port *port)
 	}
 }
 
+/* should hold up->port.lock */
 static inline void check_modem_status(struct uart_pxa_port *up)
 {
 	int status;
@@ -258,7 +259,9 @@ static inline irqreturn_t serial_pxa_irq(int irq, void *dev_id)
 	lsr = serial_in(up, UART_LSR);
 	if (lsr & UART_LSR_DR)
 		receive_chars(up, &lsr);
+	spin_lock(&up->port.lock);
 	check_modem_status(up);
+	spin_unlock(&up->port.lock);
 	if (lsr & UART_LSR_THRE)
 		transmit_chars(up);
 	return IRQ_HANDLED;
-- 
2.1.1

