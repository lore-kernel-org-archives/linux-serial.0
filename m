From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V1 1/3] serial: 8250_fintek: UART dynamic clocksource on Fintek F81866
Date: Tue,  3 Oct 2017 11:08:33 +0800
Message-ID: <1507000116-13682-2-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1507000116-13682-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507000116-13682-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: rel+kernel@agilox.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

The F81866 had 4 clocksource 1.8432/18.432/14.769/24MHz and baud rates can
be up to 1.5Mbits with 24MHz. We'll implements the dynamic clocksource in
fintek_8250_set_termios().

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index e500f7d..53ea353 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -287,6 +287,59 @@ static void fintek_8250_goto_highspeed(struct uart_8250_port *uart,
 	}
 }
 
+void fintek_8250_set_termios(struct uart_port *port, struct ktermios *termios,
+			struct ktermios *old)
+{
+	struct fintek_8250 *pdata = port->private_data;
+	unsigned int baud = tty_termios_baud_rate(termios);
+	int i;
+	static u32 baudrate_table[] = {115200, 921600, 1152000, 1500000};
+	static u8 clock_table[] = { F81866_UART_CLK_1_8432MHZ,
+			F81866_UART_CLK_14_769MHZ, F81866_UART_CLK_18_432MHZ,
+			F81866_UART_CLK_24MHZ };
+
+	for (i = 0; i < ARRAY_SIZE(baudrate_table); ++i) {
+		if (baud > baudrate_table[i] || baudrate_table[i] % baud != 0)
+			continue;
+
+		if (port->uartclk == baudrate_table[i] * 16)
+			break;
+
+		if (fintek_8250_enter_key(pdata->base_port, pdata->key))
+			continue;
+
+		port->uartclk = baudrate_table[i] * 16;
+
+		sio_write_reg(pdata, LDN, pdata->index);
+		sio_write_mask_reg(pdata, F81866_UART_CLK,
+				F81866_UART_CLK_MASK, clock_table[i]);
+
+		fintek_8250_exit_key(pdata->base_port);
+		break;
+	}
+
+	if (i == ARRAY_SIZE(baudrate_table)) {
+		baud = tty_termios_baud_rate(old);
+		tty_termios_encode_baud_rate(termios, baud, baud);
+	}
+
+	serial8250_do_set_termios(port, termios, old);
+}
+
+static void fintek_8250_set_termios_handler(struct uart_8250_port *uart)
+{
+	struct fintek_8250 *pdata = uart->port.private_data;
+
+	switch (pdata->pid) {
+	case CHIP_ID_F81866:
+		uart->port.set_termios = fintek_8250_set_termios;
+		break;
+
+	default:
+		break;
+	}
+}
+
 static int probe_setup_port(struct fintek_8250 *pdata,
 					struct uart_8250_port *uart)
 {
@@ -373,6 +426,7 @@ int fintek_8250_probe(struct uart_8250_port *uart)
 	memcpy(pdata, &probe_data, sizeof(probe_data));
 	uart->port.private_data = pdata;
 	fintek_8250_set_rs485_handler(uart);
+	fintek_8250_set_termios_handler(uart);
 
 	return 0;
 }
-- 
1.9.1
