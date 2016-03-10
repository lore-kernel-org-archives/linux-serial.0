From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] serial-uartlite: fix build warning
Date: Thu, 10 Mar 2016 18:44:48 +0530
Message-ID: <1457615688-27406-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-serial@vger.kernel.org

We were getting build warnings about:
drivers/tty/serial/uartlite.c: In function =E2=80=98ulite_request_port=E2=
=80=99:
drivers/tty/serial/uartlite.c:348:21: warning: assignment discards
        'const' qualifier from pointer target type
port->private_data =3D &uartlite_be;
                     ^
drivers/tty/serial/uartlite.c:354:22: warning: assignment discards
        'const' qualifier from pointer target type
port->private_data =3D &uartlite_le;
                      ^

=46ixes: 2905697a82ea ("serial-uartlite: Constify uartlite_be/uartlite_=
le")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

next-20160310 build log at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/114988022

 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlit=
e.c
index c9fdfc8..1474c57 100644
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
@@ -87,7 +87,7 @@ static void uartlite_outle32(u32 val, void __iomem *a=
ddr)
 	iowrite32(val, addr);
 }
=20
-static const struct uartlite_reg_ops uartlite_le =3D {
+static struct uartlite_reg_ops uartlite_le =3D {
 	.in =3D uartlite_inle32,
 	.out =3D uartlite_outle32,
 };
--=20
1.9.1
