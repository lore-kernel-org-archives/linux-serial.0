Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B491C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642A02068E
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgFOHut (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:50:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:40056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgFOHtS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 700B4B023;
        Mon, 15 Jun 2020 07:49:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/38] vt: rearrange vc_translate_unicode
Date:   Mon, 15 Jun 2020 09:48:45 +0200
Message-Id: <20200615074910.19267-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The code was too overcomplicated. Extract vc_sanitize_unicode to a
separate function and flatten the code. I believe the code is
straightforward now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 121 +++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 57 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index caaad820413a..5004242d601b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2572,6 +2572,19 @@ static inline int vc_translate_ascii(const struct vc_data *vc, int c)
 	return c;
 }
 
+
+/**
+ * vc_sanitize_unicode -- Replace invalid Unicode code points with U+FFFD
+ * @c: the received character, or U+FFFD for invalid sequences.
+ */
+static inline int vc_sanitize_unicode(const int c)
+{
+	if ((c >= 0xd800 && c <= 0xdfff) || c == 0xfffe || c == 0xffff)
+		return 0xfffd;
+
+	return c;
+}
+
 /**
  * vc_translate_unicode -- Combine UTF-8 into Unicode in @vc_utf_char
  *
@@ -2586,69 +2599,63 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 		0x001fffff, 0x03ffffff, 0x7fffffff
 	};
 
+	/* Continuation byte received */
 	if ((c & 0xc0) == 0x80) {
-		/* Continuation byte received */
-		if (vc->vc_utf_count) {
-			vc->vc_utf_char = (vc->vc_utf_char << 6) | (c & 0x3f);
-			vc->vc_npar++;
-			if (--vc->vc_utf_count) {
-				/* Still need some bytes */
-				return -1;
-			}
-			/* Got a whole character */
-			c = vc->vc_utf_char;
-			/* Reject overlong sequences */
-			if (c <= utf8_length_changes[vc->vc_npar - 1] ||
-					c > utf8_length_changes[vc->vc_npar])
-				return 0xfffd;
-		} else {
-			/* Unexpected continuation byte */
-			vc->vc_utf_count = 0;
+		/* Unexpected continuation byte? */
+		if (!vc->vc_utf_count)
 			return 0xfffd;
-		}
-	} else {
-		/* Single ASCII byte or first byte of a sequence received */
-		if (vc->vc_utf_count) {
-			/* Continuation byte expected */
-			*rescan = true;
-			vc->vc_utf_count = 0;
+
+		vc->vc_utf_char = (vc->vc_utf_char << 6) | (c & 0x3f);
+		vc->vc_npar++;
+		if (--vc->vc_utf_count)
+			goto need_more_bytes;
+
+		/* Got a whole character */
+		c = vc->vc_utf_char;
+		/* Reject overlong sequences */
+		if (c <= utf8_length_changes[vc->vc_npar - 1] ||
+				c > utf8_length_changes[vc->vc_npar])
 			return 0xfffd;
-		} else if (c > 0x7f) {
-			/* First byte of a multibyte sequence received */
-			vc->vc_npar = 0;
-			if ((c & 0xe0) == 0xc0) {
-				vc->vc_utf_count = 1;
-				vc->vc_utf_char = (c & 0x1f);
-			} else if ((c & 0xf0) == 0xe0) {
-				vc->vc_utf_count = 2;
-				vc->vc_utf_char = (c & 0x0f);
-			} else if ((c & 0xf8) == 0xf0) {
-				vc->vc_utf_count = 3;
-				vc->vc_utf_char = (c & 0x07);
-			} else if ((c & 0xfc) == 0xf8) {
-				vc->vc_utf_count = 4;
-				vc->vc_utf_char = (c & 0x03);
-			} else if ((c & 0xfe) == 0xfc) {
-				vc->vc_utf_count = 5;
-				vc->vc_utf_char = (c & 0x01);
-			} else {
-				/* 254 and 255 are invalid */
-				return 0xfffd;
-			}
-			if (vc->vc_utf_count) {
-				/* Still need some bytes */
-				return -1;
-			}
-		}
-		/* Nothing to do if an ASCII byte was received */
+
+		return vc_sanitize_unicode(c);
 	}
-	/* End of UTF-8 decoding. */
-	/* c is the received character, or U+FFFD for invalid sequences. */
-	/* Replace invalid Unicode code points with U+FFFD too */
-	if ((c >= 0xd800 && c <= 0xdfff) || c == 0xfffe || c == 0xffff)
+
+	/* Single ASCII byte or first byte of a sequence received */
+	if (vc->vc_utf_count) {
+		/* Continuation byte expected */
+		*rescan = true;
+		vc->vc_utf_count = 0;
 		return 0xfffd;
+	}
 
-	return c;
+	/* Nothing to do if an ASCII byte was received */
+	if (c <= 0x7f)
+		return c;
+
+	/* First byte of a multibyte sequence received */
+	vc->vc_npar = 0;
+	if ((c & 0xe0) == 0xc0) {
+		vc->vc_utf_count = 1;
+		vc->vc_utf_char = (c & 0x1f);
+	} else if ((c & 0xf0) == 0xe0) {
+		vc->vc_utf_count = 2;
+		vc->vc_utf_char = (c & 0x0f);
+	} else if ((c & 0xf8) == 0xf0) {
+		vc->vc_utf_count = 3;
+		vc->vc_utf_char = (c & 0x07);
+	} else if ((c & 0xfc) == 0xf8) {
+		vc->vc_utf_count = 4;
+		vc->vc_utf_char = (c & 0x03);
+	} else if ((c & 0xfe) == 0xfc) {
+		vc->vc_utf_count = 5;
+		vc->vc_utf_char = (c & 0x01);
+	} else {
+		/* 254 and 255 are invalid */
+		return 0xfffd;
+	}
+
+need_more_bytes:
+	return -1;
 }
 
 /* acquires console_lock */
-- 
2.27.0

