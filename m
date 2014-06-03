From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 1/1] serial: samsung: Fix build error
Date: Tue,  3 Jun 2014 11:56:25 +0530
Message-ID: <1401776786-468-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33403 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbaFCG3Z (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jun 2014 02:29:25 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so5041918pbb.5
        for <linux-serial@vger.kernel.org>; Mon, 02 Jun 2014 23:29:24 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, spk.linux@gmail.com, arun.kk@samsung.com, Joe Perches <joe@perches.com>

=46ixes the following build error due to a typo introduced
by commit e4ac92df27 ("serial: samsung: Neaten dbg uses"):
drivers/tty/serial/samsung.c:69:26: error: =E2=80=98buf=E2=80=99 undecl=
ared (first use in this function)

Reported-by: Arun Kumar K <arun.kk@samsung.com>
Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Joe Perches <joe@perches.com>
---
 drivers/tty/serial/samsung.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.=
c
index 329337711bb0..c1d3ebdf3b97 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -66,7 +66,7 @@ static void dbg(const char *fmt, ...)
 	char buff[256];
=20
 	va_start(va, fmt);
-	vscnprintf(buff, sizeof(buf), fmt, va);
+	vscnprintf(buff, sizeof(buff), fmt, va);
 	va_end(va);
=20
 	printascii(buff);
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
