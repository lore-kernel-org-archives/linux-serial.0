From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 42/75] tty: ESP has been broken for locking etc forver
Date: Fri, 02 Jan 2009 13:46:34 +0000
Message-ID: <20090102134630.13472.36924.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37593 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756933AbZABNqU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:20 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Mark it broken

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c52a167..1697043 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -190,7 +190,7 @@ config DIGIEPCA
 
 config ESPSERIAL
 	tristate "Hayes ESP serial port support"
-	depends on SERIAL_NONSTANDARD && ISA && ISA_DMA_API
+	depends on SERIAL_NONSTANDARD && ISA && ISA_DMA_API && BROKEN
 	help
 	  This is a driver which supports Hayes ESP serial ports.  Both single
 	  port cards and multiport cards are supported.  Make sure to read

