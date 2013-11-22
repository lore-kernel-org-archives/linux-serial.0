From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] TTY: amiserial, add missing platform check
Date: Fri, 22 Nov 2013 16:47:27 +0100
Message-ID: <1385135247-9068-2-git-send-email-geert@linux-m68k.org>
References: <1385135247-9068-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from jacques.telenet-ops.be ([195.130.132.50]:35871 "EHLO
	jacques.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784Ab3KVPri (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Nov 2013 10:47:38 -0500
In-Reply-To: <1385135247-9068-1-git-send-email-geert@linux-m68k.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

When booting a multi-platform m68k kernel on a non-Amiga with
"console=ttyS0" on the kernel command line, it crashes with:

Unable to handle kernel access at virtual address 81dff01c
Oops: 00000000
PC: [<001e09a8>] serial_console_write+0xc/0x70

Add the missing platform check to amiserial_console_init() to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/amiserial.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 2b86f8e0fb58..71630a2af42c 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1855,6 +1855,9 @@ static struct console sercons = {
  */
 static int __init amiserial_console_init(void)
 {
+	if (!MACH_IS_AMIGA)
+		return -ENODEV;
+
 	register_console(&sercons);
 	return 0;
 }
-- 
1.7.9.5

