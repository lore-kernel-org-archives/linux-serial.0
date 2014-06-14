From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH] serial: samsung: Fix compile error with SERIAL_SAMSUNG_DEBUG
Date: Sat, 14 Jun 2014 22:07:14 +0200
Message-ID: <1402776434-31613-1-git-send-email-cengelma@gmx.at>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:62048 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813AbaFNUIs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jun 2014 16:08:48 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Joe Perches <joe@perches.com>, Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org, Christian Engelmayer <cengelma@gmx.at>

Commit e4ac92d (serial: samsung: Neaten dbg uses) contains a typo in the
changed dbg() function regarding the name of the used character buffer.
This breaks the build if actually compiled with CONFIG_SERIAL_SAMSUNG_DEBUG.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
Compile tested. Applies against branch tty-next in tree
git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
---
 drivers/tty/serial/samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 3293377..c1d3ebd 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -66,7 +66,7 @@ static void dbg(const char *fmt, ...)
 	char buff[256];
 
 	va_start(va, fmt);
-	vscnprintf(buff, sizeof(buf), fmt, va);
+	vscnprintf(buff, sizeof(buff), fmt, va);
 	va_end(va);
 
 	printascii(buff);
-- 
1.9.1

