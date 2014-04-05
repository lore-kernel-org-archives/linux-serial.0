From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [RESEND PATCH v3 4/9] tty: xuartps: Print warning in clock notifier
Date: Fri,  4 Apr 2014 17:23:40 -0700
Message-ID: <1396657425-31029-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1396657425-31029-1-git-send-email-soren.brinkmann@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396657425-31029-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>
Cc: Peter Crosthwaite <peter.crosthwaite@xilinx.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Soren Brinkmann <soren.brinkmann@xilinx.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Print a warning if the clock notifier rejects a clock frequency change
to facilitate debugging (see:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/304329/focus=304379)

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3: None
Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 787a12064fa0..814391038abb 100644
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
1.9.1.1.gbb9f595
