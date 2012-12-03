From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] serial: sccnxp: Rename header file to match functionality
Date: Mon,  3 Dec 2012 22:23:32 +0400
Message-ID: <1354559012-21882-2-git-send-email-shc_work@mail.ru>
References: <1354559012-21882-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp22.mail.ru ([94.100.176.175]:49688 "EHLO smtp22.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab2LCSXk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Dec 2012 13:23:40 -0500
In-Reply-To: <1354559012-21882-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/mips/sni/a20r.c                               |    2 +-
 drivers/tty/serial/sccnxp.c                        |    2 +-
 .../platform_data/{sccnxp.h => serial-sccnxp.h}    |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename include/linux/platform_data/{sccnxp.h => serial-sccnxp.h} (96%)

diff --git a/arch/mips/sni/a20r.c b/arch/mips/sni/a20r.c
index 9cb9d43..e05ad4d 100644
--- a/arch/mips/sni/a20r.c
+++ b/arch/mips/sni/a20r.c
@@ -118,7 +118,7 @@ static struct resource sc26xx_rsrc[] = {
 	}
 };
 
-#include <linux/platform_data/sccnxp.h>
+#include <linux/platform_data/serial-sccnxp.h>
 
 static struct sccnxp_pdata sccnxp_data = {
 	.reg_shift	= 2,
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index ae68e8c..0c86a0b 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -25,7 +25,7 @@
 #include <linux/tty_flip.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/sccnxp.h>
+#include <linux/platform_data/serial-sccnxp.h>
 
 #define SCCNXP_NAME			"uart-sccnxp"
 #define SCCNXP_MAJOR			204
diff --git a/include/linux/platform_data/sccnxp.h b/include/linux/platform_data/serial-sccnxp.h
similarity index 96%
rename from include/linux/platform_data/sccnxp.h
rename to include/linux/platform_data/serial-sccnxp.h
index 096de90..215574d 100644
--- a/include/linux/platform_data/sccnxp.h
+++ b/include/linux/platform_data/serial-sccnxp.h
@@ -11,8 +11,8 @@
  *  (at your option) any later version.
  */
 
-#ifndef __SCCNXP_H
-#define __SCCNXP_H
+#ifndef _PLATFORM_DATA_SERIAL_SCCNXP_H_
+#define _PLATFORM_DATA_SERIAL_SCCNXP_H_
 
 #define SCCNXP_MAX_UARTS	2
 
-- 
1.7.8.6

