From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] tty: vt, fix bogus division in csi_J
Date: Mon,  3 Oct 2016 11:00:17 +0200
Message-ID: <20161003090017.16090-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, =?UTF-8?q?Petr=20P=C3=ADsa=C5=99?= <ppisar@redhat.com>
List-Id: linux-serial@vger.kernel.org

In csi_J(3), the third parameter of scr_memsetw (vc_screenbuf_size) is
divided by 2 inappropriatelly. But scr_memsetw expects size, not
count, because it divides the size by 2 on its own before doing actual
memset-by-words.

So remove the bogus division.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Petr Písař <ppisar@redhat.com>
Fixes: f8df13e0a9 (tty: Clean console safely)
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 6b55078bda3f..e2cad4c2ba5a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1176,7 +1176,7 @@ static void csi_J(struct vc_data *vc, int vpar)
 			break;
 		case 3: /* erase scroll-back buffer (and whole display) */
 			scr_memsetw(vc->vc_screenbuf, vc->vc_video_erase_char,
-				    vc->vc_screenbuf_size >> 1);
+				    vc->vc_screenbuf_size);
 			set_origin(vc);
 			if (con_is_visible(vc))
 				update_screen(vc);
-- 
2.10.0
