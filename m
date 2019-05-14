From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 5/7] tty: max310x: Add rx-during-tx rs485 flag support
Date: Tue, 14 May 2019 13:14:13 +0300
Message-ID: <20190514101415.26754-6-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The driver currently sets the echo suppression bit by default when rs485
is enabled. Naturally it disables any data retrieval in rs485 mode while
RTSn is pushed up. The receiver gate (RX_) can be enabled just by clearing
(or not setting) the EchoSuprs bit of mode2 register. So by setting or
clearing the bit we implement the SER_RS485_RX_DURING_TX rs485 flag
support.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ca044f96c5cc..2255300404bd 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -975,25 +975,23 @@ static void max310x_set_termios(struct uart_port *port,
 static void max310x_rs_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, rs_work);
-	unsigned int val;
+	unsigned int delay, mode1 = 0, mode2 = 0;
 
-	val = (one->port.rs485.delay_rts_before_send << 4) |
+	delay = (one->port.rs485.delay_rts_before_send << 4) |
 		one->port.rs485.delay_rts_after_send;
-	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, val);
+	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, delay);
 
 	if (one->port.rs485.flags & SER_RS485_ENABLED) {
-		max310x_port_update(&one->port, MAX310X_MODE1_REG,
-				MAX310X_MODE1_TRNSCVCTRL_BIT,
-				MAX310X_MODE1_TRNSCVCTRL_BIT);
-		max310x_port_update(&one->port, MAX310X_MODE2_REG,
-				MAX310X_MODE2_ECHOSUPR_BIT,
-				MAX310X_MODE2_ECHOSUPR_BIT);
-	} else {
-		max310x_port_update(&one->port, MAX310X_MODE1_REG,
-				MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
-		max310x_port_update(&one->port, MAX310X_MODE2_REG,
-				MAX310X_MODE2_ECHOSUPR_BIT, 0);
+		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+
+		if (!(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
+			mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
 	}
+
+	max310x_port_update(&one->port, MAX310X_MODE1_REG,
+			MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
+	max310x_port_update(&one->port, MAX310X_MODE2_REG,
+			MAX310X_MODE2_ECHOSUPR_BIT, mode2);
 }
 
 static int max310x_rs485_config(struct uart_port *port,
@@ -1005,7 +1003,8 @@ static int max310x_rs485_config(struct uart_port *port,
 	    (rs485->delay_rts_after_send > 0x0f))
 		return -ERANGE;
 
-	rs485->flags &= SER_RS485_RTS_ON_SEND | SER_RS485_ENABLED;
+	rs485->flags &= SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX |
+			SER_RS485_ENABLED;
 	memset(rs485->padding, 0, sizeof(rs485->padding));
 	port->rs485 = *rs485;
 
-- 
2.21.0
