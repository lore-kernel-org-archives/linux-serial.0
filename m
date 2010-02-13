From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH 01/12] Serial: Enable build of sc26xx driver for embedded
	platforms
Date: Sat, 13 Feb 2010 17:09:52 +0100
Message-ID: <20100213160952.22311.23313.stgit@srv002.fuzzey.net>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45000 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab0BMQJz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:09:55 -0500
Received: by ewy28 with SMTP id 28so2648139ewy.28
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:09:54 -0800 (PST)
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de



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

