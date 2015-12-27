From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 7/9 v2] serial: 8250_pci: use to_pci_dev()
Date: Sun, 27 Dec 2015 22:29:42 +0800
Message-ID: <0754dad194ad16a45814bf3f58214702d0e6bac4.1451224485.git.geliangtang@163.com>
References: <CAHp75Vd1i4Pidw11ddMwtfvvtLk3cCuUMfg8Q8v-FPsOkbMhag@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd1i4Pidw11ddMwtfvvtLk3cCuUMfg8Q8v-FPsOkbMhag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use to_pci_dev() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v2:
 - Made it first line in this block.
---
 drivers/tty/serial/8250/8250_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4097f3f..75182c9 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1536,10 +1536,9 @@ pci_brcm_trumanage_setup(struct serial_private *priv,
 static int pci_fintek_rs485_config(struct uart_port *port,
 			       struct serial_rs485 *rs485)
 {
+	struct pci_dev *pci_dev = to_pci_dev(port->dev);
 	u8 setting;
 	u8 *index = (u8 *) port->private_data;
-	struct pci_dev *pci_dev = container_of(port->dev, struct pci_dev,
-						dev);
 
 	pci_read_config_byte(pci_dev, 0x40 + 8 * *index + 7, &setting);
 
-- 
2.5.0
