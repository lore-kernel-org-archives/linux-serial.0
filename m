From: akpm@linux-foundation.org
Subject: [patch 7/7] drivers/serial/68328serial.c: remove dead (ALMA_ANS | DRAGONIXVZ | M68EZ328ADS)
Date: Tue, 20 Jul 2010 15:26:54 -0700
Message-ID: <201007202226.o6KMQsmU021541@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44829 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761853Ab0GTWfC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jul 2010 18:35:02 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, siccegge@cs.fau.de, gerg@uclinux.org

From: Christoph Egger <siccegge@cs.fau.de>

(ALMA_ANS | DRAGONIXVZ | M68EZ328ADS) doesn't exist in Kconfig, therefore
remove all references to it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
Acked-by: Greg Ungerer <gerg@uclinux.org>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/serial/68328serial.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff -puN drivers/serial/68328serial.c~drivers-serial-68328serialc-remove-dead-alma_ans-dragonixvz-m68ez328ads drivers/serial/68328serial.c
--- a/drivers/serial/68328serial.c~drivers-serial-68328serialc-remove-dead-alma_ans-dragonixvz-m68ez328ads
+++ a/drivers/serial/68328serial.c
@@ -98,19 +98,13 @@ static void change_speed(struct m68k_ser
  *	Setup for console. Argument comes from the boot command line.
  */
 
-#if defined(CONFIG_M68EZ328ADS) || defined(CONFIG_ALMA_ANS) || defined(CONFIG_DRAGONIXVZ)
-#define	CONSOLE_BAUD_RATE	115200
-#define	DEFAULT_CBAUD		B115200
-#else
-	/* (es) */
-	/* note: this is messy, but it works, again, perhaps defined somewhere else?*/
-	#ifdef CONFIG_M68VZ328
-	#define CONSOLE_BAUD_RATE	19200
-	#define DEFAULT_CBAUD		B19200
-	#endif
-	/* (/es) */
+/* note: this is messy, but it works, again, perhaps defined somewhere else?*/
+#ifdef CONFIG_M68VZ328
+#define CONSOLE_BAUD_RATE	19200
+#define DEFAULT_CBAUD		B19200
 #endif
 
+
 #ifndef CONSOLE_BAUD_RATE
 #define	CONSOLE_BAUD_RATE	9600
 #define	DEFAULT_CBAUD		B9600
_
