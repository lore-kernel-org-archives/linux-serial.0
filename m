From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v2 RESEND] tty: serial: Use GFP_ATOMIC instead of GFP_KERNEL in serial8250_em485_init()
Date: Sat, 27 Feb 2016 16:00:45 +0300
Message-ID: <1456578045-1657-1-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, andy.shevchenko@gmail.com, gnomes@lxorguk.ukuu.org.uk
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

serial8250_em485_init() is supposed to be protected with
p->port.lock spinlock.
This may lead to issues when kmalloc sleeps, so it is better to use
GFP_ATOMIC in this spinlocked context.

=46ixes: e490c9144cfa ("tty: Add software emulated RS485 support for 82=
50")
Reported-by: =D0=98=D0=BB=D1=8C=D1=8F=D1=81 =D0=93=D0=B0=D1=81=D0=B0=D0=
=BD=D0=BE=D0=B2 <torso.nafi@gmail.com>
Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
Changes from v1:
 - Properly filled Reported-by: tag

 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
index c908b77..4d6deef 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -586,7 +586,7 @@ int serial8250_em485_init(struct uart_8250_port *p)
 	if (p->em485 !=3D NULL)
 		return 0;
=20
-	p->em485 =3D kmalloc(sizeof(struct uart_8250_em485), GFP_KERNEL);
+	p->em485 =3D kmalloc(sizeof(struct uart_8250_em485), GFP_ATOMIC);
 	if (p->em485 =3D=3D NULL)
 		return -ENOMEM;
=20
--=20
2.7.0
