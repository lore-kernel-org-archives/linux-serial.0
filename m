From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH V2 01/14] Serial: Enable build of sc26xx driver for embedded
	platforms
Date: Thu, 25 Feb 2010 14:34:55 +0100
Message-ID: <20100225133455.12331.5073.stgit@srv002.fuzzey.net>
References: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f212.google.com ([209.85.219.212]:34503 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526Ab0BYNfA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 08:35:00 -0500
Received: by ewy4 with SMTP id 4so1510191ewy.28
        for <linux-serial@vger.kernel.org>; Thu, 25 Feb 2010 05:34:57 -0800 (PST)
In-Reply-To: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, tsbogend@alpha.franken.de

Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9ff47db..10bd461 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1395,7 +1395,7 @@ config SERIAL_QE
 
 config SERIAL_SC26XX
 	tristate "SC2681/SC2692 serial port support"
-	depends on SNI_RM
+	depends on SNI_RM || EMBEDDED
 	select SERIAL_CORE
 	help
 	  This is a driver for the onboard serial ports of

