From: Rob Herring <robh@kernel.org>
Subject: [PATCH 8/9] tty: serial_core: remove dependence on tty->driver_data
Date: Fri,  9 Sep 2016 17:37:09 -0500
Message-ID: <20160909223711.26238-9-robh@kernel.org>
References: <20160909223711.26238-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

As the uart_state contains tty_port, use that to get the uart_state ptr.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/serial_core.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8f2b52174263..b9ec9fd688a2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -120,7 +120,7 @@ void uart_write_wakeup(struct uart_port *port)
 
 static void uart_stop(struct tty_struct *tty)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *port;
 	unsigned long flags;
 
@@ -138,7 +138,7 @@ static void __uart_start(struct uart_port *port)
 
 static void uart_start(struct tty_struct *tty)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *port;
 	unsigned long flags;
 
@@ -517,7 +517,7 @@ static void uart_change_speed(struct tty_port *port, struct ktermios *old_termio
 
 static int uart_put_char(struct tty_struct *tty, unsigned char c)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *port;
 	struct circ_buf *circ;
 	unsigned long flags;
@@ -545,7 +545,7 @@ static void uart_flush_chars(struct tty_struct *tty)
 static int uart_write(struct tty_struct *tty,
 					const unsigned char *buf, int count)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *uport;
 	struct circ_buf *circ;
 	unsigned long flags;
@@ -585,7 +585,7 @@ static int uart_write(struct tty_struct *tty,
 
 static int uart_write_room(struct tty_struct *tty)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *port;
 	unsigned long flags;
 	int ret;
@@ -598,7 +598,7 @@ static int uart_write_room(struct tty_struct *tty)
 
 static int uart_chars_in_buffer(struct tty_struct *tty)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *port;
 	unsigned long flags;
 	int ret;
@@ -611,7 +611,7 @@ static int uart_chars_in_buffer(struct tty_struct *tty)
 
 static void uart_flush_buffer(struct tty_struct *tty)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *port;
 	unsigned long flags;
 
@@ -642,7 +642,7 @@ static void uart_flush_buffer(struct tty_struct *tty)
  */
 static void uart_send_xchar(struct tty_struct *tty, char ch)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *port;
 	unsigned long flags;
 
@@ -664,7 +664,7 @@ static void uart_send_xchar(struct tty_struct *tty, char ch)
 
 static void uart_throttle(struct tty_struct *tty)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *port;
 	upstat_t mask = 0;
 
@@ -693,7 +693,7 @@ static void uart_throttle(struct tty_struct *tty)
 
 static void uart_unthrottle(struct tty_struct *tty)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *port;
 	upstat_t mask = 0;
 
@@ -1026,7 +1026,7 @@ static int uart_get_lsr_info(struct tty_struct *tty,
 
 static int uart_tiocmget(struct tty_struct *tty)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
 	int result = -EIO;
@@ -1050,7 +1050,7 @@ out:
 static int
 uart_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
 	int ret = -EIO;
@@ -1071,7 +1071,7 @@ out:
 
 static int uart_break_ctl(struct tty_struct *tty, int break_state)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
 	int ret = -EIO;
@@ -1221,7 +1221,7 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 static int uart_get_icount(struct tty_struct *tty,
 			  struct serial_icounter_struct *icount)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_icount cnow;
 	struct uart_port *uport;
 
@@ -1295,7 +1295,7 @@ static int uart_set_rs485_config(struct uart_port *port,
 static int
 uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
 	void __user *uarg = (void __user *)arg;
@@ -1386,7 +1386,7 @@ out:
 
 static void uart_set_ldisc(struct tty_struct *tty)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *uport;
 
 	mutex_lock(&state->port.mutex);
@@ -1400,7 +1400,7 @@ static void uart_set_termios(struct tty_struct *tty,
 						struct ktermios *old_termios)
 {
 	struct tty_port *port = tty->port;
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(port);
 	struct uart_port *uport;
 	unsigned int cflag = tty->termios.c_cflag;
 	unsigned int iflag_mask = IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK;
@@ -1461,7 +1461,7 @@ out:
  */
 static void uart_close(struct tty_struct *tty, struct file *filp)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct tty_port *port;
 
 	if (!state) {
@@ -1512,7 +1512,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct uart_port *port;
 	unsigned long char_time, expire;
 
@@ -1576,7 +1576,7 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
  */
 static void uart_hangup(struct tty_struct *tty)
 {
-	struct uart_state *state = tty->driver_data;
+	struct uart_state *state = tty_port_to_uart_state(tty->port);
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
 	unsigned long flags;
-- 
2.9.3
