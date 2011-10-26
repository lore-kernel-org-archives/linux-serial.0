From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 53/79] keyboard: Do not include <linux/irq.>
Date: Wed, 26 Oct 2011 14:12:58 +0200
Message-ID: <1319631204-23262-53-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32808 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932918Ab1JZMNx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:53 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@suse.de>

=46rom: Geert Uytterhoeven <geert@linux-m68k.org>

The top of <linux/irq.h> has this comment:

 * Please do not include this file in generic code.  There is currently
 * no requirement for any architecture to implement anything held
 * within this file.
 *
 * Thanks. --rmk

Remove inclusion of <linux/irq.>, to prevent the following compile erro=
r
from happening soon:

| include/linux/irq.h:132: error: redefinition of =E2=80=98struct irq_d=
ata=E2=80=99
| include/linux/irq.h:286: error: redefinition of =E2=80=98struct irq_c=
hip=E2=80=99

drivers/tty/vt/keyboard.c needs to include <asm/irq_regs.h> for get_irq=
_regs():

| drivers/tty/vt/keyboard.c:497: error: implicit declaration of functio=
n =E2=80=98get_irq_regs=E2=80=99
| drivers/tty/vt/keyboard.c:497: warning: initialization makes pointer =
from integer without a cast

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/vt/keyboard.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 3761ccf..a605549 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -33,7 +33,6 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/irq.h>
=20
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
@@ -43,6 +42,8 @@
 #include <linux/notifier.h>
 #include <linux/jiffies.h>
=20
+#include <asm/irq_regs.h>
+
 extern void ctrl_alt_del(void);
=20
 /*
--=20
1.7.7

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
