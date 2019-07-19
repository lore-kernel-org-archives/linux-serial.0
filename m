From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] 8250_lpss: check null return when calling pci_ioremap_bar
Date: Fri, 19 Jul 2019 18:15:19 +0300
Message-ID: <20190719151519.GO9224@smile.fi.intel.com>
References: <20190719025443.2368-1-navid.emamdoost@gmail.com>
 <20190719133735.GM9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190719133735.GM9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>, Kangjie Lu <kjlu@umn.edu>, Aditya Pakki <pakki001@umn.edu>
Cc: emamd001@umn.edu, smccaman@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 19, 2019 at 04:37:35PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 18, 2019 at 09:54:42PM -0500, Navid Emamdoost wrote:

> Thus, please, collaborate guys, and send one compiling solution  based on [1].

> [1]: https://www.spinics.net/lists/linux-serial/msg33965.html

For your convenience (what has to be applied to v4):

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..6214da67e9b3 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -195,11 +195,15 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 
 static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 {
+	struct dw_dma_chip *chip = &lpss->dma_chip;
 	struct dw_dma_slave *param = &lpss->dma_param;
 
 	if (!param->dma_dev)
 		return;
-	dw_dma_remove(&lpss->dma_chip);
+
+	dw_dma_remove(chip);
+
+	pci_iounmap(to_pci_dev(chip->dev), chip->regs);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
 static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}

-- 
With Best Regards,
Andy Shevchenko
