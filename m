From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] Revert "serial-uartlite: Constify uartlite_be/uartlite_le"
Date: Mon, 11 Apr 2016 20:23:31 +0530
Message-ID: <1460386411-17900-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-serial@vger.kernel.org

This reverts commit 2905697a82eaf20606ced164d853b52d1b94aaa8.

The commit introduced two build warnings:
drivers/tty/serial/uartlite.c: In function =E2=80=98ulite_request_port=E2=
=80=99:
drivers/tty/serial/uartlite.c:348:21: warning: assignment discards
			=E2=80=98const=E2=80=99 qualifier from pointer target type
  port->private_data =3D &uartlite_be;
                     ^
drivers/tty/serial/uartlite.c:354:22: warning: assignment discards
			=E2=80=98const=E2=80=99 qualifier from pointer target type
   port->private_data =3D &uartlite_le;
                      ^

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

Hi Greg,
You said you will fix this after 4.6-rc1 is out, but I guess you have
been busy and it slipped out of your mind.

Previous discussion with your comment at:
https://marc.info/?l=3Dlinux-serial&m=3D145833315817697&w=3D3


 drivers/tty/serial/uartlite.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlit=
e.c
index c9fdfc8..d08baa6 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -72,7 +72,7 @@ static void uartlite_outbe32(u32 val, void __iomem *a=
ddr)
 	iowrite32be(val, addr);
 }
=20
-static const struct uartlite_reg_ops uartlite_be =3D {
+static struct uartlite_reg_ops uartlite_be =3D {
 	.in =3D uartlite_inbe32,
 	.out =3D uartlite_outbe32,
 };
@@ -87,21 +87,21 @@ static void uartlite_outle32(u32 val, void __iomem =
*addr)
 	iowrite32(val, addr);
 }
=20
-static const struct uartlite_reg_ops uartlite_le =3D {
+static struct uartlite_reg_ops uartlite_le =3D {
 	.in =3D uartlite_inle32,
 	.out =3D uartlite_outle32,
 };
=20
 static inline u32 uart_in32(u32 offset, struct uart_port *port)
 {
-	const struct uartlite_reg_ops *reg_ops =3D port->private_data;
+	struct uartlite_reg_ops *reg_ops =3D port->private_data;
=20
 	return reg_ops->in(port->membase + offset);
 }
=20
 static inline void uart_out32(u32 val, u32 offset, struct uart_port *p=
ort)
 {
-	const struct uartlite_reg_ops *reg_ops =3D port->private_data;
+	struct uartlite_reg_ops *reg_ops =3D port->private_data;
=20
 	reg_ops->out(val, port->membase + offset);
 }
--=20
1.9.1
