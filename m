From: maximilian attems <maks@sternwelten.at>
Subject: [patch] icom: select FW_LOADER
Date: Sat, 25 Mar 2006 15:44:11 +0100
Message-ID: <20060325144411.GD883@nancy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:2534 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S1751417AbWCYOtO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 25 Mar 2006 09:49:14 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

The icom driver uses request_firmware()
and thus needs to select FW_LOADER.

Signed-off-by: maximilian attems <maks@sternwelten.at>

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index c66ef96..d0a10fa 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -827,6 +827,7 @@ config SERIAL_ICOM
 	tristate "IBM Multiport Serial Adapter"
 	depends on PCI && (PPC_ISERIES || PPC_PSERIES)
 	select SERIAL_CORE
+	select FW_LOADER
 	help
 	  This driver is for a family of multiport serial adapters
 	  including 2 port RVX, 2 port internal modem, 4 port internal
