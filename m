From: Ping <pinglinux@gmail.com>
Subject: [PATCH 2/2] serial/8250_pnp: Use wildcard for serial Wacom tablets
Date: Mon, 11 Jan 2010 11:51:29 -0800
Message-ID: <167e8a331001111151r68ba389by2757a74db2e44b91@mail.gmail.com>
References: <200912022318.nB2NI7ZU014860@imap1.linux-foundation.org>
	 <6753EB6004AFF34FAA275742C104F952BDD5EF@wacom-nt10.wacom.com>
	 <167e8a331001071652q45313e9bj30606a023b8fb29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:55445 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab0AKTva convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Jan 2010 14:51:30 -0500
Received: by pxi4 with SMTP id 4so3908440pxi.33
        for <linux-serial@vger.kernel.org>; Mon, 11 Jan 2010 11:51:29 -0800 (PST)
In-Reply-To: <167e8a331001071652q45313e9bj30606a023b8fb29@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

Sorry to send this patchset more than once.  It didn't land in Linus
tree last year.

Ping

=46rom: Matthew Garrett <mjg@redhat.com>
Date: Thu, 7 Jan 2010 16:30:08 -0800
Subject: [PATCH 2/2] 8250_pnp: Use wildcard for serial Wacom tablets

=A0 Wacom claims that the WACF namespace will always be devoted to
=A0 serial Wacom tablets. Remove the existing entries and add a
=A0 wildcard to avoid having to update the kernel every time they
=A0 add a new device.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Tested-by: Ping Cheng <pingc@wacom.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
=A0drivers/serial/8250_pnp.c | =A0 10 +---------
=A01 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
index b5496a1..cbe17c8 100644
--- a/drivers/serial/8250_pnp.c
+++ b/drivers/serial/8250_pnp.c
@@ -328,15 +328,7 @@ static const struct pnp_device_id pnp_dev_table[] =
=3D {
=A0 =A0 =A0 =A0/* U.S. Robotics 56K Voice INT PnP*/
=A0 =A0 =A0 =A0{ =A0 =A0 =A0 "USR9190", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
=A0 =A0 =A0 =A0/* Wacom tablets */
- =A0 =A0 =A0 { =A0 =A0 =A0 "WACF004", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
- =A0 =A0 =A0 { =A0 =A0 =A0 "WACF005", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
- =A0 =A0 =A0 { =A0 =A0 =A0 "WACF006", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
- =A0 =A0 =A0 { =A0 =A0 =A0 "WACF007", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
- =A0 =A0 =A0 { =A0 =A0 =A0 "WACF008", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
- =A0 =A0 =A0 { =A0 =A0 =A0 "WACF009", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
- =A0 =A0 =A0 { =A0 =A0 =A0 "WACF00A", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
- =A0 =A0 =A0 { =A0 =A0 =A0 "WACF00B", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
- =A0 =A0 =A0 { =A0 =A0 =A0 "WACF00C", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
+ =A0 =A0 =A0 { =A0 =A0 =A0 "WACFXXX", =A0 =A0 =A0 =A0 =A0 =A0 =A00 },
=A0 =A0 =A0 =A0/* Compaq touchscreen */
=A0 =A0 =A0 =A0{ =A0 =A0 =A0 "FPI2002", =A0 =A0 =A0 =A0 =A0 =A0 =A00 },
=A0 =A0 =A0 =A0/* Fujitsu Stylistic touchscreens */
--
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
