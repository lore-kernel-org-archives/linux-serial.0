From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 1/2] serial: 8250_fintek: Return -EINVAL on invalid configuration
Date: Mon,  6 Nov 2017 11:49:12 +0100
Message-ID: <20171106104913.2553-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>, Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hardware does not support having the same RTS level during RX and TX
when RS485 mode is on (URA in Fintek terminology).

The manufacturer has also confirmed that the delays are not enabled if
the RS485 mode is not enabled.

Therefore we should return -EINVAL if the user wants to have the same
value for RTS_ON_SEND and RTS_AFTER_SEND.

Cc: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index c41cbb52f1fe..ca7e96f9f080 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -201,10 +201,17 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	if (!pdata)
 		return -EINVAL;
 
-	if (rs485->flags & SER_RS485_ENABLED)
+	/* Hardware do not support same RTS level on send and receive */
+	if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
+			!(rs485->flags & SER_RS485_RTS_AFTER_SEND))
+		return -EINVAL;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
 		memset(rs485->padding, 0, sizeof(rs485->padding));
-	else
+		config |= RS485_URA;
+	} else {
 		memset(rs485, 0, sizeof(*rs485));
+	}
 
 	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
 			SER_RS485_RTS_AFTER_SEND;
@@ -219,12 +226,6 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 		config |= RXW4C_IRA;
 	}
 
-	if ((!!(rs485->flags & SER_RS485_RTS_ON_SEND)) ==
-			(!!(rs485->flags & SER_RS485_RTS_AFTER_SEND)))
-		rs485->flags &= ~SER_RS485_ENABLED;
-	else
-		config |= RS485_URA;
-
 	if (rs485->flags & SER_RS485_RTS_ON_SEND)
 		config |= RTS_INVERT;
 
-- 
2.14.2
