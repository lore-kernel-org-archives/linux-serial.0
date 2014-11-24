From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 3/4] serial: samsung: prefer to use fifosize from driver data
Date: Mon, 24 Nov 2014 07:56:23 +0100
Message-ID: <1416812184-4496-4-git-send-email-r.baldyga@samsung.com>
References: <1416812184-4496-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1416812184-4496-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

If we have fifosize set in driver data we prefer to use it instead of default
fifosize value (which is always 16). If there is defined fifosize for particular
serial we prefer to use it, otherwise we use value from info, which is
common for all serials on given platform.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index d05c32c..8808490 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1310,11 +1310,10 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		of_property_read_u32(np,
 			"samsung,uart-fifosize", &ourport->port.fifosize);
 
-	if (!ourport->port.fifosize) {
-		ourport->port.fifosize = (ourport->info->fifosize) ?
-			ourport->info->fifosize :
-			ourport->drv_data->fifosize[index];
-	}
+	if (ourport->drv_data->fifosize[index])
+		ourport->port.fifosize = ourport->drv_data->fifosize[index];
+	else if (ourport->info->fifosize)
+		ourport->port.fifosize = ourport->info->fifosize;
 
 	probe_index++;
 
-- 
1.9.1
