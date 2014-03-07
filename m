From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH RFC v2 02/11] tty: xuartps: Print warning in clock notifier
Date: Fri,  7 Mar 2014 11:13:25 -0800
Message-ID: <1394219614-3197-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Print a warning if the clock notifier rejects a clock frequency change
to facilitate debugging (see:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/304329/focus=304379)

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 1c6e1a68ae95..b00060052316 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -429,8 +429,10 @@ static int xuartps_clk_notifier_cb(struct notifier_block *nb,
 		 * frequency.
 		 */
 		if (!xuartps_calc_baud_divs(ndata->new_rate, xuartps->baud,
-					&bdiv, &cd, &div8))
+					&bdiv, &cd, &div8)) {
+			dev_warn(port->dev, "clock rate change rejected\n");
 			return NOTIFY_BAD;
+		}
 
 		spin_lock_irqsave(&xuartps->port->lock, flags);
 
-- 
1.9.0.1.g4196000
