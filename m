From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH v3 6/6] tty: serial: msm: Remove 115.2 Kbps maximum baud rate limitation
Date: Wed, 30 Sep 2015 15:27:03 +0300
Message-ID: <1443616023-28625-7-git-send-email-ivan.ivanov@linaro.org>
References: <1443616023-28625-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443616023-28625-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <agross@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frank.rowand@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

UART controller is capable to perform transfers up to 4 Mbps.
Remove artificial 115.2 Kbps limitation.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 3efb80f511db..dcde955475dc 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -882,6 +882,7 @@ msm_find_best_baud(struct uart_port *port, unsigned int baud)
 		{    3, 0xdd,  8 },
 		{    2, 0xee, 16 },
 		{    1, 0xff, 31 },
+		{    0, 0xff, 31 },
 	};

 	divisor = uart_get_divisor(port, baud);
@@ -893,16 +894,29 @@ msm_find_best_baud(struct uart_port *port, unsigned int baud)
 	return entry; /* Default to smallest divider */
 }

-static int msm_set_baud_rate(struct uart_port *port, unsigned int baud)
+static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
+			     unsigned long *saved_flags)
 {
 	unsigned int rxstale, watermark, mask;
 	struct msm_port *msm_port = UART_TO_MSM(port);
 	const struct msm_baud_map *entry;
+	unsigned long flags;

 	entry = msm_find_best_baud(port, baud);

 	msm_write(port, entry->code, UART_CSR);

+	if (baud > 460800)
+		port->uartclk = baud * 16;
+
+	flags = *saved_flags;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	clk_set_rate(msm_port->clk, port->uartclk);
+
+	spin_lock_irqsave(&port->lock, flags);
+	*saved_flags = flags;
+
 	/* RX stale watermark */
 	rxstale = entry->rxstale;
 	watermark = UART_IPR_STALE_LSB & rxstale;
@@ -1026,8 +1040,8 @@ static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 		msm_stop_dma(port, dma);

 	/* calculate and set baud rate */
-	baud = uart_get_baud_rate(port, termios, old, 300, 115200);
-	baud = msm_set_baud_rate(port, baud);
+	baud = uart_get_baud_rate(port, termios, old, 300, 4000000);
+	baud = msm_set_baud_rate(port, baud, &flags);
 	if (tty_termios_baud_rate(termios))
 		tty_termios_encode_baud_rate(termios, baud, baud);

--
1.9.1
