From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PATCH] 8250: Hypervisors always export working 16550A UARTs.
Date: Thu, 28 Apr 2016 23:18:33 +0100
Message-ID: <1461881913-23967-2-git-send-email-rjones@redhat.com>
References: <1461881913-23967-1-git-send-email-rjones@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461881913-23967-1-git-send-email-rjones@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yamada.masahiro@socionext.com, matwey@sai.msu.ru, valentinrothberg@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ddutile@redhat.com
List-Id: linux-serial@vger.kernel.org

Currently autoconf spends 25ms (on my laptop) testing if the UART
exported to it by KVM is an 8250 without FIFO and/or with strange
quirks, which it obviously isn't.  Assume it is exported to us by a
hypervisor, it's a normal, working 16550A.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 drivers/tty/serial/8250/8250_port.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 00ad2637..de19924 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1171,6 +1171,13 @@ static void autoconfig(struct uart_8250_port *up)
 	if (!port->iobase && !port->mapbase && !port->membase)
 		return;
 
+	/* Hypervisors always export working 16550A devices. */
+	if (cpu_has_hypervisor) {
+		up->port.type = PORT_16550A;
+		up->capabilities |= UART_CAP_FIFO;
+		return;
+	}
+
 	DEBUG_AUTOCONF("ttyS%d: autoconf (0x%04lx, 0x%p): ",
 		       serial_index(port), port->iobase, port->membase);
 
-- 
2.7.4
