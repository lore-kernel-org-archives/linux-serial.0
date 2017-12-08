From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] serial: sc16is7xx: Delete an error message for a failed
 memory allocation in sc16is7xx_probe()
Date: Fri, 8 Dec 2017 17:42:44 +0100
Message-ID: <0c66b1b0-e715-b4ca-9b64-4a950d62b2b8@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Dec 2017 17:27:50 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/sc16is7xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 65792a3539d0..8b3c35f77e7c 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1156,10 +1156,8 @@ static int sc16is7xx_probe(struct device *dev,
 	s = devm_kzalloc(dev, sizeof(*s) +
 			 sizeof(struct sc16is7xx_one) * devtype->nr_uart,
 			 GFP_KERNEL);
-	if (!s) {
-		dev_err(dev, "Error allocating port structure\n");
+	if (!s)
 		return -ENOMEM;
-	}
 
 	s->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(s->clk)) {
-- 
2.15.1
