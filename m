From: Amit Shah <shahamit@gmx.net>
Subject: [PATCH][2.5] const char* to char* update in console.h
Date: Mon, 5 May 2003 20:27:59 +0530
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200305052027.59853.shahamit@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [203.199.140.162] ([203.199.140.162]:44548 "EHLO
	calvin.codito.com") by vger.kernel.org with ESMTP id S262293AbTEEOp1
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 May 2003 10:45:27 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: trivial@rustcorp.com.au, Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi all,

(resending updated version for 2.5.69)

The read function for consoles in include/linux/console.h contains const 
char* for a pointer that it will actually modify. Although no one seems 
to be using this as of now, it should be corrected.

--- linux-2.5.69/include/linux/console.h.orig	Mon May  5 16:32:47 2003
+++ linux-2.5.69/include/linux/console.h	Mon May  5 16:33:13 2003
@@ -96,7 +96,7 @@
 {
 	char	name[8];
 	void	(*write)(struct console *, const char *, unsigned);
-	int	(*read)(struct console *, const char *, unsigned);
+	int	(*read)(struct console *, char *, unsigned);
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);

-- 
Amit Shah
http://amitshah.nav.to/

A: No.
Q: Should I include quotations after my reply?

