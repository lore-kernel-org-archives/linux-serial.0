From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] TTY: pmac_zilog, check existence of ports in pmz_console_init()
Date: Fri, 22 Nov 2013 16:47:26 +0100
Message-ID: <1385135247-9068-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Finn Thain <fthain@telegraphics.com.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-serial@vger.kernel.org

When booting a multi-platform m68k kernel on a non-Mac with "console=ttyS0"
on the kernel command line, it crashes with:

Unable to handle kernel NULL pointer dereference at virtual address   (null)
Oops: 00000000
PC: [<0013ad28>] __pmz_startup+0x32/0x2a0
...
Call Trace: [<002c5d3e>] pmz_console_setup+0x64/0xe4

The normal tty driver doesn't crash, because init_pmz() checks
pmz_ports_count again after calling pmz_probe().

In the serial console initialization path, pmz_console_init() doesn't do
this, causing the driver to crash later.

Add a check for pmz_ports_count to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/tty/serial/pmac_zilog.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 481b781b26e3..e9d420ff3931 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -2052,6 +2052,9 @@ static int __init pmz_console_init(void)
 	/* Probe ports */
 	pmz_probe();
 
+	if (pmz_ports_count == 0)
+		return -ENODEV;
+
 	/* TODO: Autoprobe console based on OF */
 	/* pmz_console.index = i; */
 	register_console(&pmz_console);
-- 
1.7.9.5
