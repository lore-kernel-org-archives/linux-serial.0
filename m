From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/79] serial:blackfin: rename Blackfin serial driver to bfin_uart.c
Date: Wed, 26 Oct 2011 14:12:15 +0200
Message-ID: <1319631204-23262-10-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60932 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751Ab1JZMNc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:32 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Sonic Zhang <sonic.zhang@analog.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Sonic Zhang <sonic.zhang@analog.com>

bfin_5xx.c is not a general name for all Blackfin chips.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/Kconfig                     |    2 +-
 drivers/tty/serial/Makefile                    |    2 +-
 drivers/tty/serial/{bfin_5xx.c => bfin_uart.c} |    0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/tty/serial/{bfin_5xx.c => bfin_uart.c} (100%)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4dcb37b..a9b307f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -722,7 +722,7 @@ config SERIAL_BFIN
 	  Add support for the built-in UARTs on the Blackfin.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_5xx.
+	  module is named bfin_uart.ko.
 
 config SERIAL_BFIN_CONSOLE
 	bool "Console on Blackfin serial port"
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 83b4da6..7874813 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_SERIAL_PXA) += pxa.o
 obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
 obj-$(CONFIG_SERIAL_BCM63XX) += bcm63xx_uart.o
-obj-$(CONFIG_SERIAL_BFIN) += bfin_5xx.o
+obj-$(CONFIG_SERIAL_BFIN) += bfin_uart.o
 obj-$(CONFIG_SERIAL_BFIN_SPORT) += bfin_sport_uart.o
 obj-$(CONFIG_SERIAL_SAMSUNG) += samsung.o
 obj-$(CONFIG_SERIAL_S3C2410) += s3c2410.o
diff --git a/drivers/tty/serial/bfin_5xx.c b/drivers/tty/serial/bfin_uart.c
similarity index 100%
rename from drivers/tty/serial/bfin_5xx.c
rename to drivers/tty/serial/bfin_uart.c
-- 
1.7.7

