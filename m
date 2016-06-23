From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/16] tty: vt, do not pass structure over stack
Date: Thu, 23 Jun 2016 13:34:32 +0200
Message-ID: <20160623113437.28416-11-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

The compiler noticed passing structure over stack. Even though rgb is
a small structure, let us define one and pass that over all the
functions wherever needed.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 66 ++++++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index da49f5cfa654..63972336de20 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1240,36 +1240,34 @@ static void default_attr(struct vc_data *vc)
 
 struct rgb { u8 r; u8 g; u8 b; };
 
-static struct rgb rgb_from_256(int i)
+static void rgb_from_256(int i, struct rgb *c)
 {
-	struct rgb c;
 	if (i < 8) {            /* Standard colours. */
-		c.r = i&1 ? 0xaa : 0x00;
-		c.g = i&2 ? 0xaa : 0x00;
-		c.b = i&4 ? 0xaa : 0x00;
+		c->r = i&1 ? 0xaa : 0x00;
+		c->g = i&2 ? 0xaa : 0x00;
+		c->b = i&4 ? 0xaa : 0x00;
 	} else if (i < 16) {
-		c.r = i&1 ? 0xff : 0x55;
-		c.g = i&2 ? 0xff : 0x55;
-		c.b = i&4 ? 0xff : 0x55;
+		c->r = i&1 ? 0xff : 0x55;
+		c->g = i&2 ? 0xff : 0x55;
+		c->b = i&4 ? 0xff : 0x55;
 	} else if (i < 232) {   /* 6x6x6 colour cube. */
-		c.r = (i - 16) / 36 * 85 / 2;
-		c.g = (i - 16) / 6 % 6 * 85 / 2;
-		c.b = (i - 16) % 6 * 85 / 2;
+		c->r = (i - 16) / 36 * 85 / 2;
+		c->g = (i - 16) / 6 % 6 * 85 / 2;
+		c->b = (i - 16) % 6 * 85 / 2;
 	} else                  /* Grayscale ramp. */
-		c.r = c.g = c.b = i * 10 - 2312;
-	return c;
+		c->r = c->g = c->b = i * 10 - 2312;
 }
 
-static void rgb_foreground(struct vc_data *vc, struct rgb c)
+static void rgb_foreground(struct vc_data *vc, const struct rgb *c)
 {
-	u8 hue, max = c.r;
-	if (c.g > max)
-		max = c.g;
-	if (c.b > max)
-		max = c.b;
-	hue = (c.r > max/2 ? 4 : 0)
-	    | (c.g > max/2 ? 2 : 0)
-	    | (c.b > max/2 ? 1 : 0);
+	u8 hue, max = c->r;
+	if (c->g > max)
+		max = c->g;
+	if (c->b > max)
+		max = c->b;
+	hue = (c->r > max/2 ? 4 : 0)
+	    | (c->g > max/2 ? 2 : 0)
+	    | (c->b > max/2 ? 1 : 0);
 	if (hue == 7 && max <= 0x55)
 		hue = 0, vc->vc_intensity = 2;
 	else
@@ -1277,11 +1275,11 @@ static void rgb_foreground(struct vc_data *vc, struct rgb c)
 	vc->vc_color = (vc->vc_color & 0xf0) | hue;
 }
 
-static void rgb_background(struct vc_data *vc, struct rgb c)
+static void rgb_background(struct vc_data *vc, const struct rgb *c)
 {
 	/* For backgrounds, err on the dark side. */
 	vc->vc_color = (vc->vc_color & 0x0f)
-		| (c.r&0x80) >> 1 | (c.g&0x80) >> 2 | (c.b&0x80) >> 3;
+		| (c->r&0x80) >> 1 | (c->g&0x80) >> 2 | (c->b&0x80) >> 3;
 }
 
 /*
@@ -1294,8 +1292,10 @@ static void rgb_background(struct vc_data *vc, struct rgb c)
  * supporting them.
  */
 static int vc_t416_color(struct vc_data *vc, int i,
-		void(*set_color)(struct vc_data *vc, struct rgb c))
+		void(*set_color)(struct vc_data *vc, const struct rgb *c))
 {
+	struct rgb c;
+
 	i++;
 	if (i > vc->vc_npar)
 		return i;
@@ -1303,17 +1303,17 @@ static int vc_t416_color(struct vc_data *vc, int i,
 	if (vc->vc_par[i] == 5 && i < vc->vc_npar) {
 		/* 256 colours -- ubiquitous */
 		i++;
-		set_color(vc, rgb_from_256(vc->vc_par[i]));
+		rgb_from_256(vc->vc_par[i], &c);
 	} else if (vc->vc_par[i] == 2 && i <= vc->vc_npar + 3) {
 		/* 24 bit -- extremely rare */
-		struct rgb c = {
-			.r = vc->vc_par[i + 1],
-			.g = vc->vc_par[i + 2],
-			.b = vc->vc_par[i + 3],
-		};
-		set_color(vc, c);
+		c.r = vc->vc_par[i + 1];
+		c.g = vc->vc_par[i + 2];
+		c.b = vc->vc_par[i + 3];
 		i += 3;
-	}
+	} else
+		return i;
+
+	set_color(vc, &c);
 
 	return i;
 }
-- 
2.9.0
