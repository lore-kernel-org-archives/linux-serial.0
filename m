From: Ping <pinglinux@gmail.com>
Subject: [PATCH 1/2] serial/8250_pnp: Add a new Fujitsu Wacom Tablet PC device
Date: Mon, 11 Jan 2010 11:48:16 -0800
Message-ID: <167e8a331001111148g303ca86bjf172d2d1d24df759@mail.gmail.com>
References: <167e8a331001071649l3d8df335w2b2422984bb245e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:50020 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0AKTsS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Jan 2010 14:48:18 -0500
Received: by pwj9 with SMTP id 9so1587980pwj.21
        for <linux-serial@vger.kernel.org>; Mon, 11 Jan 2010 11:48:17 -0800 (PST)
In-Reply-To: <167e8a331001071649l3d8df335w2b2422984bb245e8@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

Sending this patchset to the list.  Sorry for those who has got this
one before.

Ping

=46rom: Ping Cheng <pingc@wacom.com>
Date: Thu, 7 Jan 2010 16:21:37 -0800
Subject: [PATCH 1/2] Add a new Fujitsu Wacom Tablet PC device

This is a new two finger touch Fujitsu Wacom Tablet PC

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
=A0drivers/serial/8250_pnp.c | =A0 =A02 ++
=A01 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
index 36ede02..b5496a1 100644
--- a/drivers/serial/8250_pnp.c
+++ b/drivers/serial/8250_pnp.c
@@ -354,6 +354,8 @@ static const struct pnp_device_id pnp_dev_table[] =3D=
 {
=A0 =A0 =A0 =A0{ =A0 =A0 =A0 "FUJ02E5", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
=A0 =A0 =A0 =A0/* Fujitsu P-series tablet PC device */
=A0 =A0 =A0 =A0{ =A0 =A0 =A0 "FUJ02E6", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
+ =A0 =A0 =A0 /* Fujitsu Wacom 2FGT Tablet PC device */
+ =A0 =A0 =A0 { =A0 =A0 =A0 "FUJ02E7", =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 },
=A0 =A0 =A0 =A0/*
=A0 =A0 =A0 =A0 * LG C1 EXPRESS DUAL (C1-PB11A3) touch screen (actually=
 a FUJ02E6 in
=A0 =A0 =A0 =A0 * disguise)
--
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
