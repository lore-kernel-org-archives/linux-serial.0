From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] serial: 8250_dw: fix compilation warning when !CONFIG_PM_SLEEP
Date: Thu, 16 Jan 2014 14:55:57 +0200
Message-ID: <1389876957-6052-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60559 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbaAPM4B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jan 2014 07:56:01 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

CONFIG_PM will be set if either or both CONFIG_PM_SLEEP and
CONFIG_PM_RUNTIME is set. Compiling the driver with !CONFIG_PM_SLEEP ca=
uses
following compilation warnings:

drivers/tty/serial/8250/8250_dw.c:404:12: warning: =E2=80=98dw8250_susp=
end=E2=80=99 defined but not used [-Wunused-function]
drivers/tty/serial/8250/8250_dw.c:413:12: warning: =E2=80=98dw8250_resu=
me=E2=80=99 defined but not used [-Wunused-function]

=46ix this by using CONFIG_PM_SLEEP instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
index 06525f10e364..47e6c57de3a6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -400,7 +400,7 @@ static int dw8250_remove(struct platform_device *pd=
ev)
 	return 0;
 }
=20
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int dw8250_suspend(struct device *dev)
 {
 	struct dw8250_data *data =3D dev_get_drvdata(dev);
@@ -418,7 +418,7 @@ static int dw8250_resume(struct device *dev)
=20
 	return 0;
 }
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
=20
 #ifdef CONFIG_PM_RUNTIME
 static int dw8250_runtime_suspend(struct device *dev)
--=20
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
