From: John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 2/2] tty: serial: ralink: select SERIAL_8250_RT288X when ralink kernel is built
Date: Sat, 13 Apr 2013 13:42:16 +0200
Message-ID: <1365853336-11241-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:44424 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824Ab3DMLqX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Apr 2013 07:46:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, John Crispin <blogic@openwrt.org>

We need to select SERIAL_8250_RT288X to make the uart work on ralink SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
Changes in V2
* a bogus rebase broke the patch and added the extra select to the wrong platform

 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c1997db..2e8939f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -441,6 +441,7 @@ config RALINK
 	select SYS_HAS_EARLY_PRINTK
 	select HAVE_MACH_CLKDEV
 	select CLKDEV_LOOKUP
+	select SERIAL_8250_RT288X
 
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
-- 
1.7.10.4

