From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: [PATCH] serial: of-serial: fix up PM ops on no_console_suspend
Date: Thu, 9 Oct 2014 17:10:52 +0800
Message-ID: <1412845852-26157-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de, Joseph Lo <josephl@nvidia.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jingchang Lu <jingchang.lu@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Mandatorily disabling the uart clock will cause register access
hung on "no_console_suspend". This patch add condition check on
it and only disable the clock with console_suspend_enabled true.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 drivers/tty/serial/of_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 8bc2563..a765399 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -246,7 +246,7 @@ static int of_serial_suspend(struct device *dev)
 	struct of_serial_info *info = dev_get_drvdata(dev);
 
 	serial8250_suspend_port(info->line);
-	if (info->clk)
+	if (info->clk && console_suspend_enabled)
 		clk_disable_unprepare(info->clk);
 
 	return 0;
@@ -256,7 +256,7 @@ static int of_serial_resume(struct device *dev)
 {
 	struct of_serial_info *info = dev_get_drvdata(dev);
 
-	if (info->clk)
+	if (info->clk && console_suspend_enabled)
 		clk_prepare_enable(info->clk);
 
 	serial8250_resume_port(info->line);
-- 
1.8.0
