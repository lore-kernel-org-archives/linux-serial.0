From: Peter Shih <pihsun@chromium.org>
Subject: [PATCH] tty: serial: 8250_mtk: always resume the device in probe.
Date: Tue, 27 Nov 2018 12:49:50 +0800
Message-ID: <20181127044952.45703-1-pihsun@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: pihsun@chromium.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

serial8250_register_8250_port calls uart_config_port, which calls
config_port on the port before it tries to power on the port. So we need
the port to be on before calling serial8250_register_8250_port. Change
the code to always do a runtime resume in probe before registering port,
and always do a runtime suspend in remove.

This basically reverts the change in commit 68e5fc4a255a ("tty: serial:
8250_mtk: use pm_runtime callbacks for enabling"), but still use
pm_runtime callbacks.

Fixes: 68e5fc4a255a ("tty: serial: 8250_mtk: use pm_runtime callbacks for enabling")
Signed-off-by: Peter Shih <pihsun@chromium.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index dd5e1cede2b58..c3f933d10295e 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -213,17 +213,17 @@ static int mtk8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		err = mtk8250_runtime_resume(&pdev->dev);
-		if (err)
-			return err;
-	}
+	err = mtk8250_runtime_resume(&pdev->dev);
+	if (err)
+		return err;
 
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0)
 		return data->line;
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 }
 
@@ -234,13 +234,11 @@ static int mtk8250_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	serial8250_unregister_port(data->line);
+	mtk8250_runtime_suspend(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		mtk8250_runtime_suspend(&pdev->dev);
-
 	return 0;
 }
 
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog
