From: Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 1/2] bcm63xx_uart: don't use kfree() on non kmalloced area.
Date: Sat, 30 Jan 2010 18:42:56 +0100
Message-ID: <1264873377-28479-2-git-send-email-mbizon@freebox.fr>
References: <1264873377-28479-1-git-send-email-mbizon@freebox.fr>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1264873377-28479-1-git-send-email-mbizon@freebox.fr>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/serial/bcm63xx_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/bcm63xx_uart.c b/drivers/serial/bcm63xx_uart.c
index 37ad0c4..f78ede8 100644
--- a/drivers/serial/bcm63xx_uart.c
+++ b/drivers/serial/bcm63xx_uart.c
@@ -830,7 +830,7 @@ static int __devinit bcm_uart_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(&bcm_uart_driver, port);
 	if (ret) {
-		kfree(port);
+		ports[pdev->id].membase = 0;
 		return ret;
 	}
 	platform_set_drvdata(pdev, port);
-- 
1.6.3.3
