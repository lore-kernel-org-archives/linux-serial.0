From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 23/48] tty: Clean console safely
Date: Mon, 23 May 2011 12:10:29 -0700
Message-ID: <1306177854-18172-23-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47315 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593Ab1EWTLH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:07 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Petr=20P=C3=ADsa=C5=99?= <ppisar@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>

=46rom: Petr P=C3=ADsa=C5=99 <ppisar@redhat.com>

Traditional \E[2J sequence erases console display but scroll-back
buffer and underlying device (frame) buffer keep data that can be
accessed by scrolling console back.

This patch introduce new \E[J parameter 3 that allows to scramble
scroll-back buffer explicitly. Session locking programs (screen,
vlock) can use it to prevent attacker to browse locked console
history.

Signed-off-by: Petr P=C3=ADsa=C5=99 <ppisar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/vt/vt.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a48da20..b3915b7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1193,6 +1193,13 @@ static void csi_J(struct vc_data *vc, int vpar)
 					      vc->vc_x + 1);
 			}
 			break;
+		case 3: /* erase scroll-back buffer (and whole display) */
+			scr_memsetw(vc->vc_screenbuf, vc->vc_video_erase_char,
+				    vc->vc_screenbuf_size >> 1);
+			set_origin(vc);
+			if (CON_IS_VISIBLE(vc))
+				update_screen(vc);
+			/* fall through */
 		case 2: /* erase whole display */
 			count =3D vc->vc_cols * vc->vc_rows;
 			start =3D (unsigned short *)vc->vc_origin;
--=20
1.7.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
