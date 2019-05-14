From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 6/7] tty: max310x: Optionally enable rs485 on startup
Date: Tue, 14 May 2019 13:14:14 +0300
Message-ID: <20190514101415.26754-7-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

UART port might be pre-configured with rs485 enabled flag at the
time of the port starting up process. In this case we need to
have the hardware rs485-related registers initialized in accordance
with the rs485 flags and settings provided by the configs descriptor.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 2255300404bd..36943f6c198c 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1030,6 +1030,22 @@ static int max310x_startup(struct uart_port *port)
 	max310x_port_update(port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_FIFORST_BIT, 0);
 
+	/* Configure mode1/mode2 to have rs485/rs232 enabled at startup */
+	val = (clamp(port->rs485.delay_rts_before_send, 0U, 15U) << 4) |
+		clamp(port->rs485.delay_rts_after_send, 0U, 15U);
+	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, val);
+
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT);
+
+		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+			max310x_port_update(port, MAX310X_MODE2_REG,
+					    MAX310X_MODE2_ECHOSUPR_BIT,
+					    MAX310X_MODE2_ECHOSUPR_BIT);
+	}
+
 	/* Configure flow control levels */
 	/* Flow control halt level 96, resume level 48 */
 	max310x_port_write(port, MAX310X_FLOWLVL_REG,
-- 
2.21.0
