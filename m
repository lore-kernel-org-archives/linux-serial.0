From: Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH] tty: serial: 8250: pass IRQ shared flag to UART ports
Date: Fri, 16 Mar 2018 12:31:58 +0100
Message-ID: <20180316113158.10298-1-kurt@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: kurt@linutronix.de, tglx@linutronix.de, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On some systems IRQ lines between multiple UARTs might be shared. If so, the
irqflags have to be configured accordingly. The reason is: The 8250 port startup
code performs IRQ tests *before* the IRQ handler for that particular port is
registered. This is performed in serial8250_do_startup(). This function checks
whether IRQF_SHARED is configured and only then disables the IRQ line while
testing.

This test is performed upon each open() of the UART device. Imagine two UARTs
share the same IRQ line: On is already opened and the IRQ is active. When the
second UART is opened, the IRQ line has to be disabled while performing IRQ
tests. Otherwise an IRQ might handler might be invoked, but the the IRQ itself
cannot be handled, because the corresponding handler isn't registered,
yet. That's because the 8250 code uses a chain-handler and invokes the
corresponding port's IRQ handling rountines himself.

Unfortunately this IRQF_SHARED flag isn't configured for UARTs probed via device
tree even if the IRQs are shared. This way, the actual and shared IRQ line isn't
disabled while performing tests and the kernel correctly detects a spurious
IRQ. So, adding this flag to the DT probe solves the issue.

Note: The UPF_SHARE_IRQ flag is configured unconditionally. Therefore, the
IRQF_SHARED flag can be set unconditionally as well.

Example stacktrace by performing echo 1 > /dev/ttyS2 on a non-patched system:

|irq 85: nobody cared (try booting with the "irqpoll" option)
| [...]
|handlers:
|[<ffff0000080fc628>] irq_default_primary_handler threaded [<ffff00000855fbb8>] serial8250_interrupt
|Disabling IRQ #85

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/tty/serial/8250/8250_of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 160b8906d9b9..575f91e04770 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -149,6 +149,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	port->uartclk = clk;
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	port->irqflags |= IRQF_SHARED;
 
 	if (of_property_read_bool(np, "no-loopback-test"))
 		port->flags |= UPF_SKIP_TEST;
-- 
2.11.0
