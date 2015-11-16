From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 07/12] tty: amba-pl011: add ST register offset table
Date: Mon, 16 Nov 2015 17:40:36 +0000
Message-ID: <E1ZyNlc-0003js-K4@rmk-PC.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>
List-Id: linux-serial@vger.kernel.org

Add the ST variant register offset table to the driver.  Currently,
this is an identical copy of the standard version, but this will be
modified in the following changes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index dcc39a180222..d822c5019927 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -143,13 +143,41 @@ static struct vendor_data vendor_sbsa = {
 	.fixed_options		= true,
 };
 
+static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
+	[REG_DR] = UART01x_DR,
+	[REG_ST_DMAWM] = ST_UART011_DMAWM,
+	[REG_ST_TIMEOUT] = ST_UART011_TIMEOUT,
+	[REG_FR] = UART01x_FR,
+	[REG_ST_LCRH_RX] = ST_UART011_LCRH_RX,
+	[REG_IBRD] = UART011_IBRD,
+	[REG_FBRD] = UART011_FBRD,
+	[REG_LCRH] = UART011_LCRH,
+	[REG_ST_LCRH_TX] = ST_UART011_LCRH_TX,
+	[REG_CR] = UART011_CR,
+	[REG_IFLS] = UART011_IFLS,
+	[REG_IMSC] = UART011_IMSC,
+	[REG_RIS] = UART011_RIS,
+	[REG_MIS] = UART011_MIS,
+	[REG_ICR] = UART011_ICR,
+	[REG_DMACR] = UART011_DMACR,
+	[REG_ST_XFCR] = ST_UART011_XFCR,
+	[REG_ST_XON1] = ST_UART011_XON1,
+	[REG_ST_XON2] = ST_UART011_XON2,
+	[REG_ST_XOFF1] = ST_UART011_XOFF1,
+	[REG_ST_XOFF2] = ST_UART011_XOFF2,
+	[REG_ST_ITCR] = ST_UART011_ITCR,
+	[REG_ST_ITIP] = ST_UART011_ITIP,
+	[REG_ST_ABCR] = ST_UART011_ABCR,
+	[REG_ST_ABIMSC] = ST_UART011_ABIMSC,
+};
+
 static unsigned int get_fifosize_st(struct amba_device *dev)
 {
 	return 64;
 }
 
 static struct vendor_data vendor_st = {
-	.reg_offset		= pl011_std_offsets,
+	.reg_offset		= pl011_st_offsets,
 	.ifls			= UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
 	.lcrh_tx		= REG_ST_LCRH_TX,
 	.lcrh_rx		= REG_ST_LCRH_RX,
-- 
2.1.0
