From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Remove redundant instances of EARLYCON_DECLARE()
Date: Mon, 15 Feb 2016 13:36:32 +0100
Message-ID: <1455539792-23140-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

As of commit 2eaa790989e03900 ("earlycon: Use common framework for
earlycon declarations") it is no longer needer to specify both
EARLYCON_DECLARE() and OF_EARLYCON_DECLARE().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4678d8f2dd7d1da5..0130feb069aee02f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3071,15 +3071,10 @@ static int __init hscif_early_console_setup(struct earlycon_device *device,
 	return early_console_setup(device, PORT_HSCIF);
 }
 
-EARLYCON_DECLARE(sci, sci_early_console_setup);
 OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
-EARLYCON_DECLARE(scif, scif_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
-EARLYCON_DECLARE(scifa, scifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
-EARLYCON_DECLARE(scifb, scifb_early_console_setup);
 OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
-EARLYCON_DECLARE(hscif, hscif_early_console_setup);
 OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
 #endif /* CONFIG_SERIAL_SH_SCI_EARLYCON */
 
-- 
1.9.1

