From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tty: serial: sprd: fix error return code in sprd_probe()
Date: Tue, 8 Aug 2017 17:42:46 -0500
Message-ID: <20170808224246.GA9551@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-serial@vger.kernel.org

platform_get_irq() returns an error code, but the sprd_serial driver
ignores it and always returns -ENODEV. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Also, notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/tty/serial/sprd_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index f758fe6..e902494 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -731,8 +731,8 @@ static int sprd_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "not provide irq resource\n");
-		return -ENODEV;
+		dev_err(&pdev->dev, "not provide irq resource: %d\n", irq);
+		return irq;
 	}
 	up->irq = irq;
 
-- 
2.5.0
