From: Hao Lee <haolee.swjtu@gmail.com>
Subject: [PATCH v3] tty: serial: 8250: Fix type field in format string
Date: Tue, 30 Apr 2019 00:24:02 +0800
Message-ID: <20190429162402.GA5086@haolee.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, haolee.swjtu@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The dev_dbg statement should print the value of uart.port.mapbase instead
of its address. Besides that, uart.port.irq and uart.port.iotype are all
unsigned types, so using %u is more appropriate.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 431e69a5a6a0..dfca33141fcc 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -462,8 +462,8 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 		return -ENODEV;
 
 	dev_dbg(&dev->dev,
-		 "Setup PNP port: port %lx, mem %pa, irq %d, type %d\n",
-		 uart.port.iobase, &uart.port.mapbase,
+		 "Setup PNP port: port %#lx, mem %#llx, irq %u, type %u\n",
+		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
 		 uart.port.irq, uart.port.iotype);
 
 	if (flags & CIR_PORT) {
-- 
2.14.5
