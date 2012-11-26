From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] tty/serial: fix ifx6x60.c declaration warning
Date: Mon, 26 Nov 2012 11:07:25 -0800
Message-ID: <50B3BDED.1030306@infradead.org>
References: <20121127011738.9ecd7971a7ea2e3d09a9450d@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20121127011738.9ecd7971a7ea2e3d09a9450d@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Russ Gorby <russ.gorby@intel.com>
List-Id: linux-serial@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix gcc warning of mixed data/code:

drivers/tty/serial/ifx6x60.c:516:2: warning: ISO C90 forbids mixed declarations and code

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russ Gorby <russ.gorby@intel.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/ifx6x60.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20121126.orig/drivers/tty/serial/ifx6x60.c
+++ linux-next-20121126/drivers/tty/serial/ifx6x60.c
@@ -510,10 +510,11 @@ static int ifx_spi_write(struct tty_stru
 	unsigned char *tmp_buf = (unsigned char *)buf;
 	unsigned long flags;
 	bool is_fifo_empty;
+	int tx_count;
 
 	spin_lock_irqsave(&ifx_dev->fifo_lock, flags);
 	is_fifo_empty = kfifo_is_empty(&ifx_dev->tx_fifo);
-	int tx_count = kfifo_in(&ifx_dev->tx_fifo, tmp_buf, count);
+	tx_count = kfifo_in(&ifx_dev->tx_fifo, tmp_buf, count);
 	spin_unlock_irqrestore(&ifx_dev->fifo_lock, flags);
 	if (is_fifo_empty)
 		mrdy_assert(ifx_dev);
