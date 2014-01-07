From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] serial: 8250: enable UART_BUG_NOMSR for Tegra
Date: Tue,  7 Jan 2014 15:00:12 -0700
Message-ID: <1389132012-2257-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:40728 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbaAGWAU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Jan 2014 17:00:20 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, olof@lixom.net, Stephen Warren <swarren@nvidia.com>, stable@vger.kernel.org

From: Stephen Warren <swarren@nvidia.com>

Tegra chips have 4 or 5 identical UART modules embedded. UARTs C..E have
their MODEM-control signals tied off to a static state. However UARTs A
and B can optionally route those signals to/from package pins, depending
on the exact pinmux configuration.

When these signals are not routed to package pins, false interrupts may
trigger either temporarily, or permanently, all while not showing up in
the IIR; it will read as NO_INT. This will eventually lead to the UART
IRQ being disabled due to unhandled interrupts. When this happens, the
kernel may print e.g.:

    irq 68: nobody cared (try booting with the "irqpoll" option)

In order to prevent this, enable UART_BUG_NOMSR. This prevents
UART_IER_MSI from being enabled, which prevents the false interrupts
from triggering.

In practice, this is not needed under any of the following conditions:

* On Tegra chips after Tegra30, since the HW bug has apparently been
  fixed.

* On UARTs C..E since their MODEM control signals are tied to the correct
  static state which doesn't trigger the issue.

* On UARTs A..B if the MODEM control signals are routed out to package
  pins, since they will then carry valid signals.

However, we ignore these exceptions for now, since they are only relevant
if a board actually hooks up more than a 4-wire UART, and no currently
supported board does this. If we ever support a board that does, we can
refine the algorithm that enables UART_BUG_NOMSR to take those exceptions
into account, and/or read a flag from DT/... that indicates that the
board has hooked up and pinmux'd more than a 4-wire UART.

Reported-by: Olof Johansson <olof@lixom.net> # autotester
Cc: <stable@vger.kernel.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/tty/serial/8250/8250_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e33d38cb170f..61ecd709a722 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2670,6 +2670,10 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 	if (port->type == PORT_16550A && port->iotype == UPIO_AU)
 		up->bugs |= UART_BUG_NOMSR;
 
+	/* HW bugs may trigger IRQ while IIR == NO_INT */
+	if (port->type == PORT_TEGRA)
+		up->bugs |= UART_BUG_NOMSR;
+
 	if (port->type != PORT_UNKNOWN && flags & UART_CONFIG_IRQ)
 		autoconfig_irq(up);
 
-- 
1.8.1.5

