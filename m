From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 2/3] serial: samsung: Consider DT alias when probing ports
Date: Thu, 26 Jun 2014 13:24:34 +0200
Message-ID: <1403781875-5425-3-git-send-email-t.figa@samsung.com>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Drake <drake@endlessm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-serial@vger.kernel.org

Current driver code relies on probe order of particular samsung-uart
instances, which makes it impossible to get proper initialization of
ports when not all ports are available on board, not even saying of
deterministic device naming.

This patch fixes this on DT-enabled systems by using DT aliases for
ports as instance ID, if specified, or falling back to legacy method
otherwise to provide backwards compatibility.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/tty/serial/samsung.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c1d3ebd..a9bf024 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1275,11 +1275,18 @@ static inline struct s3c24xx_serial_drv_data *s3c24xx_get_driver_data(
 static int s3c24xx_serial_probe(struct platform_device *pdev)
 {
 	struct s3c24xx_uart_port *ourport;
+	int index = probe_index;
 	int ret;
 
-	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, probe_index);
+	if (pdev->dev.of_node) {
+		ret = of_alias_get_id(pdev->dev.of_node, "serial");
+		if (ret >= 0)
+			index = ret;
+	}
+
+	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
 
-	ourport = &s3c24xx_serial_ports[probe_index];
+	ourport = &s3c24xx_serial_ports[index];
 
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
 	if (!ourport->drv_data) {
@@ -1295,7 +1302,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 
 	ourport->port.fifosize = (ourport->info->fifosize) ?
 		ourport->info->fifosize :
-		ourport->drv_data->fifosize[probe_index];
+		ourport->drv_data->fifosize[index];
 
 	probe_index++;
 
-- 
1.9.3
