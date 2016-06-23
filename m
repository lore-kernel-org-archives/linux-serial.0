From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/16] tty: vt, drop VT_BUF_VRAM_ONLY
Date: Thu, 23 Jun 2016 13:34:29 +0200
Message-ID: <20160623113437.28416-8-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

It is never defined. And I spent quite some time looking into the
history and cannot find how this was ever used. Given it was not used
in the history, I doubt it currently works as expected after the years
of changes all over the code.

So kill it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index d5d906051613..600c3bb706a5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -278,12 +278,7 @@ static void notify_update(struct vc_data *vc)
  */
 
 #define IS_FG(vc)	((vc)->vc_num == fg_console)
-
-#ifdef VT_BUF_VRAM_ONLY
-#define DO_UPDATE(vc)	0
-#else
 #define DO_UPDATE(vc)	(CON_IS_VISIBLE(vc) && !console_blanked)
-#endif
 
 static inline unsigned short *screenpos(struct vc_data *vc, int offset, int viewed)
 {
@@ -349,7 +344,6 @@ static void scrdown(struct vc_data *vc, unsigned int t, unsigned int b, int nr)
 
 static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 {
-#ifndef VT_BUF_VRAM_ONLY
 	unsigned int xx, yy, offset;
 	u16 *p;
 
@@ -390,7 +384,6 @@ static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 			start = vc->vc_sw->con_getxy(vc, start, NULL, NULL);
 		}
 	}
-#endif
 }
 
 void update_region(struct vc_data *vc, unsigned long start, int count)
@@ -413,7 +406,6 @@ static u8 build_attr(struct vc_data *vc, u8 _color, u8 _intensity, u8 _blink,
 		return vc->vc_sw->con_build_attr(vc, _color, _intensity,
 		       _blink, _underline, _reverse, _italic);
 
-#ifndef VT_BUF_VRAM_ONLY
 /*
  * ++roman: I completely changed the attribute format for monochrome
  * mode (!can_do_color). The formerly used MDA (monochrome display
@@ -448,9 +440,6 @@ static u8 build_attr(struct vc_data *vc, u8 _color, u8 _intensity, u8 _blink,
 		a <<= 1;
 	return a;
 	}
-#else
-	return 0;
-#endif
 }
 
 static void update_attr(struct vc_data *vc)
@@ -470,10 +459,9 @@ void invert_screen(struct vc_data *vc, int offset, int count, int viewed)
 
 	count /= 2;
 	p = screenpos(vc, offset, viewed);
-	if (vc->vc_sw->con_invert_region)
+	if (vc->vc_sw->con_invert_region) {
 		vc->vc_sw->con_invert_region(vc, p, count);
-#ifndef VT_BUF_VRAM_ONLY
-	else {
+	} else {
 		u16 *q = p;
 		int cnt = count;
 		u16 a;
@@ -501,7 +489,7 @@ void invert_screen(struct vc_data *vc, int offset, int count, int viewed)
 			}
 		}
 	}
-#endif
+
 	if (DO_UPDATE(vc))
 		do_update_region(vc, (unsigned long) p, count);
 	notify_update(vc);
@@ -2178,14 +2166,10 @@ static int is_double_width(uint32_t ucs)
 /* acquires console_lock */
 static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
-#ifdef VT_BUF_VRAM_ONLY
-#define FLUSH do { } while(0);
-#else
 #define FLUSH if (draw_x >= 0) { \
 	vc->vc_sw->con_putcs(vc, (u16 *)draw_from, (u16 *)draw_to - (u16 *)draw_from, vc->vc_y, draw_x); \
 	draw_x = -1; \
 	}
-#endif
 
 	int c, tc, ok, n = 0, draw_x = -1;
 	unsigned int currcons;
-- 
2.9.0
