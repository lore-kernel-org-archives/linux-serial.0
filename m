From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/4] TTY: serial, fix build of some drivers
Date: Wed, 31 Aug 2011 21:24:58 +0200
Message-ID: <1314818699-10873-3-git-send-email-jslaby@suse.cz>
References: <1314818699-10873-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.pripojeni.net ([178.22.112.14]:42893 "EHLO
	smtp.pripojeni.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab1HaTZH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Aug 2011 15:25:07 -0400
In-Reply-To: <1314818699-10873-1-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>

I'm getting build errors such as:
=2E../tty/serial/max3107.c: In function =E2=80=98put_data_to_circ_buf=E2=
=80=99:
=2E../tty/serial/max3107.c:149:2: error: implicit declaration of functi=
on =E2=80=98tty_insert_flip_string=E2=80=99

Those drivers need to include linux/tty_flip.h. The question is
whether we want to fix them at all. As they are broken for some time
already and nobody noticed...

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/serial/max3107.c  |    1 +
 drivers/tty/serial/timbuart.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/max3107.c b/drivers/tty/serial/max3107.=
c
index a50f406..a33ff77 100644
--- a/drivers/tty/serial/max3107.c
+++ b/drivers/tty/serial/max3107.c
@@ -35,6 +35,7 @@
 #include <linux/spi/spi.h>
 #include <linux/freezer.h>
 #include <linux/module.h>
+#include <linux/tty_flip.h>
 #include "max3107.h"
=20
 static const struct baud_table brg26_ext[] =3D {
diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuar=
t.c
index e213535..3a4da87 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -28,6 +28,7 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/tty_flip.h>
=20
 #include "timbuart.h"
=20
--=20
1.7.6.1


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
