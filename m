From: Alan Cox <alan@linux.intel.com>
Subject: [RFC PATCH 2/3] serial: add core helpers for RS485 configuration
Date: Tue, 12 Aug 2014 16:01:43 +0100
Message-ID: <20140812150128.13378.1233.stgit@acox1-desk.ger.corp.intel.com>
References: <20140812150104.13378.24152.stgit@acox1-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19395 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042AbaHLPCp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Aug 2014 11:02:45 -0400
In-Reply-To: <20140812150104.13378.24152.stgit@acox1-desk.ger.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

From: Alan <gnomes@lxorguk.ukuu.org.uk>

This propogates the tty layer RS485 helpers into the serial layer

Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/serial/serial_core.c |   15 +++++++++++++++
 include/linux/serial_core.h      |    4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 29a7be4..2797f65 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1322,6 +1322,17 @@ static void uart_set_termios(struct tty_struct *tty,
 	}
 }
 
+static int uart_set_rs485(struct tty_struct *tty, struct serial_rs485 *rs485)
+{
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *uport = state->uart_port;
+
+	if (uport->ops->set_rs485)
+		return uport->ops->set_rs485(uport, rs485);
+        return -EOPNOTSUPP;
+}
+
+
 /*
  * Calls to uart_close() are serialised via the tty_lock in
  *   drivers/tty/tty_io.c:tty_release()
@@ -1484,6 +1495,9 @@ static void uart_hangup(struct tty_struct *tty)
 
 static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
 {
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	if (state->rs485)
+	        tty->rs485 = state->rs485;
 	return 0;
 }
 
@@ -2267,6 +2281,7 @@ static const struct tty_operations uart_ops = {
 	.send_xchar	= uart_send_xchar,
 	.set_termios	= uart_set_termios,
 	.set_ldisc	= uart_set_ldisc,
+	.set_rs485	= uart_set_rs485,
 	.stop		= uart_stop,
 	.start		= uart_start,
 	.hangup		= uart_hangup,
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index cf3a1e7..06227f7 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -64,6 +64,8 @@ struct uart_ops {
 	void		(*set_termios)(struct uart_port *, struct ktermios *new,
 				       struct ktermios *old);
 	void		(*set_ldisc)(struct uart_port *, int new);
+	int		(*set_rs485)(struct uart_port *,
+						struct serial_rs485 *rs485);
 	void		(*pm)(struct uart_port *, unsigned int state,
 			      unsigned int oldstate);
 
@@ -202,6 +204,7 @@ struct uart_port {
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	void			*private_data;		/* generic platform data pointer */
+	struct serial_rs485	*rs485;
 };
 
 static inline int serial_port_in(struct uart_port *up, int offset)
@@ -236,6 +239,7 @@ struct uart_state {
 	struct circ_buf		xmit;
 
 	struct uart_port	*uart_port;
+	struct serial_rs485	*rs485;
 };
 
 #define UART_XMIT_SIZE	PAGE_SIZE

