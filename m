From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 25/76] serial: ifx6x60: minor cleanup
Date: Wed, 16 Mar 2011 14:11:55 -0700
Message-ID: <1300309966-5745-25-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32833 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754810Ab1CPVNn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:43 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russ Gorby <russ.gorby@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Russ Gorby <russ.gorby@intel.com>

renamed spi_driver variable to not be h/w specific
set driver name to use DRVNAME define
removed commented-out define

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/ifx6x60.c |    8 ++++----
 drivers/tty/serial/ifx6x60.h |    2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 59e9cb8..b68b96f 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1333,9 +1333,9 @@ static const struct spi_device_id ifx_id_table[] = {
 MODULE_DEVICE_TABLE(spi, ifx_id_table);
 
 /* spi operations */
-static const struct spi_driver ifx_spi_driver_6160 = {
+static const struct spi_driver ifx_spi_driver = {
 	.driver = {
-		.name = "ifx6160",
+		.name = DRVNAME,
 		.bus = &spi_bus_type,
 		.pm = &ifx_spi_pm,
 		.owner = THIS_MODULE},
@@ -1357,7 +1357,7 @@ static void __exit ifx_spi_exit(void)
 {
 	/* unregister */
 	tty_unregister_driver(tty_drv);
-	spi_unregister_driver((void *)&ifx_spi_driver_6160);
+	spi_unregister_driver((void *)&ifx_spi_driver);
 }
 
 /**
@@ -1399,7 +1399,7 @@ static int __init ifx_spi_init(void)
 		return result;
 	}
 
-	result = spi_register_driver((void *)&ifx_spi_driver_6160);
+	result = spi_register_driver((void *)&ifx_spi_driver);
 	if (result) {
 		pr_err("%s: spi_register_driver failed(%d)",
 			DRVNAME, result);
diff --git a/drivers/tty/serial/ifx6x60.h b/drivers/tty/serial/ifx6x60.h
index 0ec39b5..e8464ba 100644
--- a/drivers/tty/serial/ifx6x60.h
+++ b/drivers/tty/serial/ifx6x60.h
@@ -29,8 +29,6 @@
 #define DRVNAME				"ifx6x60"
 #define TTYNAME				"ttyIFX"
 
-/* #define IFX_THROTTLE_CODE */
-
 #define IFX_SPI_MAX_MINORS		1
 #define IFX_SPI_TRANSFER_SIZE		2048
 #define IFX_SPI_FIFO_SIZE		4096
-- 
1.7.4.1

