From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] serial: sccnxp: Improve a size determination in
 sccnxp_probe()
Date: Thu, 7 Dec 2017 22:20:23 +0100
Message-ID: <e52a355c-1b56-dd0e-89e4-d489df5d96dc@users.sourceforge.net>
References: <90e7fa7a-c0e6-4819-9fa6-fae1a71685eb@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <90e7fa7a-c0e6-4819-9fa6-fae1a71685eb@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 7 Dec 2017 22:00:40 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/sccnxp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index ba1653ba5f37..21be1fb5fd6d 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -856,7 +856,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 	if (IS_ERR(membase))
 		return PTR_ERR(membase);
 
-	s = devm_kzalloc(&pdev->dev, sizeof(struct sccnxp_port), GFP_KERNEL);
+	s = devm_kzalloc(&pdev->dev, sizeof(*s), GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;
 
-- 
2.15.1

