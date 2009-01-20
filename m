From: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Subject: [PATCH] MIPS: enable serial UART support on PNX833X devices.
Date: Tue, 20 Jan 2009 17:08:45 +0200
Message-ID: <1232464125.6247.1.camel@EPBYMINW0568>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:6719 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbZATPIv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jan 2009 10:08:51 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1508618ywe.1
        for <linux-serial@vger.kernel.org>; Tue, 20 Jan 2009 07:08:50 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-serial@vger.kernel.org

Enabled serial UART driver for PNX833X devices.

Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
---
 drivers/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 3e525e3..7d7f576 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -982,7 +982,7 @@ config SERIAL_SH_SCI_CONSOLE
 
 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
-	depends on MIPS && SOC_PNX8550
+	depends on MIPS && (SOC_PNX8550 || SOC_PNX833X)
 	select SERIAL_CORE
 	help
 	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
-- 
1.5.6.3


