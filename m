From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] serial8250-em: Add DT support
Date: Wed, 09 May 2012 15:55:14 +0900
Message-ID: <20120509065514.18528.83245.sendpatchset@w520>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: horms@verge.net.au, arnd@arndb.de, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, paul.gortmaker@windriver.com, lethal@linux-sh.org, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>, dan.j.williams@intel.com, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the 8250_em driver to support DT.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies of top of "[PATCH] serial8250-em: Emma Mobile UART driver V2"
 (included in linux-next 20120508) and the recently posted
 "[PATCH] serial8250-em: clk_get() IS_ERR() error handling fix".

 drivers/tty/serial/8250/8250_em.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0002/drivers/tty/serial/8250/8250_em.c
+++ work/drivers/tty/serial/8250/8250_em.c	2012-05-09 15:39:22.000000000 +0900
@@ -163,9 +163,16 @@ static int __devexit serial8250_em_remov
 	return 0;
 }
 
+static const struct of_device_id serial8250_em_dt_ids[] __devinitconst = {
+	{ .compatible = "renesas,em-uart", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, serial8250_em_dt_ids);
+
 static struct platform_driver serial8250_em_platform_driver = {
 	.driver = {
 		.name		= "serial8250-em",
+		.of_match_table = serial8250_em_dt_ids,
 		.owner		= THIS_MODULE,
 	},
 	.probe			= serial8250_em_probe,
