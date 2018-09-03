From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v3 02/10] serial: uartps: Do not initialize field to zero again
Date: Mon,  3 Sep 2018 15:10:50 +0200
Message-ID: <bf45db771f1f4b5bf9a006c3a1d8016bebc53df1.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Writing zero and NULLs to already initialized fields is not needed.
Remove this additional writes.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3: None
Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index dd905c981f67..9a08542cec47 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1502,15 +1502,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
 
 	/* At this point, we've got an empty uart_port struct, initialize it */
 	spin_lock_init(&port->lock);
-	port->membase	= NULL;
-	port->irq	= 0;
 	port->type	= PORT_UNKNOWN;
 	port->iotype	= UPIO_MEM32;
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &cdns_uart_ops;
 	port->fifosize	= CDNS_UART_FIFO_SIZE;
 	port->line	= id;
-	port->dev	= NULL;
 
 	/*
 	 * Register the port.
-- 
1.9.1
