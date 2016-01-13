From: =?UTF-8?q?Jakob=20=C3=98stergaard=20Jensen?=
	<jakob.jensen.91@gmail.com>
Subject: [PATCH] Drivers: tty: serial: jsm_tty: fixed redundant variable issue.
Date: Wed, 13 Jan 2016 14:24:10 +0100
Message-ID: <1452691450-3268-1-git-send-email-jakob.jensen.91@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Jakob=20=C3=98stergaard=20Jensen?= <jakob.jensen.91@gmail.com>
List-Id: linux-serial@vger.kernel.org

=46ixes unnecessary variable reassignment to a new redundant variable.

Signed-off-by: Jakob =C3=98stergaard Jensen <jakob.jensen.91@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/=
jsm_tty.c
index 524e86a..8ac669b 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -529,7 +529,6 @@ void jsm_input(struct jsm_channel *ch)
 	int data_len;
 	unsigned long lock_flags;
 	int len =3D 0;
-	int n =3D 0;
 	int s =3D 0;
 	int i =3D 0;
=20
@@ -598,16 +597,15 @@ void jsm_input(struct jsm_channel *ch)
 	jsm_dbg(READ, &ch->ch_bd->pci_dev, "start 2\n");
=20
 	len =3D tty_buffer_request_room(port, data_len);
-	n =3D len;
=20
 	/*
 	 * n now contains the most amount of data we can copy,
 	 * bounded either by the flip buffer size or the amount
 	 * of data the card actually has pending...
 	 */
-	while (n) {
+	while (len) {
 		s =3D ((head >=3D tail) ? head : RQUEUESIZE) - tail;
-		s =3D min(s, n);
+		s =3D min(s, len);
=20
 		if (s <=3D 0)
 			break;
@@ -638,7 +636,7 @@ void jsm_input(struct jsm_channel *ch)
 			tty_insert_flip_string(port, ch->ch_rqueue + tail, s);
 		}
 		tail +=3D s;
-		n -=3D s;
+		len -=3D s;
 		/* Flip queue if needed */
 		tail &=3D rmask;
 	}
--=20
2.5.0
