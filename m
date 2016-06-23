From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/16] vt: remove lines parameter from scrollback
Date: Thu, 23 Jun 2016 13:34:23 +0200
Message-ID: <20160623113437.28416-2-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

It is always called with 0, so remove the parameter and pass the
default down to scrolldelta without checking.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 2 +-
 drivers/tty/vt/vt.c       | 6 ++----
 include/linux/vt_kern.h   | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index e75490177725..5b23d23c63d6 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -579,7 +579,7 @@ static void fn_scroll_forw(struct vc_data *vc)
 
 static void fn_scroll_back(struct vc_data *vc)
 {
-	scrollback(vc, 0);
+	scrollback(vc);
 }
 
 static void fn_show_mem(struct vc_data *vc)
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index dc125322f48f..abc79ae19079 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1102,11 +1102,9 @@ static void gotoxay(struct vc_data *vc, int new_x, int new_y)
 	gotoxy(vc, new_x, vc->vc_decom ? (vc->vc_top + new_y) : new_y);
 }
 
-void scrollback(struct vc_data *vc, int lines)
+void scrollback(struct vc_data *vc)
 {
-	if (!lines)
-		lines = vc->vc_rows / 2;
-	scrolldelta(-lines);
+	scrolldelta(-(vc->vc_rows / 2));
 }
 
 void scrollfront(struct vc_data *vc, int lines)
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index 8d7634247fb4..160f81fe3eb8 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -45,7 +45,7 @@ void poke_blanked_console(void);
 int con_font_op(struct vc_data *vc, struct console_font_op *op);
 int con_set_cmap(unsigned char __user *cmap);
 int con_get_cmap(unsigned char __user *cmap);
-void scrollback(struct vc_data *vc, int lines);
+void scrollback(struct vc_data *vc);
 void scrollfront(struct vc_data *vc, int lines);
 void clear_buffer_attributes(struct vc_data *vc);
 void update_region(struct vc_data *vc, unsigned long start, int count);
-- 
2.9.0
