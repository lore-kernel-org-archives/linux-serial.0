From: Hao Lee <haolee.swjtu@gmail.com>
Subject: [PATCH] tty: serial: 8250: Fix type field in format string
Date: Sat, 27 Apr 2019 16:00:15 +0800
Message-ID: <20190427080013.GA3624@haolee.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, haolee.swjtu@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The variable type and the type field is inconsistent.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 431e69a5a6a0..9dea11baf479 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -462,8 +462,8 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 		return -ENODEV;
 
 	dev_dbg(&dev->dev,
-		 "Setup PNP port: port %lx, mem %pa, irq %d, type %d\n",
-		 uart.port.iobase, &uart.port.mapbase,
+		 "Setup PNP port: port %#lx, mem %#lx, irq %u, type %u\n",
+		 uart.port.iobase, uart.port.mapbase,
 		 uart.port.irq, uart.port.iotype);
 
 	if (flags & CIR_PORT) {
-- 
2.14.5
