From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: samsung: fix typo in debug code
Date: Tue, 03 Jun 2014 11:53:47 +0200
Message-ID: <10455941.RzodM59Z3O@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Joe Perches <joe@perches.com>, Doug Anderson <dianders@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-serial@vger.kernel.org

commit e4ac92df2791 ("serial: samsung: Neaten dbg uses") introduced
a regression in the conversion from vsprintf to vsnprintf.

This fixes the build error by passing the correct variable name.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>

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
