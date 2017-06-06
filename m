From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/9] serial: rate limit custom-speed deprecation notice
Date: Tue,  6 Jun 2017 12:54:33 +0200
Message-ID: <20170606105441.689-2-johan@kernel.org>
References: <20170606105441.689-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Contrary to what a comment claimed, the ASYNC_SPD flags and custom
divisor can be set by a non-privileged user so rate limit the
deprecation notice as was intended.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 13bfd5dcffce..f534a40aebde 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -954,11 +954,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		    old_custom_divisor != uport->custom_divisor) {
 			/*
 			 * If they're setting up a custom divisor or speed,
-			 * instead of clearing it, then bitch about it. No
-			 * need to rate-limit; it's CAP_SYS_ADMIN only.
+			 * instead of clearing it, then bitch about it.
 			 */
 			if (uport->flags & UPF_SPD_MASK) {
-				dev_notice(uport->dev,
+				dev_notice_ratelimited(uport->dev,
 				       "%s sets custom speed on %s. This is deprecated.\n",
 				      current->comm,
 				      tty_name(port->tty));
-- 
2.13.0
