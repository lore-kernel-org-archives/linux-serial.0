From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/2] tty: serial: ralink: select SERIAL_8250_RT288X when ralink kernel is built
Date: Sat, 13 Apr 2013 11:39:33 +0200
Message-ID: <1365845973-16164-2-git-send-email-blogic@openwrt.org>
References: <1365845973-16164-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:39565 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461Ab3DMJng (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Apr 2013 05:43:36 -0400
In-Reply-To: <1365845973-16164-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, John Crispin <blogic@openwrt.org>

We need to select SERIAL_8250_RT288X to make the uart work on ralink SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b237c50..da9fd66 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -444,6 +444,7 @@ config RALINK
 	select HAVE_MACH_CLKDEV
 	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
+	select SERIAL_8250_RT288X
 
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
-- 
1.7.10.4

