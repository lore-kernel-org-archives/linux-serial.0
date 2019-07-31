From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 16/23] tty: serial: fsl_lpuart: Drop unnecessary lpuart*_stop_tx()
Date: Wed, 31 Jul 2019 10:30:38 -0700
Message-ID: <20190731173045.11718-17-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

By the time lpuart_shutdown() calls lpuart_stop_tx() UARTCR2_TE and
UARTCR2_TIE (which the latter will clear) are already cleared, so that
function call should effectively be a no-op. Moreso, lpuart_stop_tx()
is expected to be executed with port spinlock held, which the caller
doesn't. Given all that, drop the call to lpuart_stop_tx() in
lpuart_shutdown().

In case of lpuart32_shutdown()/lpuart32_stop_tx(), TIE won't even be
set if lpuart_dma_tx_use is true. Drop it there as well.

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
 drivers/tty/serial/fsl_lpuart.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index e59dd90fc34c..2597a877d639 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1574,8 +1574,6 @@ static void lpuart_shutdown(struct uart_port *port)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
-
-		lpuart_stop_tx(port);
 	}
 }
 
@@ -1607,8 +1605,6 @@ static void lpuart32_shutdown(struct uart_port *port)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
-
-		lpuart32_stop_tx(port);
 	}
 }
 
-- 
2.21.0
