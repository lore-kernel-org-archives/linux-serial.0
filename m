From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/8] serdev: ttyport: fix NULL-deref on hangup
Date: Fri,  3 Nov 2017 15:30:55 +0100
Message-ID: <20171103143059.20749-5-johan@kernel.org>
References: <20171103143059.20749-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103143059.20749-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Make sure to use a properly refcounted tty_struct in write_wake up to
avoid dereferencing a NULL-pointer when a port is being hung up.

Fixes: bed35c6dfa6a ("serdev: add a tty port controller driver")
Cc: stable <stable@vger.kernel.org>     # 4.11
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index b8bc60a251c6..31c05665a0e6 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -57,12 +57,19 @@ static void ttyport_write_wakeup(struct tty_port *port)
 {
 	struct serdev_controller *ctrl = port->client_data;
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty;
+
+	tty = tty_port_tty_get(port);
+	if (!tty)
+		return;
 
-	if (test_and_clear_bit(TTY_DO_WRITE_WAKEUP, &port->tty->flags) &&
+	if (test_and_clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) &&
 	    test_bit(SERPORT_ACTIVE, &serport->flags))
 		serdev_controller_write_wakeup(ctrl);
 
-	wake_up_interruptible_poll(&port->tty->write_wait, POLLOUT);
+	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
+
+	tty_kref_put(tty);
 }
 
 static const struct tty_port_client_operations client_ops = {
-- 
2.15.0
