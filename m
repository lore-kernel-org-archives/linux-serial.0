From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH v2 RESEND] serial: mxs-auart: add sysrq support
Date: Fri, 10 Oct 2014 13:13:28 +0200
Message-ID: <1412939608-19933-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:50124 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752898AbaJJLLE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2014 07:11:04 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

When using mxs-auart based console, sometime we need the sysrq function
to help debugging kernel. The sysrq code is basically there,
this patch just simply enable it.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
Changes from v1 (the initial version of the patch):
* the patch was extracted as indendent from my previous patchset
  "serial: mxs-auart: use mctrl_gpio helpers for handling modem signals (v2.2c)"
   "[PATCH 4/4] serial: mxs-auart: add sysrq support"
* removed obvious comment about required order of
  SUPPORT_SYSRQ define and serial_core.h include

The patch is resent as ready to apply.

I resend it again because last time
in conver letter I swapped subject with
in-reply-to and the patch could be omited.
This time I've added versioning and changelog.

---
 drivers/tty/serial/mxs-auart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index eafce41..e838e84 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -14,6 +14,10 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#if defined(CONFIG_SERIAL_MXS_AUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-- 
1.7.11.3

