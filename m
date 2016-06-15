From: Chuah Kim Tatt <kim.tatt.chuah@intel.com>
Subject: [PATCH v2 3/3] serial: 8250_mid: Read RX buffer on RX DMA timeout for DNV
Date: Wed, 15 Jun 2016 13:44:13 +0800
Message-ID: <1465969453-16198-4-git-send-email-kim.tatt.chuah@intel.com>
References: <1465969453-16198-1-git-send-email-kim.tatt.chuah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465969453-16198-1-git-send-email-kim.tatt.chuah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, kim.tatt.chuah@intel.com, linux-kernel@vger.kernel.org, jui.nee.tan@intel.com, peter@hurleysoftware.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: "Chuah, Kim Tatt" <kim.tatt.chuah@intel.com>

In DNV, when RX DMA is used and number of bytes received is less than
transfer size, only RX DMA timeout interrupt is sent. When this happens,
read the RX buffer.

Signed-off-by: Chuah, Kim Tatt <kim.tatt.chuah@intel.com>
---
 drivers/tty/serial/8250/8250_mid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index b218ff5..339de9c 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -96,6 +96,7 @@ static int tng_setup(struct mid8250 *mid, struct uart_port *p)
 static int dnv_handle_irq(struct uart_port *p)
 {
 	struct mid8250 *mid = p->private_data;
+	struct uart_8250_port *up = up_to_u8250p(p);
 	unsigned int fisr = serial_port_in(p, INTEL_MID_UART_DNV_FISR);
 	u32 status;
 	int ret = IRQ_NONE;
@@ -103,9 +104,10 @@ static int dnv_handle_irq(struct uart_port *p)
 
 	if (fisr & BIT(2)) {
 		err = hsu_dma_get_status(&mid->dma_chip, 1, &status);
-		if (err > 0)
+		if (err > 0) {
+			serial8250_rx_dma_flush(up);
 			ret |= IRQ_HANDLED;
-		else if (err == 0)
+		} else if (err == 0)
 			ret |= hsu_dma_do_irq(&mid->dma_chip, 1, status);
 	}
 	if (fisr & BIT(1)) {
-- 
1.9.1
