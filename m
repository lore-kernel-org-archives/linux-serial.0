From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] serial: 8250_lpss: Release Quark MSI vectors on exit
Date: Wed, 4 Jan 2017 20:36:51 +0100
Message-ID: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

No one seems to do this magically in the background, so we have to do
the job in the exit handler that corresponds to the board setup handler.

Fixes: 60a9244a5d14 ("serial: 8250_lpss: enable MSI for Intel Quark")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 58cbb30..f09f68a 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -47,7 +47,7 @@ struct lpss8250_board {
 	unsigned long freq;
 	unsigned int base_baud;
 	int (*setup)(struct lpss8250 *, struct uart_port *p);
-	void (*exit)(struct lpss8250 *);
+	void (*exit)(struct lpss8250 *, struct pci_dev *pdev);
 };
 
 struct lpss8250 {
@@ -226,9 +226,10 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	return 0;
 }
 
-static void qrk_serial_exit(struct lpss8250 *lpss)
+static void qrk_serial_exit(struct lpss8250 *lpss, struct pci_dev *pdev)
 {
 	qrk_serial_exit_dma(lpss);
+	pci_free_irq_vectors(pdev);
 }
 
 static bool lpss8250_dma_filter(struct dma_chan *chan, void *param)
@@ -324,7 +325,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_exit:
 	if (lpss->board->exit)
-		lpss->board->exit(lpss);
+		lpss->board->exit(lpss, pdev);
 	return ret;
 }
 
@@ -333,7 +334,7 @@ static void lpss8250_remove(struct pci_dev *pdev)
 	struct lpss8250 *lpss = pci_get_drvdata(pdev);
 
 	if (lpss->board->exit)
-		lpss->board->exit(lpss);
+		lpss->board->exit(lpss, pdev);
 
 	serial8250_unregister_port(lpss->line);
 }
-- 
2.1.4
