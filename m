From: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Subject: [PATCH] MIPS: enable serial UART support on PNX833X devices.
Date: Thu, 15 Jan 2009 03:26:38 +0200
Message-ID: <fce2a370901141726p520c6b2aw7c6e69e11c923b25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:47093 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZAOBcZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Jan 2009 20:32:25 -0500
Received: by bwz14 with SMTP id 14so2717992bwz.13
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2009 17:32:23 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk

pnx833x_uart driver works good for PNX833X boards too.
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
