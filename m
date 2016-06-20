From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v9 10/11] serial: 8250_lpss: enable MSI for Intel Quark
Date: Mon, 20 Jun 2016 12:18:01 +0300
Message-ID: <1466414282-96691-11-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1466414282-96691-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466414282-96691-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Intel Quark SoC supports MSI for LPSS, in particular for UART. Enable MSI for
Intel Quark.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index cad96ee..5ac291c 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -151,6 +151,17 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	return 0;
 }
 
+static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
+{
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+
+	pci_enable_msi(pdev);
+
+	port->irq = pdev->irq;
+
+	return 0;
+}
+
 static bool lpss8250_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *dws = param;
@@ -261,6 +272,7 @@ static const struct lpss8250_board byt_board = {
 static const struct lpss8250_board qrk_board = {
 	.freq = 44236800,
 	.base_baud = 2764800,
+	.setup = qrk_serial_setup,
 };
 
 #define LPSS_DEVICE(id, board) { PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&board }
-- 
2.8.1
