From: =?UTF-8?q?Ky=C3=B6sti=20M=C3=A4lkki?= <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] usb: gadget dbgp: Fix endpoint config after USB disconnect
Date: Mon,  3 Nov 2014 17:18:04 +0200
Message-ID: <1415027885-2181-2-git-send-email-kyosti.malkki@gmail.com>
References: <1414346490-19307-1-git-send-email-kyosti.malkki@gmail.com>
 <1415027885-2181-1-git-send-email-kyosti.malkki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415027885-2181-1-git-send-email-kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

SET_FEATURE request with DEBUG_MODE only worked the first time after mo=
dule
initialisation. Per the USB 2.0 debug device specification, said reques=
t
is to be treated as if it were a SET_CONFIGURATION request, i.e. endpoi=
nt
must be re-configured.

As configure_endpoints() may now get called multiple times, move it out=
side
__init and move serial_alloc_tty() call into __init.

Code has assumption that endpoint mapping remains unchanged with consec=
utive
calls of configure_endpoints().

Signed-off-by: Ky=C3=B6sti M=C3=A4lkki <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/gadget/legacy/dbgp.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/legacy/dbgp.c b/drivers/usb/gadget/lega=
cy/dbgp.c
index 1b07513..633683a 100644
--- a/drivers/usb/gadget/legacy/dbgp.c
+++ b/drivers/usb/gadget/legacy/dbgp.c
@@ -237,7 +237,7 @@ static void dbgp_unbind(struct usb_gadget *gadget)
 static unsigned char tty_line;
 #endif
=20
-static int __init dbgp_configure_endpoints(struct usb_gadget *gadget)
+static int dbgp_configure_endpoints(struct usb_gadget *gadget)
 {
 	int stp;
=20
@@ -273,19 +273,10 @@ static int __init dbgp_configure_endpoints(struct=
 usb_gadget *gadget)
=20
 	dbgp.serial->in->desc =3D &i_desc;
 	dbgp.serial->out->desc =3D &o_desc;
-
-	if (gserial_alloc_line(&tty_line)) {
-		stp =3D 3;
-		goto fail_3;
-	}
+#endif
=20
 	return 0;
=20
-fail_3:
-	dbgp.o_ep->driver_data =3D NULL;
-#else
-	return 0;
-#endif
 fail_2:
 	dbgp.i_ep->driver_data =3D NULL;
 fail_1:
@@ -324,10 +315,17 @@ static int __init dbgp_bind(struct usb_gadget *ga=
dget,
 		err =3D -ENOMEM;
 		goto fail;
 	}
+
+	if (gserial_alloc_line(&tty_line)) {
+		stp =3D 4;
+		err =3D -ENODEV;
+		goto fail;
+	}
 #endif
+
 	err =3D dbgp_configure_endpoints(gadget);
 	if (err < 0) {
-		stp =3D 4;
+		stp =3D 5;
 		goto fail;
 	}
=20
@@ -383,6 +381,10 @@ static int dbgp_setup(struct usb_gadget *gadget,
 #ifdef CONFIG_USB_G_DBGP_PRINTK
 		err =3D dbgp_enable_ep();
 #else
+		err =3D dbgp_configure_endpoints(gadget);
+		if (err < 0) {
+			goto fail;
+		}
 		err =3D gserial_connect(dbgp.serial, tty_line);
 #endif
 		if (err < 0)
--=20
1.8.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
