From: Philippe Langlais <philippe.langlais@stericsson.com>
Subject: [PATCH] serial: fix port type conflict between NS16550A & U6_16550A
Date: Tue, 31 Aug 2010 14:19:09 +0200
Message-ID: <1283257149-3370-1-git-send-email-philippe.langlais@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:60991 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753502Ab0HaMjd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Aug 2010 08:39:33 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de, linux-serial@vger.kernel.org
Cc: linux@treblig.org, STEricsson_nomadik_linux@list.st.com, loic.pallardy@stericsson.com, vincent.guittot@stericsson.com, Philippe Langlais <philippe.langlais@stericsson.com>

Bug seen by Dr. David Alan Gilbert with sparse

Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
---
 include/linux/serial.h      |    3 +--
 include/linux/serial_core.h |    3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/serial.h b/include/linux/serial.h
index 06c99b6..c8613c3 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -77,8 +77,7 @@ struct serial_struct {
 #define PORT_16654	11
 #define PORT_16850	12
 #define PORT_RSA	13	/* RSA-DV II/S card */
-#define PORT_U6_16550A	14
-#define PORT_MAX	14
+#define PORT_MAX	13
 
 #define SERIAL_IO_PORT	0
 #define SERIAL_IO_HUB6	1
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 119354f..6513f27 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -44,7 +44,8 @@
 #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
 #define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
 #define PORT_AR7	18	/* Texas Instruments AR7 internal UART */
-#define PORT_MAX_8250	18	/* max port ID */
+#define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
+#define PORT_MAX_8250	19	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
-- 
1.7.2.2

