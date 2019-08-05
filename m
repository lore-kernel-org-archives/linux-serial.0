From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v3 5/6] tty: serial: fsl_lpuart: Don't enable TIE in .startup() or .resume()
Date: Mon,  5 Aug 2019 11:57:00 -0700
Message-ID: <20190805185701.22863-6-andrew.smirnov@gmail.com>
References: <20190805185701.22863-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805185701.22863-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Enabling TIE in .startup() callback causes the driver to start (or at
least try) to transmit data before .start_tx() is called. Which, while
harmless (since TIE handler will immediately disable it), is a no-op
and shouldn't really happen. Drop UARTCR2_TIE from list of bits set in
lpuart_startup().

This change will also not enable TIE in .resume(), but it seems that,
similart to .startup(), transmit interrupt shouldn't be enabled there
either.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fb9961edce3a..5c3cc1051aa8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1410,7 +1410,7 @@ static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 	lpuart_setup_watermark(sport);
 
 	cr2 = readb(sport->port.membase + UARTCR2);
-	cr2 |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
+	cr2 |= UARTCR2_RIE | UARTCR2_RE | UARTCR2_TE;
 	writeb(cr2, sport->port.membase + UARTCR2);
 }
 
-- 
2.21.0
