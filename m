From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 6/6] Serial:8250: New Port Type PORT_AMD_8250
Date: Mon, 4 Jan 2016 13:31:41 +0800
Message-ID: <1451885501-2710-7-git-send-email-annie.wang@amd.com>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Tony Li <tony.li@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

Set a new port type for AMD Carrizo.  Add has_pl330_dma to 8250_dw's
private data and init fcr,ier as well as dma rx size.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/acpi/acpi_apd.c               | 11 +++++++++++
 drivers/tty/serial/8250/8250_dw.c     | 15 +++++++++++++++
 drivers/tty/serial/8250/8250_port.c   |  9 +++++++++
 include/linux/platform_data/8250-dw.h |  8 ++++++++
 include/uapi/linux/serial_core.h      |  3 ++-
 include/uapi/linux/serial_reg.h       |  1 +
 6 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/platform_data/8250-dw.h

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 1f16cca..e8e43fb 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -23,6 +23,7 @@
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/amba/pl330.h>
+#include <linux/platform_data/8250-dw.h>
 
 #include "internal.h"
 
@@ -56,6 +57,11 @@ static struct dma_pl330_platdata amd_pl330[] = {
 		.num = 0,
 	}
 };
+
+static struct plat_dw8250_data amd_dw8250 = {
+	.has_pl330_dma = 1,
+};
+
 /**
  * struct apd_device_desc - a descriptor for apd device
  * @flags: device flags like %ACPI_APD_SYSFS, %ACPI_APD_PM
@@ -115,6 +121,11 @@ static int acpi_apd_setup_quirks(struct apd_private_data *pdata)
 	char amba_devname[100];
 	int devnum;
 
+	ret = platform_device_add_data(pdev, &amd_dw8250,
+				       sizeof(amd_dw8250));
+	if (ret)
+		goto resource_alloc_err;
+
 	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
 	if (!resource)
 		goto resource_alloc_err;
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a5d319e..e7d9f01 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -27,6 +27,7 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/pm_runtime.h>
+#include <linux/platform_data/8250-dw.h>
 
 #include <asm/byteorder.h>
 
@@ -66,6 +67,7 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+	unsigned int		has_pl330_dma:1;
 };
 
 #define BYT_PRV_CLK			0x800
@@ -303,6 +305,7 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 static void dw8250_setup_port(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
+	struct dw8250_data *data = p->private_data;
 	u32 reg;
 
 	/*
@@ -326,6 +329,14 @@ static void dw8250_setup_port(struct uart_port *p)
 		p->flags |= UPF_FIXED_TYPE;
 		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
 		up->capabilities = UART_CAP_FIFO;
+		if (data->has_pl330_dma) {
+			p->type = PORT_AMD_8250;
+
+			up->ier |= UART_IER_PTIME | UART_IER_THRI |
+				UART_IER_RLSI | UART_IER_RDI;
+			up->fcr |= UART_FCR_R_TRIG_10 | UART_FCR_T_TRIG_11;
+			up->tx_loadsz = p->fifosize / 2;
+		}
 	}
 
 	if (reg & DW_UART_CPR_AFCE_MODE)
@@ -339,6 +350,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	int irq = platform_get_irq(pdev, 0);
 	struct uart_port *p = &uart.port;
 	struct dw8250_data *data;
+	struct plat_dw8250_data *pdata = dev_get_platdata(&pdev->dev);
 	int err;
 	u32 val;
 
@@ -468,6 +480,7 @@ static int dw8250_probe(struct platform_device *pdev)
 		p->handle_irq = NULL;
 	}
 
+	data->has_pl330_dma = pdata ? pdata->has_pl330_dma : 0;
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
 
@@ -475,6 +488,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (p->fifosize) {
 		data->dma.rxconf.src_maxburst = p->fifosize / 4;
 		data->dma.txconf.dst_maxburst = p->fifosize / 4;
+		data->dma.rx_size
+			= data->has_pl330_dma ? (p->fifosize / 2 + 2) : 0;
 		uart.dma = &data->dma;
 	}
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 52d82d2..b89a326 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -269,6 +269,15 @@ configured less than Maximum supported fifo bytes */
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_AMD_8250] = {
+		.name		= "AMD_8250",
+		.fifo_size	= 256,
+		.tx_loadsz	= 128,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
+				UART_FCR_T_TRIG_11,
+		.rxtrig_bytes	= {1, 4, 8},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/linux/platform_data/8250-dw.h b/include/linux/platform_data/8250-dw.h
new file mode 100644
index 0000000..97cdb9d
--- /dev/null
+++ b/include/linux/platform_data/8250-dw.h
@@ -0,0 +1,8 @@
+#ifndef _PLATFORM_DATA_8250_DW_H
+#define _PLATFORM_DATA_8250_DW_H
+
+struct plat_dw8250_data {
+	unsigned int has_pl330_dma:1;
+};
+
+#endif
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 93ba148..89d44b0 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -56,7 +56,8 @@
 #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
 #define PORT_RT2880	29	/* Ralink RT2880 internal UART */
 #define PORT_16550A_FSL64 30	/* Freescale 16550 UART with 64 FIFOs */
-#define PORT_MAX_8250	30	/* max port ID */
+#define PORT_AMD_8250	31
+#define PORT_MAX_8250	32	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 1e5ac4e7..66686b9 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -20,6 +20,7 @@
 #define UART_RX		0	/* In:  Receive buffer */
 #define UART_TX		0	/* Out: Transmit buffer */
 
+#define UART_IER_PTIME          0x80  /* Enable Programmable Transmitter holding register int. */
 #define UART_IER	1	/* Out: Interrupt Enable Register */
 #define UART_IER_MSI		0x08 /* Enable Modem status interrupt */
 #define UART_IER_RLSI		0x04 /* Enable receiver line status interrupt */
-- 
1.9.1
