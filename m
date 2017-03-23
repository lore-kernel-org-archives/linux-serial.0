From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] serial: 8250_lpss: Unconditionally set PCI master for
 Quark
Date: Thu, 23 Mar 2017 09:26:42 +0100
Message-ID: <14fd4986-c03a-9ef7-a368-98eb1ea5ca7b@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

MSI needs it as well.

Should have no practical impact, though, as DMA is always available on
the Quark. But given the few users of pci_alloc_irq_vectors so far, this
incorrect pattern may spread otherwise.

Fixes: 3f3a46951e02 ("serial: 8250_lpss: set PCI master only for private DMA")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Just a repost, no code change - missed to do this with Andy's tag after
the review.

 drivers/tty/serial/8250/8250_lpss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index f3ea90f..7dddd7e 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -183,7 +183,6 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	if (ret)
 		return;
 
-	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 
 	/* Special DMA address for UART */
@@ -216,6 +215,8 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	struct pci_dev *pdev = to_pci_dev(port->dev);
 	int ret;
 
+	pci_set_master(pdev);
+
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		return ret;
