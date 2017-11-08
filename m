From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V1 1/1] serial: 8250_fintek: Fix crash with baud rate B0
Date: Wed,  8 Nov 2017 11:05:46 +0800
Message-ID: <1510110346-28893-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, lukas@wunner.de, rel+kernel@agilox.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ricardo.ribalda@gmail.com, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

The 8250_fintek.c is support the Fintek F81866/F81216 with dynamic clock.
But It'll generate "division by zero" exception and crash in
fintek_8250_set_termios() with baud rate 0 on baudrate_table[i] % baud.

It can be tested with following C code:

	...
	struct termios options;

	tcgetattr(fd, &options);
	...
	options.c_cflag = CS8 | CREAD; /* baud rate 0 */
	tcsetattr(fd, TCSANOW, &options);
	tcflush(fd, TCIOFLUSH);

Fixes: 195638b6d44f ("serial: 8250_fintek: UART dynamic clocksource on Fintek F81866")
Reported-by: Lukas Redlinger <rel+kernel@agilox.net>
Cc: Lukas Redlinger <rel+kernel@agilox.net>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index c41cbb52f1fe..3d66c2c0d7ee 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -312,6 +312,13 @@ void fintek_8250_set_termios(struct uart_port *port, struct ktermios *termios,
 			F81866_UART_CLK_14_769MHZ, F81866_UART_CLK_18_432MHZ,
 			F81866_UART_CLK_24MHZ };
 
+	/*
+	 * We'll use serial8250_do_set_termios() for baud = 0, otherwise It'll
+	 * crash on baudrate_table[i] % baud with "division by zero".
+	 */
+	if (!baud)
+		goto exit;
+
 	switch (pdata->pid) {
 	case CHIP_ID_F81216H:
 		reg = RS485;
@@ -324,8 +331,7 @@ void fintek_8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		dev_warn(port->dev,
 			"%s: pid: %x Not support. use default set_termios.\n",
 			__func__, pdata->pid);
-		serial8250_do_set_termios(port, termios, old);
-		return;
+		goto exit;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(baudrate_table); ++i) {
@@ -353,6 +359,7 @@ void fintek_8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		tty_termios_encode_baud_rate(termios, baud, baud);
 	}
 
+exit:
 	serial8250_do_set_termios(port, termios, old);
 }
 
-- 
2.7.4
