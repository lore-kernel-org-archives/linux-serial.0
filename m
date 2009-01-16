From: Denis Joseph Barrow <D.Barow@option.com>
Subject: [PATCH]l gdb serial debugging appears be broken since at least 2.6.28-rc6
 by tty layer now hopefully fixed
Date: Fri, 16 Jan 2009 16:58:49 +0100
Message-ID: <4970AEB9.5080702@option.com>
References: <48D10A70.8050202@option.com> <48D10C43.90605@windriver.com> <48D1122F.6080101@option.com> <48D26B64.5080605@windriver.com> <48D39B9F.8010404@option.com> <48D3A1B4.8000505@windriver.com> <48D3AAB0.3010504@option.com> <48D3FFC9.5080701@windriver.com> <49708E50.8080103@option.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060807040507050404060405"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailer2.option.com ([81.246.70.163]:20698 "EHLO
	mailer2.option.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbZAPP6w (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Jan 2009 10:58:52 -0500
In-Reply-To: <49708E50.8080103@option.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>, KGDB Mailing List <kgdb-bugreport@lists.sourceforge.net>, gareth@valinux.com, markus.t.metzger@intel.com, Linux Serial <linux-serial@vger.kernel.org>
Cc: Filip Aben <f.aben@option.com>

This is a multi-part message in MIME format.
--------------060807040507050404060405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,
I changed the code back to something it was like in 2.6.27-rc6 & it now works again.

Changed tty_find_polling driver back to something
close to 2.6.27-rc6 the new stuff broke kgdb when
used with the usual kgdboc=/dev/ttyS0,115200 parameter & similar.
Signed-off-by: Denis Joseph Barrow <D.Barow@option.com>
---Index: linux-2.6/drivers/char/tty_io.c
===================================================================
Index: linux-2.6/drivers/char/tty_io.c
===================================================================
--- linux-2.6.orig/drivers/char/tty_io.c	2009-01-16 16:41:41.000000000 +0100
+++ linux-2.6/drivers/char/tty_io.c	2009-01-16 16:43:59.000000000 +0100
@@ -294,23 +294,13 @@
 {
 	struct tty_driver *p, *res = NULL;
 	int tty_line = 0;
-	int len;
 	char *str;
 
-	for (str = name; *str; str++)
-		if ((*str >= '0' && *str <= '9') || *str == ',')
-			break;
-	if (!*str)
-		return NULL;
-
-	len = str - name;
-	tty_line = simple_strtoul(str, &str, 10);
-
 	mutex_lock(&tty_mutex);
 	/* Search through the tty devices to look for a match */
 	list_for_each_entry(p, &tty_drivers, tty_drivers) {
-		if (strncmp(name, p->name, len) != 0)
-			continue;
+		str = name + strlen(p->name);
+		tty_line = simple_strtoul(str, &str, 10);
 		if (*str == ',')
 			str++;
 		if (*str == '\0')


best regards,
D.J. Barrow

Linux Kernel Developer
Option NV, Gaston Geenslaan 14, 3001 Leuven, Belgium
 
T: +32 16 311 621
F: +32 16 207 164
d.barow@option.com
www.option.com

Disclaimer:
http://www.option.com/company/disclaimer.shtml

--------------060807040507050404060405
Content-Type: text/x-diff;
 name="tty_io_kgdbdoc_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tty_io_kgdbdoc_fix.patch"

Changed tty_find_polling driver back to something
close to 2.6.27-rc6 the new stuff broke kgdb when
used with the usual kgdboc=/dev/ttyS0,115200 parameter & similar.
Signed-off-by: Denis Joseph Barrow <D.Barow@option.com>
---Index: linux-2.6/drivers/char/tty_io.c
===================================================================
Index: linux-2.6/drivers/char/tty_io.c
===================================================================
--- linux-2.6.orig/drivers/char/tty_io.c	2009-01-16 16:41:41.000000000 +0100
+++ linux-2.6/drivers/char/tty_io.c	2009-01-16 16:43:59.000000000 +0100
@@ -294,23 +294,13 @@
 {
 	struct tty_driver *p, *res = NULL;
 	int tty_line = 0;
-	int len;
 	char *str;
 
-	for (str = name; *str; str++)
-		if ((*str >= '0' && *str <= '9') || *str == ',')
-			break;
-	if (!*str)
-		return NULL;
-
-	len = str - name;
-	tty_line = simple_strtoul(str, &str, 10);
-
 	mutex_lock(&tty_mutex);
 	/* Search through the tty devices to look for a match */
 	list_for_each_entry(p, &tty_drivers, tty_drivers) {
-		if (strncmp(name, p->name, len) != 0)
-			continue;
+		str = name + strlen(p->name);
+		tty_line = simple_strtoul(str, &str, 10);
 		if (*str == ',')
 			str++;
 		if (*str == '\0')

--------------060807040507050404060405--
