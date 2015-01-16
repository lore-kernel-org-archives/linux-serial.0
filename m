From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 09/10] drivers: PL011: allow to supply fixed option string
Date: Fri, 16 Jan 2015 17:23:05 +0000
Message-ID: <1421428986-11300-10-git-send-email-andre.przywara@arm.com>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, arnd@arndb.de, linux-serial@vger.kernel.org, Dave Martin <dave.martin@arm.com>
List-Id: linux-serial@vger.kernel.org

The SBSA UART has a fixed baud rate and flow control setting, which
cannot be changed or queried by software.
Add a vendor specific property to always return fixed values when
trying to read the console options.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 833c399..a1c929f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -79,6 +79,7 @@ struct vendor_data {
 	bool			dma_threshold;
 	bool			cts_event_workaround;
 	bool			always_enabled;
+	char			*fixed_options;
 
 	unsigned int (*get_fifosize)(struct amba_device *dev);
 };
@@ -96,6 +97,7 @@ static struct vendor_data vendor_arm = {
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
 	.always_enabled		= false,
+	.fixed_options		= NULL,
 	.get_fifosize		= get_fifosize_arm,
 };
 
@@ -112,6 +114,7 @@ static struct vendor_data vendor_st = {
 	.dma_threshold		= true,
 	.cts_event_workaround	= true,
 	.always_enabled		= false,
+	.fixed_options		= NULL,
 	.get_fifosize		= get_fifosize_st,
 };
 
@@ -2109,6 +2112,9 @@ static int __init pl011_console_setup(struct console *co, char *options)
 
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
+	if (!options && uap->vendor->fixed_options)
+		options = uap->vendor->fixed_options;
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
-- 
1.7.9.5
