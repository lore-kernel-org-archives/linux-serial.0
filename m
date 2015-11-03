From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 11/11] tty: amba-pl011: add support for ZTE UART (EXPERIMENTAL)
Date: Tue, 03 Nov 2015 14:51:49 +0000
Message-ID: <E1Ztcw9-0007Cz-TX@rmk-PC.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151103134349.GV8644@n2100.arm.linux.org.uk>
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

Add (incomplete) support for the ZTE UART to the AMBA PL011 driver.
This is similar to the ARM and ST variants, except it has a different
register address layout, and requires 32-bit accesses to the registers.
Use the newly introduced register tables and access size support to
cope with these differences.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 23 +++++++++++++++++++++++
 include/linux/amba/serial.h     | 18 ++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8f5f82039346..373b1520083f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -171,6 +171,29 @@ static struct vendor_data vendor_st = {
 	.get_fifosize		= get_fifosize_st,
 };
 
+static const u16 pl011_zte_offsets[REG_ARRAY_SIZE] = {
+	[REG_DR] = ZX_UART011_DR,
+	[REG_FR] = ZX_UART011_FR,
+	[REG_LCRH_RX] = ZX_UART011_LCRH,
+	[REG_LCRH_TX] = ZX_UART011_LCRH,
+	[REG_IBRD] = ZX_UART011_IBRD,
+	[REG_FBRD] = ZX_UART011_FBRD,
+	[REG_CR] = ZX_UART011_CR,
+	[REG_IFLS] = ZX_UART011_IFLS,
+	[REG_IMSC] = ZX_UART011_IMSC,
+	[REG_RIS] = ZX_UART011_RIS,
+	[REG_MIS] = ZX_UART011_MIS,
+	[REG_ICR] = ZX_UART011_ICR,
+	[REG_DMACR] = ZX_UART011_DMACR,
+};
+
+static struct vendor_data vendor_zte = {
+	.reg_offset		= pl011_zte_offsets,
+	.access_32b		= true,
+	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
+	.get_fifosize		= get_fifosize_arm,
+};
+
 /* Deals with DMA transactions */
 
 struct pl011_sgbuf {
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index 0ddb5c02ad8b..d76a19ba2cff 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -65,6 +65,24 @@
 #define ST_UART011_ABCR		0x100	/* Autobaud control register. */
 #define ST_UART011_ABIMSC	0x15C	/* Autobaud interrupt mask/clear register. */
 
+/*
+ * ZTE UART register offsets.  This UART has a radically different address
+ * allocation from the ARM and ST variants, so we list all registers here.
+ * We assume unlisted registers do not exist.
+ */
+#define ZX_UART011_DR		0x04
+#define ZX_UART011_FR		0x14
+#define ZX_UART011_IBRD		0x24
+#define ZX_UART011_FBRD		0x28
+#define ZX_UART011_LCRH		0x30
+#define ZX_UART011_CR		0x34
+#define ZX_UART011_IFLS		0x38
+#define ZX_UART011_IMSC		0x40
+#define ZX_UART011_RIS		0x44
+#define ZX_UART011_MIS		0x48
+#define ZX_UART011_ICR		0x4c
+#define ZX_UART011_DMACR	0x50
+
 #define UART011_DR_OE		(1 << 11)
 #define UART011_DR_BE		(1 << 10)
 #define UART011_DR_PE		(1 << 9)
-- 
2.1.0
