From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] timberdale: Remove dependancies
Date: Wed, 17 Feb 2010 12:58:23 +0000
Message-ID: <20100217125816.15111.51287.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36281 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932183Ab0BQNWW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Feb 2010 08:22:22 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

MFD_TIMBERDALE doesn't appear to be defined anywhere. However the code in
question can build happily without platform specifics so remove the check

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/serial/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)


diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 77e7f7e..eea6ea4 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1466,7 +1466,6 @@ config SERIAL_BFIN_SPORT3_UART
 
 config SERIAL_TIMBERDALE
 	tristate "Support for timberdale UART"
-	depends on MFD_TIMBERDALE
 	select SERIAL_CORE
 	---help---
 	Add support for UART controller on timberdale.

