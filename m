From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH V2 RESEND 1/2] serial: 8250_pci: remove non-used var for F81504
Date: Tue, 17 Mar 2015 18:02:14 +0800
Message-ID: <1426586535-6900-2-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1426586535-6900-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426586535-6900-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Remove pci_fintek_setup() non-used var with calculation ciobase

Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 892eb32..701b7b1 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1550,9 +1550,7 @@ static int pci_fintek_setup(struct serial_private *priv,
 			    struct uart_8250_port *port, int idx)
 {
 	struct pci_dev *pdev = priv->dev;
-	unsigned long base;
 	unsigned long iobase;
-	unsigned long ciobase = 0;
 	u8 config_base;
 	u32 bar_data[3];
 
@@ -1601,11 +1599,6 @@ static int pci_fintek_setup(struct serial_private *priv,
 		return -EINVAL;
 	}
 
-	if (idx < 4) {
-		base = pci_resource_start(priv->dev, 3);
-		ciobase = (int)(base + (0x8 * idx));
-	}
-
 	/* Get the io address dispatch from the BIOS */
 	pci_read_config_dword(pdev, 0x24, &bar_data[0]);
 	pci_read_config_dword(pdev, 0x20, &bar_data[1]);
@@ -1614,8 +1607,8 @@ static int pci_fintek_setup(struct serial_private *priv,
 	/* Calculate Real IO Port */
 	iobase = (bar_data[idx/4] & 0xffffffe0) + (idx % 4) * 8;
 
-	dev_dbg(&pdev->dev, "%s: idx=%d iobase=0x%lx ciobase=0x%lx config_base=0x%2x\n",
-		__func__, idx, iobase, ciobase, config_base);
+	dev_dbg(&pdev->dev, "%s: idx=%d iobase=0x%lx config_base=0x%2x\n",
+		__func__, idx, iobase, config_base);
 
 	/* Enable UART I/O port */
 	pci_write_config_byte(pdev, config_base + 0x00, 0x01);
-- 
1.9.1
