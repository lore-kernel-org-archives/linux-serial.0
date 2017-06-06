From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/9] tty: simserial: drop unused alt_speed handling
Date: Tue,  6 Jun 2017 12:54:36 +0200
Message-ID: <20170606105441.689-5-johan@kernel.org>
References: <20170606105441.689-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

This driver was setting the deprecated and broken alt_speed based on port
flags, but never provided a means to change the flags or to actually
change the speed.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/ia64/hp/sim/simserial.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index de8cba121013..70d52e9bb575 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -387,19 +387,6 @@ static int activate(struct tty_port *port, struct tty_struct *tty)
 	}
 
 	state->xmit.head = state->xmit.tail = 0;
-
-	/*
-	 * Set up the tty->alt_speed kludge
-	 */
-	if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-		tty->alt_speed = 57600;
-	if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-		tty->alt_speed = 115200;
-	if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
-		tty->alt_speed = 230400;
-	if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
-		tty->alt_speed = 460800;
-
 errout:
 	local_irq_restore(flags);
 	return retval;
-- 
2.13.0
