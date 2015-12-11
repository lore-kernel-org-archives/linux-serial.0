From: =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
Subject: [PATCH 4/9] drivers: tty: 68328serial.c: Fix "foo * bar" should be "foo *bar"
Date: Fri, 11 Dec 2015 11:36:04 +0100
Message-ID: <1449830170-15096-5-git-send-email-frederik.voelkel@fau.de>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: jslaby@suse.com, gregkh@linuxfoundation.org, linux-kernel@i4.cs.fau.de, =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>, Lukas Braun <lukas.braun@fau.de>
List-Id: linux-serial@vger.kernel.org

This patch fixes checkpatch errors "foo * bar" should be "foo *bar".

Signed-off-by: Frederik V=C3=B6lkel <frederik.voelkel@fau.de>
Signed-off-by: Lukas Braun <lukas.braun@fau.de>
---
 drivers/tty/serial/68328serial.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/6832=
8serial.c
index b6d7230c..8d58517 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -659,9 +659,9 @@ static void rs_flush_chars(struct tty_struct *tty)
 	local_irq_restore(flags);
 }
=20
-extern void console_printn(const char * b, int count);
+extern void console_printn(const char *b, int count);
=20
-static int rs_write(struct tty_struct * tty,
+static int rs_write(struct tty_struct *tty,
 		    const unsigned char *buf, int count)
 {
 	int	c, total =3D 0;
@@ -767,7 +767,7 @@ static void rs_flush_buffer(struct tty_struct *tty)
  * incoming characters should be throttled.
  * ------------------------------------------------------------
  */
-static void rs_throttle(struct tty_struct * tty)
+static void rs_throttle(struct tty_struct *tty)
 {
 	struct m68k_serial *info =3D (struct m68k_serial *)tty->driver_data;
=20
@@ -780,7 +780,7 @@ static void rs_throttle(struct tty_struct * tty)
 	/* Turn off RTS line (do this atomic) */
 }
=20
-static void rs_unthrottle(struct tty_struct * tty)
+static void rs_unthrottle(struct tty_struct *tty)
 {
 	struct m68k_serial *info =3D (struct m68k_serial *)tty->driver_data;
=20
@@ -803,8 +803,8 @@ static void rs_unthrottle(struct tty_struct * tty)
  * ------------------------------------------------------------
  */
=20
-static int get_serial_info(struct m68k_serial * info,
-			   struct serial_struct * retinfo)
+static int get_serial_info(struct m68k_serial *info,
+			   struct serial_struct *retinfo)
 {
 	struct serial_struct tmp;
  =20
@@ -827,7 +827,7 @@ static int get_serial_info(struct m68k_serial * inf=
o,
 }
=20
 static int set_serial_info(struct m68k_serial *info, struct tty_struct=
 *tty,
-			   struct serial_struct * new_info)
+			   struct serial_struct *new_info)
 {
 	struct tty_port *port =3D &info->tport;
 	struct serial_struct new_serial;
@@ -883,7 +883,7 @@ check_and_exit:
  * 	    transmit holding register is empty.  This functionality
  * 	    allows an RS485 driver to be written in user space.=20
  */
-static int get_lsr_info(struct m68k_serial * info, unsigned int *value=
)
+static int get_lsr_info(struct m68k_serial *info, unsigned int *value)
 {
 #ifdef CONFIG_SERIAL_68328_RTS_CTS
 	m68328_uart *uart =3D &uart_addr[info->line];
@@ -904,7 +904,7 @@ static int get_lsr_info(struct m68k_serial * info, =
unsigned int *value)
 /*
  * This routine sends a break character out the serial port.
  */
-static void send_break(struct m68k_serial * info, unsigned int duratio=
n)
+static void send_break(struct m68k_serial *info, unsigned int duration=
)
 {
 	m68328_uart *uart =3D &uart_addr[info->line];
         unsigned long flags;
@@ -922,7 +922,7 @@ static void send_break(struct m68k_serial * info, u=
nsigned int duration)
 static int rs_ioctl(struct tty_struct *tty,
 		    unsigned int cmd, unsigned long arg)
 {
-	struct m68k_serial * info =3D (struct m68k_serial *)tty->driver_data;
+	struct m68k_serial *info =3D (struct m68k_serial *)tty->driver_data;
 	int retval;
=20
 	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
@@ -992,9 +992,9 @@ static void rs_set_termios(struct tty_struct *tty, =
struct ktermios *old_termios)
  * that IRQ if nothing is left in the chain.
  * ------------------------------------------------------------
  */
-static void rs_close(struct tty_struct *tty, struct file * filp)
+static void rs_close(struct tty_struct *tty, struct file *filp)
 {
-	struct m68k_serial * info =3D (struct m68k_serial *)tty->driver_data;
+	struct m68k_serial *info =3D (struct m68k_serial *)tty->driver_data;
 	struct tty_port *port =3D &info->tport;
 	m68328_uart *uart =3D &uart_addr[info->line];
 	unsigned long flags;
@@ -1079,7 +1079,7 @@ static void rs_close(struct tty_struct *tty, stru=
ct file * filp)
  */
 void rs_hangup(struct tty_struct *tty)
 {
-	struct m68k_serial * info =3D (struct m68k_serial *)tty->driver_data;
+	struct m68k_serial *info =3D (struct m68k_serial *)tty->driver_data;
 =09
 	if (serial_paranoia_check(info, tty->name, "rs_hangup"))
 		return;
@@ -1098,7 +1098,7 @@ void rs_hangup(struct tty_struct *tty)
  * the IRQ chain.   It also performs the serial-specific
  * initialization for the tty structure.
  */
-int rs_open(struct tty_struct *tty, struct file * filp)
+int rs_open(struct tty_struct *tty, struct file *filp)
 {
 	struct m68k_serial	*info;
 	int retval;
--=20
1.9.1
