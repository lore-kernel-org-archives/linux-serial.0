From: Chuah Kim Tatt <kim.tatt.chuah@intel.com>
Subject: [PATCH v2 2/3] serial: 8250_dma: Export serial8250_rx_dma_flush()
Date: Wed, 15 Jun 2016 13:44:12 +0800
Message-ID: <1465969453-16198-3-git-send-email-kim.tatt.chuah@intel.com>
References: <1465969453-16198-1-git-send-email-kim.tatt.chuah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465969453-16198-1-git-send-email-kim.tatt.chuah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, kim.tatt.chuah@intel.com, linux-kernel@vger.kernel.org, jui.nee.tan@intel.com, peter@hurleysoftware.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: "Chuah, Kim Tatt" <kim.tatt.chuah@intel.com>

Export serial8250_rx_dma_flush() for use by SOC UART drivers.

Signed-off-by: Chuah, Kim Tatt <kim.tatt.chuah@intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 7f33d1c..3590d01 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -145,6 +145,7 @@ void serial8250_rx_dma_flush(struct uart_8250_port *p)
 		dmaengine_terminate_all(dma->rxchan);
 	}
 }
+EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
 
 int serial8250_request_dma(struct uart_8250_port *p)
 {
-- 
1.9.1
