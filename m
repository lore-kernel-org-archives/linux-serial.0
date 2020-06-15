Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4EBC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244102067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgFOHtT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:40054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgFOHtS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49ACAB021;
        Mon, 15 Jun 2020 07:49:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/38] vt: separate unicode handling into vc_translate_unicode
Date:   Mon, 15 Jun 2020 09:48:44 +0200
Message-Id: <20200615074910.19267-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

do_con_write is complicated enough. Extract unicode handling to a
separate function. For do_con_write, 249 LOCs lowered to 183 lines.

Use diff -w -b to see the difference is neligible -- mostly whitespace
and use of 'return's instead of 'continue's.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 149 ++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 68 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a9e4924fa675..caaad820413a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2572,6 +2572,85 @@ static inline int vc_translate_ascii(const struct vc_data *vc, int c)
 	return c;
 }
 
+/**
+ * vc_translate_unicode -- Combine UTF-8 into Unicode in @vc_utf_char
+ *
+ * @vc_utf_char is the being-constructed unicode character.
+ * @vc_utf_count is the number of continuation bytes still expected to arrive.
+ * @vc_npar is the number of continuation bytes arrived so far.
+ */
+static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
+{
+	static const u32 utf8_length_changes[] = {
+		0x0000007f, 0x000007ff, 0x0000ffff,
+		0x001fffff, 0x03ffffff, 0x7fffffff
+	};
+
+	if ((c & 0xc0) == 0x80) {
+		/* Continuation byte received */
+		if (vc->vc_utf_count) {
+			vc->vc_utf_char = (vc->vc_utf_char << 6) | (c & 0x3f);
+			vc->vc_npar++;
+			if (--vc->vc_utf_count) {
+				/* Still need some bytes */
+				return -1;
+			}
+			/* Got a whole character */
+			c = vc->vc_utf_char;
+			/* Reject overlong sequences */
+			if (c <= utf8_length_changes[vc->vc_npar - 1] ||
+					c > utf8_length_changes[vc->vc_npar])
+				return 0xfffd;
+		} else {
+			/* Unexpected continuation byte */
+			vc->vc_utf_count = 0;
+			return 0xfffd;
+		}
+	} else {
+		/* Single ASCII byte or first byte of a sequence received */
+		if (vc->vc_utf_count) {
+			/* Continuation byte expected */
+			*rescan = true;
+			vc->vc_utf_count = 0;
+			return 0xfffd;
+		} else if (c > 0x7f) {
+			/* First byte of a multibyte sequence received */
+			vc->vc_npar = 0;
+			if ((c & 0xe0) == 0xc0) {
+				vc->vc_utf_count = 1;
+				vc->vc_utf_char = (c & 0x1f);
+			} else if ((c & 0xf0) == 0xe0) {
+				vc->vc_utf_count = 2;
+				vc->vc_utf_char = (c & 0x0f);
+			} else if ((c & 0xf8) == 0xf0) {
+				vc->vc_utf_count = 3;
+				vc->vc_utf_char = (c & 0x07);
+			} else if ((c & 0xfc) == 0xf8) {
+				vc->vc_utf_count = 4;
+				vc->vc_utf_char = (c & 0x03);
+			} else if ((c & 0xfe) == 0xfc) {
+				vc->vc_utf_count = 5;
+				vc->vc_utf_char = (c & 0x01);
+			} else {
+				/* 254 and 255 are invalid */
+				return 0xfffd;
+			}
+			if (vc->vc_utf_count) {
+				/* Still need some bytes */
+				return -1;
+			}
+		}
+		/* Nothing to do if an ASCII byte was received */
+	}
+	/* End of UTF-8 decoding. */
+	/* c is the received character, or U+FFFD for invalid sequences. */
+	/* Replace invalid Unicode code points with U+FFFD too */
+	if ((c >= 0xd800 && c <= 0xdfff) || c == 0xfffe || c == 0xffff)
+		return 0xfffd;
+
+	return c;
+}
+
 /* acquires console_lock */
 static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
@@ -2628,76 +2707,10 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 		if (vc->vc_state != ESnormal) {
 			tc = c;
 		} else if (vc->vc_utf && !vc->vc_disp_ctrl) {
-		    /* Combine UTF-8 into Unicode in vc_utf_char.
-		     * vc_utf_count is the number of continuation bytes still
-		     * expected to arrive.
-		     * vc_npar is the number of continuation bytes arrived so
-		     * far
-		     */
 rescan_last_byte:
-		    if ((c & 0xc0) == 0x80) {
-			/* Continuation byte received */
-			static const uint32_t utf8_length_changes[] = { 0x0000007f, 0x000007ff, 0x0000ffff, 0x001fffff, 0x03ffffff, 0x7fffffff };
-			if (vc->vc_utf_count) {
-			    vc->vc_utf_char = (vc->vc_utf_char << 6) | (c & 0x3f);
-			    vc->vc_npar++;
-			    if (--vc->vc_utf_count) {
-				/* Still need some bytes */
-				continue;
-			    }
-			    /* Got a whole character */
-			    c = vc->vc_utf_char;
-			    /* Reject overlong sequences */
-			    if (c <= utf8_length_changes[vc->vc_npar - 1] ||
-					c > utf8_length_changes[vc->vc_npar])
-				c = 0xfffd;
-			} else {
-			    /* Unexpected continuation byte */
-			    vc->vc_utf_count = 0;
-			    c = 0xfffd;
-			}
-		    } else {
-			/* Single ASCII byte or first byte of a sequence received */
-			if (vc->vc_utf_count) {
-			    /* Continuation byte expected */
-			    rescan = true;
-			    vc->vc_utf_count = 0;
-			    c = 0xfffd;
-			} else if (c > 0x7f) {
-			    /* First byte of a multibyte sequence received */
-			    vc->vc_npar = 0;
-			    if ((c & 0xe0) == 0xc0) {
-				vc->vc_utf_count = 1;
-				vc->vc_utf_char = (c & 0x1f);
-			    } else if ((c & 0xf0) == 0xe0) {
-				vc->vc_utf_count = 2;
-				vc->vc_utf_char = (c & 0x0f);
-			    } else if ((c & 0xf8) == 0xf0) {
-				vc->vc_utf_count = 3;
-				vc->vc_utf_char = (c & 0x07);
-			    } else if ((c & 0xfc) == 0xf8) {
-				vc->vc_utf_count = 4;
-				vc->vc_utf_char = (c & 0x03);
-			    } else if ((c & 0xfe) == 0xfc) {
-				vc->vc_utf_count = 5;
-				vc->vc_utf_char = (c & 0x01);
-			    } else {
-				/* 254 and 255 are invalid */
-				c = 0xfffd;
-			    }
-			    if (vc->vc_utf_count) {
-				/* Still need some bytes */
+			tc = c = vc_translate_unicode(vc, c, &rescan);
+			if (tc == -1)
 				continue;
-			    }
-			}
-			/* Nothing to do if an ASCII byte was received */
-		    }
-		    /* End of UTF-8 decoding. */
-		    /* c is the received character, or U+FFFD for invalid sequences. */
-		    /* Replace invalid Unicode code points with U+FFFD too */
-		    if ((c >= 0xd800 && c <= 0xdfff) || c == 0xfffe || c == 0xffff)
-			c = 0xfffd;
-		    tc = c;
 		} else {	/* no utf or alternate charset mode */
 			tc = vc_translate_ascii(vc, c);
 		}
-- 
2.27.0

