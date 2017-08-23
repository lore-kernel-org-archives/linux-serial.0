From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] serial: pl011: constify amba_id
Date: Wed, 23 Aug 2017 22:18:21 +0530
Message-ID: <1829e361f24859cf52b83163d5b551a0cabd3e55.1503506635.git.arvind.yadav.cs@gmail.com>
References: <1433da5388861c046b99ac88f5cd194762b1331d.1503506635.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433da5388861c046b99ac88f5cd194762b1331d.1503506635.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1888d16..b644fc7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2787,7 +2787,7 @@ static struct platform_driver arm_sbsa_uart_platform_driver = {
 	},
 };
 
-static struct amba_id pl011_ids[] = {
+static const struct amba_id pl011_ids[] = {
 	{
 		.id	= 0x00041011,
 		.mask	= 0x000fffff,
-- 
2.7.4
