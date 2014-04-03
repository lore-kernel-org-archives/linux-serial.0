From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH] USB: usb_wwan: fix handling of missing bulk endpoints
Date: Thu,  3 Apr 2014 13:06:46 +0200
Message-ID: <1396523206-19973-1-git-send-email-jhovold@gmail.com>
References: <20140403101729.GG22587@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:37633 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbaDCLHf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Apr 2014 07:07:35 -0400
In-Reply-To: <20140403101729.GG22587@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: linux-usb@vger.kernel.org, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-serial@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>, Johan Hovold <jhovold@gmail.com>, stable <stable@vger.kernel.org>

=46ix regression introduced by commit 8e493ca1767d ("USB: usb_wwan: fix
bulk-urb allocation") by making sure to require both bulk-in and out
endpoints during port probe.

The original option driver (which usb_wwan is based on) was written
under the assumption that either endpoint could be missing, but
evidently this cannot have been tested properly. Specifically, it would
handle opening a device without bulk-in (but would blow up during resum=
e
which was implemented later), but not a missing bulk-out in write()
(although it is handled in some places such as write_room()).

=46ortunately (?), the driver also got the test for missing endpoints
wrong so the urbs were in fact always allocated, although they would be
initialised using the wrong endpoint address (0) and any submission of
such an urb would fail.

The commit mentioned above fixed the test for missing endpoints but
thereby exposed the other bugs which would now generate null-pointer
exceptions rather than failed urb submissions.

The regression was introduced in v3.7, but the offending commit was als=
o
marked for stable.

Reported-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---

Rafa=C5=82, could you test this patch?

Thanks,
Johan


 drivers/usb/serial/usb_wwan.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwa=
n.c
index 640fe0173236..b078440e822f 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -466,6 +466,9 @@ int usb_wwan_port_probe(struct usb_serial_port *por=
t)
 	int err;
 	int i;
=20
+	if (!port->bulk_in_size || !port->bulk_out_size)
+		return -ENODEV;
+
 	portdata =3D kzalloc(sizeof(*portdata), GFP_KERNEL);
 	if (!portdata)
 		return -ENOMEM;
@@ -473,9 +476,6 @@ int usb_wwan_port_probe(struct usb_serial_port *por=
t)
 	init_usb_anchor(&portdata->delayed);
=20
 	for (i =3D 0; i < N_IN_URB; i++) {
-		if (!port->bulk_in_size)
-			break;
-
 		buffer =3D (u8 *)__get_free_page(GFP_KERNEL);
 		if (!buffer)
 			goto bail_out_error;
@@ -489,9 +489,6 @@ int usb_wwan_port_probe(struct usb_serial_port *por=
t)
 	}
=20
 	for (i =3D 0; i < N_OUT_URB; i++) {
-		if (!port->bulk_out_size)
-			break;
-
 		buffer =3D kmalloc(OUT_BUFLEN, GFP_KERNEL);
 		if (!buffer)
 			goto bail_out_error2;
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
