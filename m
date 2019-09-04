From: =?UTF-8?q?Christoph=20Vogtl=C3=A4nder?=
        <c.vogtlaender@sigma-surface-science.com>
Subject: [PATCH] serial: max310x: turn off transmitter before activating AutoCTS or auto transmitter flow control
Date: Wed,  4 Sep 2019 14:17:46 +0200
Message-ID: <20190904121746.4641-1-c.vogtlaender@sigma-surface-science.com>
References: <20190904073022.GB9729@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904073022.GB9729@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: =?UTF-8?q?Christoph=20Vogtl=C3=A4nder?= <c.vogtlaender@sigma-surface-science.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

As documented in the data-sheet, the transmitter must be disabled before
activating AutoCTS or auto transmitter flow control. Accordingly, the
transmitter must be enabled after AutoCTS or auto transmitter flow
control gets deactivated.

Signed-off-by: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>
---
 drivers/tty/serial/max310x.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index fb5a7e0e58e9..adfef6dae4a7 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -860,6 +860,15 @@ static void max310x_set_termios(struct uart_port *port,
 	max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
 	max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
 
+	/* Disable transmitter before enabling AutoCTS or auto transmitter
+	 * flow control
+	 */
+	if (termios->c_cflag & CRTSCTS || termios->c_iflag & IXOFF) {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TXDIS_BIT,
+				    MAX310X_MODE1_TXDIS_BIT);
+	}
+
 	port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
 
 	if (termios->c_cflag & CRTSCTS) {
@@ -878,6 +887,15 @@ static void max310x_set_termios(struct uart_port *port,
 	}
 	max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);
 
+	/* Enable transmitter after disabling AutoCTS and auto transmitter
+	 * flow control
+	 */
+	if (!(termios->c_cflag & CRTSCTS) && !(termios->c_iflag & IXOFF)) {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TXDIS_BIT,
+				    0);
+	}
+
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / 0xffff,
-- 
2.22.1
