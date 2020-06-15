Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586C5C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C312067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgFOHtQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbgFOHtP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 821CEAFF9;
        Mon, 15 Jun 2020 07:49:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/38] vt: use tty_insert_flip_string in respond_string
Date:   Mon, 15 Jun 2020 09:48:40 +0200
Message-Id: <20200615074910.19267-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Pass the length of a string to respond_string and use
tty_insert_flip_string instead of a loop with tty_insert_flip_char. This
simplifies the processing on the tty side.

The added strlens are optimized during constant folding and propagation
and the result are proper constants in assembly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3adb7f409524..49c9d1e4067c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1809,40 +1809,43 @@ static void csi_m(struct vc_data *vc)
 	update_attr(vc);
 }
 
-static void respond_string(const char *p, struct tty_port *port)
+static void respond_string(const char *p, size_t len, struct tty_port *port)
 {
-	while (*p) {
-		tty_insert_flip_char(port, *p, 0);
-		p++;
-	}
+	tty_insert_flip_string(port, p, len);
 	tty_schedule_flip(port);
 }
 
 static void cursor_report(struct vc_data *vc, struct tty_struct *tty)
 {
 	char buf[40];
+	int len;
 
-	sprintf(buf, "\033[%d;%dR", vc->state.y + (vc->vc_decom ? vc->vc_top + 1 : 1), vc->state.x + 1);
-	respond_string(buf, tty->port);
+	len = sprintf(buf, "\033[%d;%dR", vc->state.y +
+			(vc->vc_decom ? vc->vc_top + 1 : 1),
+			vc->state.x + 1);
+	respond_string(buf, len, tty->port);
 }
 
 static inline void status_report(struct tty_struct *tty)
 {
-	respond_string("\033[0n", tty->port);	/* Terminal ok */
+	static const char teminal_ok[] = "\033[0n";
+
+	respond_string(teminal_ok, strlen(teminal_ok), tty->port);
 }
 
 static inline void respond_ID(struct tty_struct *tty)
 {
-	respond_string(VT102ID, tty->port);
+	respond_string(VT102ID, strlen(VT102ID), tty->port);
 }
 
 void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 {
 	char buf[8];
+	int len;
 
-	sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt), (char)('!' + mrx),
-		(char)('!' + mry));
-	respond_string(buf, tty->port);
+	len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
+			(char)('!' + mrx), (char)('!' + mry));
+	respond_string(buf, len, tty->port);
 }
 
 /* invoked via ioctl(TIOCLINUX) and through set_selection_user */
-- 
2.27.0

