From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 21/75] n_tty: Fix handling of control characters and
	continuations
Date: Fri, 02 Jan 2009 13:43:25 +0000
Message-ID: <20090102134322.13472.12655.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60326 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756050AbZABNnK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:43:10 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Joe Peterson <joe@skyrush.com>

Fix process_output_block to detect continuation characters correctly
and to handle control characters even when O_OLCUC is enabled.  Make
similar change to do_output_char().

Signed-off-by: Joe Peterson <joe@skyrush.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/n_tty.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)


diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
index a223823..30b0426 100644
--- a/drivers/char/n_tty.c
+++ b/drivers/char/n_tty.c
@@ -351,10 +351,12 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 			tty->column--;
 		break;
 	default:
-		if (O_OLCUC(tty))
-			c = toupper(c);
-		if (!iscntrl(c) && !is_continuation(c, tty))
-			tty->column++;
+		if (!iscntrl(c)) {
+			if (O_OLCUC(tty))
+				c = toupper(c);
+			if (!is_continuation(c, tty))
+				tty->column++;
+		}
 		break;
 	}
 
@@ -425,7 +427,9 @@ static ssize_t process_output_block(struct tty_struct *tty,
 		nr = space;
 
 	for (i = 0, cp = buf; i < nr; i++, cp++) {
-		switch (*cp) {
+		unsigned char c = *cp;
+
+		switch (c) {
 		case '\n':
 			if (O_ONLRET(tty))
 				tty->column = 0;
@@ -447,10 +451,12 @@ static ssize_t process_output_block(struct tty_struct *tty,
 				tty->column--;
 			break;
 		default:
-			if (O_OLCUC(tty))
-				goto break_out;
-			if (!iscntrl(*cp))
-				tty->column++;
+			if (!iscntrl(c)) {
+				if (O_OLCUC(tty))
+					goto break_out;
+				if (!is_continuation(c, tty))
+					tty->column++;
+			}
 			break;
 		}
 	}

