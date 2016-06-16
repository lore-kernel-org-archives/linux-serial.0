From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] serial: mvebu-uart: free the IRQ in ->shutdown()
Date: Thu, 16 Jun 2016 16:48:52 +0200
Message-ID: <1466088532-17093-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, stable@vger.kernel.org, Ofer Heifetz <oferh@marvell.com>
List-Id: linux-serial@vger.kernel.org

As suggested by the serial port infrastructure documentation, the IRQ is
requested in ->startup(). However, it is never freed in the ->shutdown()
hook.

With simple systems that open the serial port once for all and always
have at least one process that keep the serial port opened, there was no
problem. But with a more complicated system (*cough* systemd *cough*),
the serial port is opened/closed many times, which at some point no
processes having the serial port open at all. Due to this ->startup()
gets called again, tries to request_irq() again, which fails.

Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for Armada-3700 serial port")
Cc: <stable@vger.kernel.org>
Cc: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index ce362bd..45b57c2 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -300,6 +300,8 @@ static int mvebu_uart_startup(struct uart_port *port)
 static void mvebu_uart_shutdown(struct uart_port *port)
 {
 	writel(0, port->membase + UART_CTRL);
+
+	free_irq(port->irq, port);
 }
 
 static void mvebu_uart_set_termios(struct uart_port *port,
-- 
2.7.4
