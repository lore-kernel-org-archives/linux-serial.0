From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] serial8250-em: clk_get() IS_ERR() error handling fix
Date: Wed, 09 May 2012 15:49:57 +0900
Message-ID: <20120509064957.18494.11270.sendpatchset@w520>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: horms@verge.net.au, arnd@arndb.de, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, paul.gortmaker@windriver.com, lethal@linux-sh.org, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>, dan.j.williams@intel.com, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the 8250_em driver to correctly handle the case
where no clock is associated with the device.

The return value of clk_get() needs to be checked with
IS_ERR() to avoid NULL pointer referencing.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies of top of "[PATCH] serial8250-em: Emma Mobile UART driver V2"
 included in linux-next 20120508.

 drivers/tty/serial/8250/8250_em.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/drivers/tty/serial/8250/8250_em.c
+++ work/drivers/tty/serial/8250/8250_em.c	2012-05-09 15:35:10.000000000 +0900
@@ -110,8 +110,9 @@ static int __devinit serial8250_em_probe
 	}
 
 	priv->sclk = clk_get(&pdev->dev, "sclk");
-	if (!priv->sclk) {
+	if (IS_ERR(priv->sclk)) {
 		dev_err(&pdev->dev, "unable to get clock\n");
+		ret = PTR_ERR(priv->sclk);
 		goto err1;
 	}
 
