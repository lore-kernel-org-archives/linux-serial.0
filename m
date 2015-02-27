From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v2 1/1] serial: 8250_dw: Fix get_mctrl behaviour
Date: Thu, 26 Feb 2015 16:35:57 -0800
Message-ID: <1424997357-31487-2-git-send-email-jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
 <1424997357-31487-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424997357-31487-1-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Desmond Liu <desmondl@broadcom.com>
List-Id: linux-serial@vger.kernel.org

From: Desmond Liu <desmondl@broadcom.com>

Fixed behaviour of get_mctrl() serial driver function as documented in:
https://www.kernel.org/doc/Documentation/serial/driver

Added device-tree properties 'dcd-override', 'dsr-override',
'cts-override', and 'ri-override' specific to the Synopsis 8250
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
Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 .../bindings/serial/snps-dw-apb-uart.txt           |   16 ++++++++++
 drivers/tty/serial/8250/8250_dw.c                  |   32 ++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
index 7f76214..289c40e 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
@@ -21,6 +21,18 @@ Optional properties:
 - reg-io-width : the size (in bytes) of the IO accesses that should be
   performed on the device.  If this property is not present then single byte
   accesses are used.
+- dcd-override : Override the DCD modem status signal. This signal will always
+  be reported as active instead of being obtained from the modem status
+  register. Define this if your serial port does not use this pin.
+- dsr-override : Override the DTS modem status signal. This signal will always
+  be reported as active instead of being obtained from the modem status
+  register. Define this if your serial port does not use this pin.
+- cts-override : Override the CTS modem status signal. This signal will always
+  be reported as active instead of being obtained from the modem status
+  register. Define this if your serial port does not use this pin.
+- ri-override : Override the RI modem status signal. This signal will always be
+  reported as inactive instead of being obtained from the modem status register.
+  Define this if your serial port does not use this pin.
 
 Example:
 
@@ -31,6 +43,10 @@ Example:
 		interrupts = <10>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		dcd-override;
+		dsr-override;
+		cts-override;
+		ri-override;
 	};
 
 Example with one clock:
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 555de07..1f1d2e6 100644
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
 
@@ -334,6 +342,30 @@ static int dw8250_probe_of(struct uart_port *p,
 	if (id >= 0)
 		p->line = id;
 
+	if (of_property_read_bool(np, "dcd-override")) {
+		/* Always report DCD as active */
+		data->msr_mask_on |= UART_MSR_DCD;
+		data->msr_mask_off |= UART_MSR_DDCD;
+	}
+
+	if (of_property_read_bool(np, "dsr-override")) {
+		/* Always report DSR as active */
+		data->msr_mask_on |= UART_MSR_DSR;
+		data->msr_mask_off |= UART_MSR_DDSR;
+	}
+
+	if (of_property_read_bool(np, "cts-override")) {
+		/* Always report DSR as active */
+		data->msr_mask_on |= UART_MSR_DSR;
+		data->msr_mask_off |= UART_MSR_DDSR;
+	}
+
+	if (of_property_read_bool(np, "ri-override")) {
+		/* Always report Ring indicator as inactive */
+		data->msr_mask_off |= UART_MSR_RI;
+		data->msr_mask_off |= UART_MSR_TERI;
+	}
+
 	/* clock got configured through clk api, all done */
 	if (p->uartclk)
 		return 0;
-- 
1.7.9.5
