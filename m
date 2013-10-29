From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 01/19] serial: sh-sci: Enable the driver on all ARM platforms
Date: Tue, 29 Oct 2013 23:37:36 +0100
Message-ID: <1383086274-11049-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:38723 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab3J2Whf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Oct 2013 18:37:35 -0400
In-Reply-To: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
COMPILE_TEST.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index febd45c..9a5a8ef 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -709,7 +709,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on HAVE_CLK && (SUPERH || ARCH_SHMOBILE)
+	depends on HAVE_CLK && (SUPERH || ARM || COMPILE_TEST)
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
-- 
1.8.1.5

