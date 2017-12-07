From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] serial: sccnxp: Delete an error message for a failed
 memory allocation in sccnxp_probe()
Date: Thu, 7 Dec 2017 22:19:14 +0100
Message-ID: <0cc41c23-26f9-2102-7fe9-271271b0e8f5@users.sourceforge.net>
References: <90e7fa7a-c0e6-4819-9fa6-fae1a71685eb@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <90e7fa7a-c0e6-4819-9fa6-fae1a71685eb@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 7 Dec 2017 21:55:09 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/sccnxp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index d6ae3086c2a2..ba1653ba5f37 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -857,10 +857,9 @@ static int sccnxp_probe(struct platform_device *pdev)
 		return PTR_ERR(membase);
 
 	s = devm_kzalloc(&pdev->dev, sizeof(struct sccnxp_port), GFP_KERNEL);
-	if (!s) {
-		dev_err(&pdev->dev, "Error allocating port structure\n");
+	if (!s)
 		return -ENOMEM;
-	}
+
 	platform_set_drvdata(pdev, s);
 
 	spin_lock_init(&s->lock);
-- 
2.15.1
