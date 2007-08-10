From: akpm@linux-foundation.org
Subject: [patch 4/6] serial_txx9: cleanup includes
Date: Fri, 10 Aug 2007 14:38:44 -0700
Message-ID: <200708102138.l7ALcilP010825@imap1.linux-foundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44903 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754886AbXHJVjF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Aug 2007 17:39:05 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, anemo@mba.ocn.ne.jp, ralf@linux-mips.org

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Do not include some header files already indluded by serial_core.h.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/serial/serial_txx9.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN drivers/serial/serial_txx9.c~serial_txx9-cleanup-includes drivers/serial/serial_txx9.c
--- a/drivers/serial/serial_txx9.c~serial_txx9-cleanup-includes
+++ a/drivers/serial/serial_txx9.c
@@ -25,15 +25,11 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/console.h>
-#include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/pci.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
-#include <linux/mutex.h>
 
 #include <asm/io.h>
 
_
