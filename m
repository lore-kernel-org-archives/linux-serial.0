From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: [PATCH 2/2] serial: samsung: Fixed wrong comparison for baudclk_rate
Date: Sun, 20 May 2012 17:49:31 +0900
Message-ID: <000101cd3665$7943b690$6bcb23b0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>, 'Alan Cox' <alan@linux.intel.com>, 'Kyoungil Kim' <ki0351.kim@samsung.com>, 'Yoon' <junho78.yoon@samsung.com>
List-Id: linux-serial@vger.kernel.org

port->baudclk_rate should be compared to the rate of port->baudclk,
because port->baudclk_rate was assigned as the rate of port->baudclk previously.
So to check that the current baudclk rate is same as previous rate,
the target of comparison sholud be the rate of port->baudclk.

Signed-off-by: Jun-Ho, Yoon <junho78.yoon@samsung.com>
Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
---
 drivers/tty/serial/samsung.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 5668538..cefdd2d 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1013,10 +1013,10 @@ static int s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
 	 * a disturbance in the clock-rate over the change.
 	 */
 
-	if (IS_ERR(port->clk))
+	if (IS_ERR(port->baudclk))
 		goto exit;
 
-	if (port->baudclk_rate == clk_get_rate(port->clk))
+	if (port->baudclk_rate == clk_get_rate(port->baudclk))
 		goto exit;
 
 	if (val == CPUFREQ_PRECHANGE) {
-- 
1.7.1
