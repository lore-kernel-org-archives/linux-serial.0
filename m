From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH v2 3/6] serial: 8250/mediatek: mark PM functions as
 __maybe_unused
Date: Thu, 11 Feb 2016 16:41:29 +0100
Message-ID: <1455205297-1021302-4-git-send-email-arnd@arndb.de>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1455205297-1021302-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

The mtk8250_runtime_suspend function is not used when runtime PM is
disabled, so we get a warning about an unused function:

drivers/tty/serial/8250/8250_mtk.c:119:12: error: 'mtk8250_runtime_suspend' defined but not used [-Werror=unused-function]
 static int mtk8250_runtime_suspend(struct device *dev)

This marks all the PM functions as __maybe_unused to avoid the warning,
and removes the #ifdef around the PM_SLEEP functions for consistency.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Acked-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 78883ca64ddd..6ecc6e3e82dc 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -116,7 +116,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		tty_termios_encode_baud_rate(termios, baud, baud);
 }
 
-static int mtk8250_runtime_suspend(struct device *dev)
+static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
@@ -126,7 +126,7 @@ static int mtk8250_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int mtk8250_runtime_resume(struct device *dev)
+static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 	int err;
@@ -262,8 +262,7 @@ static int mtk8250_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mtk8250_suspend(struct device *dev)
+static int __maybe_unused mtk8250_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
@@ -272,7 +271,7 @@ static int mtk8250_suspend(struct device *dev)
 	return 0;
 }
 
-static int mtk8250_resume(struct device *dev)
+static int __maybe_unused mtk8250_resume(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
@@ -280,7 +279,6 @@ static int mtk8250_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops mtk8250_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mtk8250_suspend, mtk8250_resume)
-- 
2.7.0
