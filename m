From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 7/9] serial: 8250_pci: use to_pci_dev()
Date: Sun, 27 Dec 2015 18:46:03 +0800
Message-ID: <a19679a63f1b53f130a34c43db5bb9e739ee4923.1451211133.git.geliangtang@163.com>
References: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
In-Reply-To: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
References: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use to_pci_dev() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/tty/serial/8250/8250_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4097f3f..afdd2c67 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1538,8 +1538,7 @@ static int pci_fintek_rs485_config(struct uart_port *port,
 {
 	u8 setting;
 	u8 *index = (u8 *) port->private_data;
-	struct pci_dev *pci_dev = container_of(port->dev, struct pci_dev,
-						dev);
+	struct pci_dev *pci_dev = to_pci_dev(port->dev);
 
 	pci_read_config_byte(pci_dev, 0x40 + 8 * *index + 7, &setting);
 
-- 
2.5.0
