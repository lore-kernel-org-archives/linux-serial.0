From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH 1/1] serial: 8250_dw: Fix get_mctrl behaviour
Date: Wed, 25 Feb 2015 11:04:16 -0800
Message-ID: <1424891056-1222-2-git-send-email-jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
 <1424891056-1222-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424891056-1222-1-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fixed behaviour of get_mctrl() serial driver function as documented in:
https://www.kernel.org/doc/Documentation/serial/driver

Added device-tree property 'msr-override' specific to the Synopsis 8250
DesignWare UART driver. Allows one to force Data Carrier Detect,
Clear To Send, and Data Set Ready signals to permanently be reported as
active. The Ring indicator can be forced to be reported as inactive.

It is possible that if modem control signalling is enabled on a port
that doesn't have these pins (e.g. - a simple two wire Tx/Rx port), the
driver can hang indefinitely waiting for the state to change. The new
DT properties allow the driver to ignore the state of these pins on
serial ports that don't support them, as recommended in the kernel
documentation.

Reviewed-by: JD (Jiandong) Zheng <jdzheng@broadcom.com>
Reviewed-by: Jonathan Richardson <jonathar@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Tested-by: Scott Branden <sbranden@broadcom.com>
Tested-by: Jonathan Richardson <jonathar@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 .../bindings/serial/snps-dw-apb-uart.txt           |    7 ++++
 drivers/tty/serial/8250/8250_dw.c                  |   41 ++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
index 7f76214..010e52b 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
@@ -21,6 +21,12 @@ Optional properties:
 - reg-io-width : the size (in bytes) of the IO accesses that should be
   performed on the device.  If this property is not present then single byte
   accesses are used.
+- msr-override : array of strings to be used to override the individual
+  modem status signals for DCD, DSR, CTS, and RI.  If the property is not
+  present, the individual signals are obtained from the modem status register.
+  Strings accepted are "dcd", "dsr", "cts", and "ri". If "dcd", "dsr", or
+  "cts" are present, these signals will always be reported as active. If
+  "ri" is present, this signal will always be reported as inactive.
 
 Example:
 
@@ -31,6 +37,7 @@ Example:
 		interrupts = <10>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		msr-override = "dcd", "dsr", cts", "ri"
 	};
 
 Example with one clock:
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 555de07..06dc873 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -59,6 +59,8 @@ struct dw8250_data {
 	u8			usr_reg;
 	int			last_mcr;
 	int			line;
+	int			msr_mask_on;
+	int			msr_mask_off;
 	struct clk		*clk;
 	struct clk		*pclk;
 	struct reset_control	*rst;
@@ -81,6 +83,12 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 		value &= ~UART_MSR_DCTS;
 	}
 
+	/* Override any modem control signals if needed */
+	if (offset == UART_MSR) {
+		value |= d->msr_mask_on;
+		value &= ~d->msr_mask_off;
+	}
+
 	return value;
 }
 
@@ -290,6 +298,8 @@ static int dw8250_probe_of(struct uart_port *p,
 	u32			val;
 	bool has_ucv = true;
 	int id;
+	int msr_cnt, i;
+	const char *inp_name;
 
 #ifdef CONFIG_64BIT
 	if (of_device_is_compatible(np, "cavium,octeon-3860-uart")) {
@@ -334,6 +344,37 @@ static int dw8250_probe_of(struct uart_port *p,
 	if (id >= 0)
 		p->line = id;
 
+	msr_cnt = of_property_count_strings(np, "msr-override");
+
+	if (msr_cnt > 0) {
+		for (i = 0; i < msr_cnt; i++) {
+			of_property_read_string_index(np, "msr-override", i,
+				&inp_name);
+
+			if (!strcmp("dcd", inp_name)) {
+				/* Always report DCD as active */
+				data->msr_mask_on |= UART_MSR_DCD;
+				data->msr_mask_off |= UART_MSR_DDCD;
+			} else if (!strcmp("dsr", inp_name)) {
+				/* Always report DSR as active */
+				data->msr_mask_on |= UART_MSR_DSR;
+				data->msr_mask_off |= UART_MSR_DDSR;
+			} else if (!strcmp("cts", inp_name)) {
+				/* Always report CTS as active */
+				data->msr_mask_on |= UART_MSR_CTS;
+				data->msr_mask_off |= UART_MSR_DCTS;
+			} else if (!strcmp("ri", inp_name)) {
+				/* Always report Ring indicator as inactive */
+				data->msr_mask_off |= UART_MSR_RI;
+				data->msr_mask_off |= UART_MSR_TERI;
+			} else {
+				dev_err(p->dev,
+					"Ignore unknown msr-override %s\n",
+					inp_name);
+			}
+		}
+	}
+
 	/* clock got configured through clk api, all done */
 	if (p->uartclk)
 		return 0;
-- 
1.7.9.5
