From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/7] tty: vt, rename variables to sane names
Date: Mon,  3 Oct 2016 11:18:37 +0200
Message-ID: <20161003091839.29379-5-jslaby@suse.cz>
References: <20161003091839.29379-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161003091839.29379-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

This makes the code understandable at least. No functional changes.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3cd999ef5257..d26b6303647d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4283,7 +4283,7 @@ void vc_scrolldelta_helper(struct vc_data *c, int lines,
 	ptrdiff_t vorigin = (void *)c->vc_visible_origin - base;
 	ptrdiff_t origin = (void *)c->vc_origin - base;
 	int margin = c->vc_size_row * 4;
-	int ul, we, p, st;
+	int from, wrap, from_off, avail;
 
 	/* Turn scrollback off */
 	if (!lines) {
@@ -4293,25 +4293,25 @@ void vc_scrolldelta_helper(struct vc_data *c, int lines,
 
 	/* Do we have already enough to allow jumping from 0 to the end? */
 	if (rolled_over > scr_end + margin) {
-		ul = scr_end;
-		we = rolled_over + c->vc_size_row;
+		from = scr_end;
+		wrap = rolled_over + c->vc_size_row;
 	} else {
-		ul = 0;
-		we = size;
+		from = 0;
+		wrap = size;
 	}
 
-	p = (vorigin - ul + we) % we + lines * c->vc_size_row;
-	st = (origin - ul + we) % we;
+	from_off = (vorigin - from + wrap) % wrap + lines * c->vc_size_row;
+	avail = (origin - from + wrap) % wrap;
 
 	/* Only a little piece would be left? Show all incl. the piece! */
-	if (st < 2 * margin)
+	if (avail < 2 * margin)
 		margin = 0;
-	if (p < margin)
-		p = 0;
-	if (p > st - margin)
-		p = st;
+	if (from_off < margin)
+		from_off = 0;
+	if (from_off > avail - margin)
+		from_off = avail;
 
-	c->vc_visible_origin = ubase + (p + ul) % we;
+	c->vc_visible_origin = ubase + (from + from_off) % wrap;
 }
 EXPORT_SYMBOL_GPL(vc_scrolldelta_helper);
 
-- 
2.10.0
