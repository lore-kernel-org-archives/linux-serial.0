From: =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
Subject: [PATCH 9/9] drivers: tty: 68328serial.c: Move trailing statements to next line
Date: Fri, 11 Dec 2015 11:36:09 +0100
Message-ID: <1449830170-15096-10-git-send-email-frederik.voelkel@fau.de>
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

This patch moves trailing statements to the next line as checkpatch
suggests.

Signed-off-by: Frederik V=C3=B6lkel <frederik.voelkel@fau.de>
Signed-off-by: Lukas Braun <lukas.braun@fau.de>
---
 drivers/tty/serial/68328serial.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/6832=
8serial.c
index 7e2e494..d5bc7f1 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -195,7 +195,8 @@ static inline int get_baud(struct m68k_serial *ss)
 {
 	unsigned long result =3D 115200;
 	unsigned short int baud =3D uart_addr[ss->line].ubaud;
-	if (GET_FIELD(baud, UBAUD_PRESCALER) =3D=3D 0x38) result =3D 38400;
+	if (GET_FIELD(baud, UBAUD_PRESCALER) =3D=3D 0x38)
+		result =3D 38400;
 	result >>=3D GET_FIELD(baud, UBAUD_DIVIDE);
=20
 	return result;
@@ -560,8 +561,10 @@ static void rs_fair_output(void)
 	struct m68k_serial *info =3D &m68k_soft[0];
 	char c;
=20
-	if (info =3D=3D NULL) return;
-	if (info->xmit_buf =3D=3D NULL) return;
+	if (info =3D=3D NULL)
+		return;
+	if (info->xmit_buf =3D=3D NULL)
+		return;
=20
 	local_irq_save(flags);
 	left =3D info->xmit_cnt;
@@ -653,7 +656,8 @@ static void rs_flush_chars(struct tty_struct *tty)
 	}
=20
 #ifndef USE_INTS
-	while (!(uart->utx.w & UTX_TX_AVAIL)) udelay(5);
+	while (!(uart->utx.w & UTX_TX_AVAIL))
+		udelay(5);
 	}
 #endif
 	local_irq_restore(flags);
@@ -707,7 +711,8 @@ static int rs_write(struct tty_struct *tty,
 #ifdef USE_INTS
 		uart->ustcnt |=3D USTCNT_TX_INTR_MASK;
 #else
-		while (!(uart->utx.w & UTX_TX_AVAIL)) udelay(5);
+		while (!(uart->utx.w & UTX_TX_AVAIL))
+			udelay(5);
 #endif
 		if (uart->utx.w & UTX_TX_AVAIL) {
 			uart->utx.b.txdata =3D info->xmit_buf[info->xmit_tail++];
--=20
1.9.1
