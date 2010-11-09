From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] serial: 8250: fix uninitialized compiler warning
Date: Tue, 09 Nov 2010 13:55:23 -0300
Message-ID: <1289321723.2260.14.camel@cowboy>
Reply-To: dave@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

=46rom: Davidlohr Bueso <dave@gnu.org>

This addresses:

  CC [M]  drivers/serial/8250.o
drivers/serial/8250.c: In function =E2=80=98serial8250_shutdown=E2=80=99=
:
drivers/serial/8250.c:1696: warning: =E2=80=98i=E2=80=99 may be used un=
initialized in this function
drivers/serial/8250.c:1696: note: =E2=80=98i=E2=80=99 was declared here

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 drivers/serial/8250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 4d8e14b..f734eee 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1693,7 +1693,7 @@ static int serial_link_irq_chain(struct uart_8250=
_port *up)
=20
 static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
-	struct irq_info *i;
+	struct irq_info *i =3D NULL;
 	struct hlist_node *n;
 	struct hlist_head *h;
=20
--=20
1.7.1
