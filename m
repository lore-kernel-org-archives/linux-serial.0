From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 09/13] serial: sh-sci: Don't set SCLSR bits in the SCxSR error mask
Date: Thu, 30 Apr 2015 18:21:33 +0200
Message-ID: <1430410897-12770-10-git-send-email-geert+renesas@glider.be>
References: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430410897-12770-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

error_mask is the union of all error indicating bits in the SCxSR
register, while overrun_mask may apply to a different register (SCLSR),
depending on the SCI variant.

Hence overrun_mask should only be ORed into error_mask if it applies to
the SCxSR register.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b636c53a1e5b3866..c3e884dd925f43a4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2323,7 +2323,8 @@ static int sci_init_single(struct platform_device *dev,
 	 * Make the error mask inclusive of overrun detection, if
 	 * supported.
 	 */
-	sci_port->error_mask |= sci_port->overrun_mask;
+	if (sci_port->overrun_reg == SCxSR)
+		sci_port->error_mask |= sci_port->overrun_mask;
 
 	port->type		= p->type;
 	port->flags		= UPF_FIXED_PORT | p->flags;
-- 
1.9.1

