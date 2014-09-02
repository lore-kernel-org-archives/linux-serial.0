From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 14/26] serial: core: Document and assert lock requirements for irq helpers
Date: Tue,  2 Sep 2014 17:39:23 -0400
Message-ID: <1409693975-1028-15-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The serial core provides two helper functions, uart_handle_dcd_change()
and uart_handle_cts_change(), for UART drivers to use at interrupt
time. The serial core expects the UART driver to hold the uart port lock
when calling these helpers to prevent state corruption.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 732d386..b50050d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2731,6 +2731,8 @@ EXPORT_SYMBOL(uart_match_port);
  *	uart_handle_dcd_change - handle a change of carrier detect state
  *	@uport: uart_port structure for the open port
  *	@status: new carrier detect status, nonzero if active
+ *
+ *	Caller must hold uport->lock
  */
 void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 {
@@ -2738,6 +2740,8 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 	struct tty_struct *tty = port->tty;
 	struct tty_ldisc *ld;
 
+	warn_not_spin_locked(&uport->lock);
+
 	if (tty) {
 		ld = tty_ldisc_ref(tty);
 		if (ld) {
@@ -2762,12 +2766,16 @@ EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
  *	uart_handle_cts_change - handle a change of clear-to-send state
  *	@uport: uart_port structure for the open port
  *	@status: new clear to send status, nonzero if active
+ *
+ *	Caller must hold uport->lock
  */
 void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
 {
 	struct tty_port *port = &uport->state->port;
 	struct tty_struct *tty = port->tty;
 
+	warn_not_spin_locked(&uport->lock);
+
 	uport->icount.cts++;
 
 	if (tty_port_cts_enabled(port)) {
-- 
2.1.0
