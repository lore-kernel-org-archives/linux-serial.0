From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v3 09/10] drivers: PL011: allow to supply fixed option string
Date: Thu,  9 Apr 2015 12:29:20 +0100
Message-ID: <1428578961-6896-10-git-send-email-andre.przywara@arm.com>
References: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rmk+kernel@arm.linux.org.uk, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, Dave.Martin@arm.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The SBSA UART has a fixed baud rate and flow control setting, which
cannot be changed or queried by software.
Add a vendor specific property to always return fixed values when
trying to read the console options.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 98cb889..fcb95bd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -79,6 +79,7 @@ struct vendor_data {
 	bool			dma_threshold;
 	bool			cts_event_workaround;
 	bool			always_enabled;
+	bool			fixed_options;
 
 	unsigned int (*get_fifosize)(struct amba_device *dev);
 };
@@ -96,6 +97,7 @@ static struct vendor_data vendor_arm = {
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
 	.always_enabled		= false,
+	.fixed_options		= false,
 	.get_fifosize		= get_fifosize_arm,
 };
 
@@ -112,6 +114,7 @@ static struct vendor_data vendor_st = {
 	.dma_threshold		= true,
 	.cts_event_workaround	= true,
 	.always_enabled		= false,
+	.fixed_options		= false,
 	.get_fifosize		= get_fifosize_st,
 };
 
@@ -160,6 +163,7 @@ struct uart_amba_port {
 	unsigned int		lcrh_rx;	/* vendor-specific */
 	unsigned int		old_cr;		/* state during shutdown */
 	bool			autorts;
+	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
 	char			type[12];
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
@@ -2077,10 +2081,15 @@ static int __init pl011_console_setup(struct console *co, char *options)
 
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
-	if (options)
-		uart_parse_options(options, &baud, &parity, &bits, &flow);
-	else
-		pl011_console_get_options(uap, &baud, &parity, &bits);
+	if (uap->vendor->fixed_options) {
+		baud = uap->fixed_baud;
+	} else {
+		if (options)
+			uart_parse_options(options,
+					   &baud, &parity, &bits, &flow);
+		else
+			pl011_console_get_options(uap, &baud, &parity, &bits);
+	}
 
 	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
 }
-- 
1.7.9.5
