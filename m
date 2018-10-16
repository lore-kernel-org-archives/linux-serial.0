From: <shubhrajyoti.datta@gmail.com>
Subject: [LINUX PATCHv3 5/9] serial-uartlite: Fix the unbind path
Date: Tue, 16 Oct 2018 15:48:04 +0530
Message-ID: <1539685088-13465-6-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, jacmet@sunsite.dk, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Currently the clocks are not enabled at probe but when the port is used.
Remove the unconditional disable at remove.

Fixes the below
[   77.660196] ------------[ cut here ]------------
[   77.664749] WARNING: CPU: 0 PID: 1992 at drivers/clk/clk.c:622
clk_core_disable+0x78/0x80
[   77.672892] Modules linked in:
[   77.675930] CPU: 0 PID: 1992 Comm: sh Not tainted 4.14.0 #23
[   77.681570] Hardware name: xlnx,zynqmp (DT)
[   77.685736] task: ffffffc879e2e580 task.stack: ffffff800be30000
[   77.691641] PC is at clk_core_disable+0x78/0x80

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 58296eb..4a7989d 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -857,7 +857,7 @@ static int ulite_remove(struct platform_device *pdev)
 	struct uartlite_data *pdata = port->private_data;
 	int rc;
 
-	clk_disable_unprepare(pdata->clk);
+	clk_unprepare(pdata->clk);
 	rc = ulite_release(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.1.1
