From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/4] MIPS: enable serial UART support on PNX833X devices.
Date: Tue, 27 Jan 2009 11:50:46 +0000
Message-ID: <20090127115043.6236.66320.stgit@localhost.localdomain>
References: <20090127114820.6236.67019.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37022 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755583AbZA0Lug (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Jan 2009 06:50:36 -0500
In-Reply-To: <20090127114820.6236.67019.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

From: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>

Enabled serial UART driver for PNX833X devices.

Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Signed-off-by: Alan Cox <number6@the-village.bc.nu>
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

