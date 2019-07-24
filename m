From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] serial: 8250: Use dev_get_drvdata where possible
Date: Wed, 24 Jul 2019 21:17:58 +0800
Message-ID: <20190724131758.1764-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-serial@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/tty/serial/8250/8250_exar.c | 3 +--
 drivers/tty/serial/8250/8250_pci.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index edd6dfe055bf..03b347afd46c 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -561,8 +561,7 @@ static int __maybe_unused exar_suspend(struct device *dev)
 
 static int __maybe_unused exar_resume(struct device *dev)
 {
-	struct pci_dev *pcidev = to_pci_dev(dev);
-	struct exar8250 *priv = pci_get_drvdata(pcidev);
+	struct exar8250 *priv = dev_get_drvdata(dev);
 	unsigned int i;
 
 	for (i = 0; i < priv->nr; i++)
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 7f740b37700b..b714d8d0e161 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3859,8 +3859,7 @@ static void pciserial_remove_one(struct pci_dev *dev)
 #ifdef CONFIG_PM_SLEEP
 static int pciserial_suspend_one(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct serial_private *priv = pci_get_drvdata(pdev);
+	struct serial_private *priv = dev_get_drvdata(dev);
 
 	if (priv)
 		pciserial_suspend_ports(priv);
-- 
2.20.1
