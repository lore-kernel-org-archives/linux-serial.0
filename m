From: Bryan Wu <bryan.wu@analog.com>
Subject: [PATCH 11/12 try #2] [Blackfin] serial driver: ADSP-BF52x
	arch/mach support
Date: Thu, 31 Jan 2008 14:47:25 +0800
Message-ID: <1201762045.7487.4.camel@roc-laptop>
References: <1201685412-29095-1-git-send-email-bryan.wu@analog.com>
	 <1201685412-29095-12-git-send-email-bryan.wu@analog.com>
	 <8bd0f97a0801301301k3951fi8dbe52ed859c9165@mail.gmail.com>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:6642 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbYAaGr2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Jan 2008 01:47:28 -0500
In-Reply-To: <8bd0f97a0801301301k3951fi8dbe52ed859c9165@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Bryan Wu <bryan.wu@analog.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

>From c7070625a67da75c62bc4ee76417bb89a96b95f6 Mon Sep 17 00:00:00 2001
From: Michael Hennerich <michael.hennerich@analog.com>
Date: Thu, 31 Jan 2008 14:44:40 +0800
Subject: [PATCH] [Blackfin] serial driver: ADSP-BF52x arch/mach support

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Cc: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <bryan.wu@analog.com>
---
 drivers/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index d7e1996..5b70d14 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -667,7 +667,7 @@ config UART0_RTS_PIN
 
 config SERIAL_BFIN_UART1
 	bool "Enable UART1"
-	depends on SERIAL_BFIN && (BF534 || BF536 || BF537 || BF54x)
+	depends on SERIAL_BFIN && (!BF531 && !BF532 && !BF533 && !BF561)
 	help
 	  Enable UART1
 
-- 
1.5.3.4

