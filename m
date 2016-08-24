From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH 4/6] serio: serport: add support for buffered write and receive
Date: Wed, 24 Aug 2016 18:24:35 -0500
Message-ID: <20160824232437.9446-6-robh@kernel.org>
References: <20160824232437.9446-1-robh@kernel.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160824232437.9446-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

A tty ldisc naturally supports writing a buffer at a time, so convert the
serport driver to use the serio write_buf() function. For clients using
the existing interfaces, there is no change in functionality.

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/input/serio/serport.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index a938c2b..5572c28 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -45,10 +45,10 @@ struct serport {
  * Callback functions from the serio code.
  */
 
-static int serport_serio_write(struct serio *serio, unsigned char data)
+static int serport_serio_write_buf(struct serio *serio, const unsigned char *data, size_t len)
 {
 	struct serport *serport = serio->port_data;
-	return -(serport->tty->ops->write(serport->tty, &data, 1) != 1);
+	return serport->tty->ops->write(serport->tty, data, len);
 }
 
 static int serport_serio_open(struct serio *serio)
@@ -133,26 +133,29 @@ static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *c
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		goto out;
 
-	for (i = 0; i < count; i++) {
-		if (fp) {
-			switch (fp[i]) {
-			case TTY_FRAME:
-				ch_flags = SERIO_FRAME;
-				break;
-
-			case TTY_PARITY:
-				ch_flags = SERIO_PARITY;
-				break;
-
-			default:
-				ch_flags = 0;
-				break;
+	if (serio_buffered_mode_enabled(serport->serio)) {
+		serio_receive_buf(serport->serio, cp, count);
+	} else {
+		for (i = 0; i < count; i++) {
+			if (fp) {
+				switch (fp[i]) {
+				case TTY_FRAME:
+					ch_flags = SERIO_FRAME;
+					break;
+
+				case TTY_PARITY:
+					ch_flags = SERIO_PARITY;
+					break;
+
+				default:
+					ch_flags = 0;
+					break;
+				}
 			}
-		}
 
-		serio_interrupt(serport->serio, cp[i], ch_flags);
+			serio_interrupt(serport->serio, cp[i], ch_flags);
+		}
 	}
-
 out:
 	spin_unlock_irqrestore(&serport->lock, flags);
 }
@@ -179,7 +182,7 @@ static ssize_t serport_ldisc_read(struct tty_struct * tty, struct file * file, u
 	snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", tty_name(tty));
 	serio->id = serport->id;
 	serio->id.type = SERIO_RS232;
-	serio->write = serport_serio_write;
+	serio->write_buf = serport_serio_write_buf;
 	serio->open = serport_serio_open;
 	serio->close = serport_serio_close;
 	serio->port_data = serport;
-- 
2.9.3
