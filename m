From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] serial: imx: remove set but not used variable 'rtsirq'
Date: Thu, 20 Sep 2018 01:58:45 +0000
Message-ID: <1537408725-196364-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: YueHaibing <yuehaibing@huawei.com>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/tty/serial/imx.c: In function 'imx_uart_probe':
drivers/tty/serial/imx.c:2198:20: warning:
 variable 'rtsirq' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tty/serial/imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4341589..1df7d23 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2195,7 +2195,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 	int ret = 0;
 	u32 ucr1;
 	struct resource *res;
-	int txirq, rxirq, rtsirq;
+	int txirq, rxirq;
 
 	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
 	if (!sport)
@@ -2220,7 +2220,6 @@ static int imx_uart_probe(struct platform_device *pdev)
 
 	rxirq = platform_get_irq(pdev, 0);
 	txirq = platform_get_irq(pdev, 1);
-	rtsirq = platform_get_irq(pdev, 2);
 
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
