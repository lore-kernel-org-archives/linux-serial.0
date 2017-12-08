From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/4] serial: pch_uart: Delete an unnecessary return statement
 in two functions
Date: Fri, 8 Dec 2017 19:11:42 +0100
Message-ID: <c7f7776b-87cc-fcff-f404-2446ca4357e0@users.sourceforge.net>
References: <f8220e08-da4c-65d6-ecc7-9405cab6f375@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <f8220e08-da4c-65d6-ecc7-9405cab6f375@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Dec 2017 18:48:10 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/pch_uart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 53cdf23b83c6..790a7aae331f 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -693,8 +693,6 @@ static void pch_free_dma(struct uart_port *port)
 		priv->rx_buf_virt = NULL;
 		priv->rx_buf_dma = 0;
 	}
-
-	return;
 }
 
 static bool filter(struct dma_chan *chan, void *slave)
@@ -1861,8 +1859,8 @@ static void pch_uart_pci_remove(struct pci_dev *pdev)
 	pch_uart_exit_port(priv);
 	pci_disable_device(pdev);
 	kfree(priv);
-	return;
 }
+
 #ifdef CONFIG_PM
 static int pch_uart_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
-- 
2.15.1

