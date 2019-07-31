From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 05/23] tty: serial: fsl_lpuart: Fix bogus indentation
Date: Wed, 31 Jul 2019 10:30:27 -0700
Message-ID: <20190731173045.11718-6-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fix bogus indentation in rx_dma_timer_init().

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
 drivers/tty/serial/fsl_lpuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c60c5354a5b9..57c5825f5de7 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1409,9 +1409,9 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 
 static void rx_dma_timer_init(struct lpuart_port *sport)
 {
-		timer_setup(&sport->lpuart_timer, lpuart_timer_func, 0);
-		sport->lpuart_timer.expires = jiffies + sport->dma_rx_timeout;
-		add_timer(&sport->lpuart_timer);
+	timer_setup(&sport->lpuart_timer, lpuart_timer_func, 0);
+	sport->lpuart_timer.expires = jiffies + sport->dma_rx_timeout;
+	add_timer(&sport->lpuart_timer);
 }
 
 static int lpuart_startup(struct uart_port *port)
-- 
2.21.0
