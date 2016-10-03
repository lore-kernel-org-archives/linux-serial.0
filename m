From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/7] tty: vt, compute vc offsets in advance
Date: Mon,  3 Oct 2016 11:18:36 +0200
Message-ID: <20161003091839.29379-4-jslaby@suse.cz>
References: <20161003091839.29379-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161003091839.29379-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Only improves readability, no functional changes.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 397c72c2fcb8..3cd999ef5257 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4279,6 +4279,9 @@ void vc_scrolldelta_helper(struct vc_data *c, int lines,
 		unsigned int rolled_over, void *base, unsigned int size)
 {
 	unsigned long ubase = (unsigned long)base;
+	ptrdiff_t scr_end = (void *)c->vc_scr_end - base;
+	ptrdiff_t vorigin = (void *)c->vc_visible_origin - base;
+	ptrdiff_t origin = (void *)c->vc_origin - base;
 	int margin = c->vc_size_row * 4;
 	int ul, we, p, st;
 
@@ -4289,17 +4292,16 @@ void vc_scrolldelta_helper(struct vc_data *c, int lines,
 	}
 
 	/* Do we have already enough to allow jumping from 0 to the end? */
-	if (rolled_over > (c->vc_scr_end - ubase) + margin) {
-		ul = c->vc_scr_end - ubase;
+	if (rolled_over > scr_end + margin) {
+		ul = scr_end;
 		we = rolled_over + c->vc_size_row;
 	} else {
 		ul = 0;
 		we = size;
 	}
 
-	p = (c->vc_visible_origin - ubase - ul + we) % we +
-		lines * c->vc_size_row;
-	st = (c->vc_origin - ubase - ul + we) % we;
+	p = (vorigin - ul + we) % we + lines * c->vc_size_row;
+	st = (origin - ul + we) % we;
 
 	/* Only a little piece would be left? Show all incl. the piece! */
 	if (st < 2 * margin)
-- 
2.10.0
