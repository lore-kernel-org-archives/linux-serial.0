From: =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
Subject: [PATCH 1/9] drivers: tty: 68328serial.c: Add missing spaces(checkpatch)
Date: Fri, 11 Dec 2015 11:36:01 +0100
Message-ID: <1449830170-15096-2-git-send-email-frederik.voelkel@fau.de>
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

This patch adds missing spaces reported by checkpatch.

Signed-off-by: Frederik V=C3=B6lkel <frederik.voelkel@fau.de>
Signed-off-by: Lukas Braun <lukas.braun@fau.de>
---
 drivers/tty/serial/68328serial.c | 92 ++++++++++++++++++++------------=
--------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/6832=
8serial.c
index 0140ba4..4cdd805 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -274,8 +274,8 @@ static void receive_chars(struct m68k_serial *info,=
 unsigned short rx)
 #endif=09
 		ch =3D GET_FIELD(rx, URX_RXDATA);
 =09
-		if(info->is_cons) {
-			if(URX_BREAK & rx) { /* whee, break received */
+		if (info->is_cons) {
+			if (URX_BREAK & rx) { /* whee, break received */
 				return;
 #ifdef CONFIG_MAGIC_SYSRQ
 			} else if (ch =3D=3D 0x10) { /* ^P */
@@ -302,7 +302,7 @@ static void receive_chars(struct m68k_serial *info,=
 unsigned short rx)
=20
 		tty_insert_flip_char(&info->tport, ch, flag);
 #ifndef CONFIG_XCOPILOT_BUGS
-	} while((rx =3D uart->urx.w) & URX_DATA_READY);
+	} while ((rx =3D uart->urx.w) & URX_DATA_READY);
 #endif
=20
 	tty_schedule_flip(&info->tport);
@@ -330,7 +330,7 @@ static void transmit_chars(struct m68k_serial *info=
, struct tty_struct *tty)
 	info->xmit_tail =3D info->xmit_tail & (SERIAL_XMIT_SIZE-1);
 	info->xmit_cnt--;
=20
-	if(info->xmit_cnt <=3D 0) {
+	if (info->xmit_cnt <=3D 0) {
 		/* All done for now... TX ints off */
 		uart->ustcnt &=3D ~USTCNT_TX_INTR_MASK;
 		goto clear_and_return;
@@ -452,45 +452,45 @@ struct {
 }
 #ifndef CONFIG_M68VZ328
  hw_baud_table[18] =3D {
-	{0,0}, /* 0 */
-	{0,0}, /* 50 */
-	{0,0}, /* 75 */
-	{0,0}, /* 110 */
-	{0,0}, /* 134 */
-	{0,0}, /* 150 */
-	{0,0}, /* 200 */
-	{7,0x26}, /* 300 */
-	{6,0x26}, /* 600 */
-	{5,0x26}, /* 1200 */
-	{0,0}, /* 1800 */
-	{4,0x26}, /* 2400 */
-	{3,0x26}, /* 4800 */
-	{2,0x26}, /* 9600 */
-	{1,0x26}, /* 19200 */
-	{0,0x26}, /* 38400 */
-	{1,0x38}, /* 57600 */
-	{0,0x38}, /* 115200 */
+	{0, 0}, /* 0 */
+	{0, 0}, /* 50 */
+	{0, 0}, /* 75 */
+	{0, 0}, /* 110 */
+	{0, 0}, /* 134 */
+	{0, 0}, /* 150 */
+	{0, 0}, /* 200 */
+	{7, 0x26}, /* 300 */
+	{6, 0x26}, /* 600 */
+	{5, 0x26}, /* 1200 */
+	{0, 0}, /* 1800 */
+	{4, 0x26}, /* 2400 */
+	{3, 0x26}, /* 4800 */
+	{2, 0x26}, /* 9600 */
+	{1, 0x26}, /* 19200 */
+	{0, 0x26}, /* 38400 */
+	{1, 0x38}, /* 57600 */
+	{0, 0x38}, /* 115200 */
 };
 #else
  hw_baud_table[18] =3D {
-                 {0,0}, /* 0 */
-                 {0,0}, /* 50 */
-                 {0,0}, /* 75 */
-                 {0,0}, /* 110 */
-                 {0,0}, /* 134 */
-                 {0,0}, /* 150 */
-                 {0,0}, /* 200 */
-                 {0,0}, /* 300 */
-                 {7,0x26}, /* 600 */
-                 {6,0x26}, /* 1200 */
-                 {0,0}, /* 1800 */
-                 {5,0x26}, /* 2400 */
-                 {4,0x26}, /* 4800 */
-                 {3,0x26}, /* 9600 */
-                 {2,0x26}, /* 19200 */
-                 {1,0x26}, /* 38400 */
-                 {0,0x26}, /* 57600 */
-                 {1,0x38}, /* 115200 */
+                 {0, 0}, /* 0 */
+                 {0, 0}, /* 50 */
+                 {0, 0}, /* 75 */
+                 {0, 0}, /* 110 */
+                 {0, 0}, /* 134 */
+                 {0, 0}, /* 150 */
+                 {0, 0}, /* 200 */
+                 {0, 0}, /* 300 */
+                 {7, 0x26}, /* 600 */
+                 {6, 0x26}, /* 1200 */
+                 {0, 0}, /* 1800 */
+                 {5, 0x26}, /* 2400 */
+                 {4, 0x26}, /* 4800 */
+                 {3, 0x26}, /* 9600 */
+                 {2, 0x26}, /* 19200 */
+                 {1, 0x26}, /* 38400 */
+                 {0, 0x26}, /* 57600 */
+                 {1, 0x38}, /* 115200 */
 };=20
 #endif
 /* rate =3D 1036800 / ((65 - prescale) * (1<<divider)) */
@@ -591,8 +591,8 @@ void console_print_68328(const char *p)
 {
 	char c;
 =09
-	while((c=3D*(p++)) !=3D 0) {
-		if(c =3D=3D '\n')
+	while ((c =3D *(p++)) !=3D 0) {
+		if (c =3D=3D '\n')
 			rs_put_char('\r');
 		rs_put_char(c);
 	}
@@ -624,7 +624,7 @@ static void rs_flush_chars(struct tty_struct *tty)
 	if (serial_paranoia_check(info, tty->name, "rs_flush_chars"))
 		return;
 #ifndef USE_INTS
-	for(;;) {
+	for (;;) {
 #endif
=20
 	/* Enable transmitter */
@@ -700,7 +700,7 @@ static int rs_write(struct tty_struct * tty,
 		/* Enable transmitter */
 		local_irq_disable();	=09
 #ifndef USE_INTS
-		while(info->xmit_cnt) {
+		while (info->xmit_cnt) {
 #endif
=20
 		uart->ustcnt |=3D USTCNT_TXEN;
@@ -1180,7 +1180,7 @@ rs68328_init(void)
=20
 	local_irq_save(flags);
=20
-	for(i=3D0;i<NR_PORTS;i++) {
+	for (i =3D 0; i < NR_PORTS; i++) {
=20
 	    info =3D &m68k_soft[i];
 	    tty_port_init(&info->tport);
@@ -1263,7 +1263,7 @@ int m68328_console_setup(struct console *cp, char=
 *arg)
 		return(-1);
=20
 	if (arg)
-		n =3D simple_strtoul(arg,NULL,0);
+		n =3D simple_strtoul(arg, NULL, 0);
=20
 	for (i =3D 0; i < ARRAY_SIZE(baud_table); i++)
 		if (baud_table[i] =3D=3D n)
--=20
1.9.1
