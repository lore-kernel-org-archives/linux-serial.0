From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 17/24] tty: serial: fsl_lpuart: Drop unnecessary lpuart*_stop_tx()
Date: Mon, 29 Jul 2019 12:52:19 -0700
Message-ID: <20190729195226.8862-18-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
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
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
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
index a090b93211e3..67f196f66533 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1575,8 +1575,6 @@ static void lpuart_shutdown(struct uart_port *port)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
-
-		lpuart_stop_tx(port);
 	}
 }
 
@@ -1608,8 +1606,6 @@ static void lpuart32_shutdown(struct uart_port *port)
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_all(sport->dma_tx_chan);
 		}
-
-		lpuart32_stop_tx(port);
 	}
 }
 
-- 
2.21.0
