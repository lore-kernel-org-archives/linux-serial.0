From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 2/4] serial: kgdb_nmi: Use container_of() to locate private data
Date: Wed, 14 May 2014 15:55:33 +0100
Message-ID: <1400079335-32125-3-git-send-email-daniel.thompson@linaro.org>
References: <1400079335-32125-1-git-send-email-daniel.thompson@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37506 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbaENO4A (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 May 2014 10:56:00 -0400
Received: by mail-we0-f174.google.com with SMTP id k48so2022727wev.5
        for <linux-serial@vger.kernel.org>; Wed, 14 May 2014 07:55:58 -0700 (PDT)
In-Reply-To: <1400079335-32125-1-git-send-email-daniel.thompson@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, Daniel Thompson <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Colin Cross <ccross@android.com>, kernel-team@android.com, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, Jiri Slaby <jslaby@suse.cz>

This corrects a crash in kgdb_nmi_tty_shutdown() which occurs when
the function is called with port->tty set to NULL.

All conversions between struct tty_port and struct kgdb_nmi_tty_priv
have been switched to direct calls to container_of() to improve code
clarity and consistancy.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/kgdb_nmi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 5f673b7..d51b2a1 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -84,11 +84,6 @@ struct kgdb_nmi_tty_priv {
 	STRUCT_KFIFO(char, KGDB_NMI_FIFO_SIZE) fifo;
 };
 
-static struct kgdb_nmi_tty_priv *kgdb_nmi_port_to_priv(struct tty_port *port)
-{
-	return container_of(port, struct kgdb_nmi_tty_priv, port);
-}
-
 /*
  * Our debugging console is polled in a tasklet, so we'll check for input
  * every tick. In HZ-less mode, we should program the next tick.  We have
@@ -118,7 +113,7 @@ static void kgdb_tty_recv(int ch)
 	 * do that, and actually, we can't: we're in NMI context, no locks are
 	 * possible.
 	 */
-	priv = kgdb_nmi_port_to_priv(kgdb_nmi_port);
+	priv = container_of(kgdb_nmi_port, struct kgdb_nmi_tty_priv, port);
 	kfifo_in(&priv->fifo, &c, 1);
 	kgdb_tty_poke();
 }
@@ -216,7 +211,8 @@ static void kgdb_nmi_tty_receiver(unsigned long data)
 
 static int kgdb_nmi_tty_activate(struct tty_port *port, struct tty_struct *tty)
 {
-	struct kgdb_nmi_tty_priv *priv = tty->driver_data;
+	struct kgdb_nmi_tty_priv *priv =
+	    container_of(port, struct kgdb_nmi_tty_priv, port);
 
 	kgdb_nmi_port = port;
 	tasklet_schedule(&priv->tlet);
@@ -225,7 +221,8 @@ static int kgdb_nmi_tty_activate(struct tty_port *port, struct tty_struct *tty)
 
 static void kgdb_nmi_tty_shutdown(struct tty_port *port)
 {
-	struct kgdb_nmi_tty_priv *priv = port->tty->driver_data;
+	struct kgdb_nmi_tty_priv *priv =
+	    container_of(port, struct kgdb_nmi_tty_priv, port);
 
 	tasklet_kill(&priv->tlet);
 	kgdb_nmi_port = NULL;
-- 
1.9.0

