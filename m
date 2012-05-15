From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: [PATCH v2] serial: samsung: Fixed wrong comparison for baudclk_rate
Date: Tue, 15 May 2012 21:37:16 +0900
Message-ID: <000501cd3297$75fba910$61f2fb30$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46377 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758666Ab2EOMhR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 May 2012 08:37:17 -0400
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>, 'Alan Cox' <alan@linux.intel.com>, 'Kyoungil Kim' <ki0351.kim@samsung.com>, 'Jun-Ho Yoon' <junho78.yoon@samsung.com>

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
index d8b0aee..6a6a86a 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1014,10 +1014,10 @@ static int s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
 	 * a disturbance in the clock-rate over the change.
 	 */
 
-	if (IS_ERR(port->clk))
+	if (IS_ERR(port->baudclk) || port->baudclk == NULL)
 		goto exit;
 
-	if (port->baudclk_rate == clk_get_rate(port->clk))
+	if (port->baudclk_rate == clk_get_rate(port->baudclk))
 		goto exit;
 
 	if (val == CPUFREQ_PRECHANGE) {
-- 
1.7.1

