From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] serial: pl010: constify amba_id
Date: Wed, 23 Aug 2017 22:17:58 +0530
Message-ID: <1433da5388861c046b99ac88f5cd194762b1331d.1503506635.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/serial/amba-pl010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 24180ad..9ec4b8d 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -814,7 +814,7 @@ static int pl010_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(pl010_dev_pm_ops, pl010_suspend, pl010_resume);
 
-static struct amba_id pl010_ids[] = {
+static const struct amba_id pl010_ids[] = {
 	{
 		.id	= 0x00041010,
 		.mask	= 0x000fffff,
-- 
2.7.4
