From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/16] tty: vt, too many commands per line in rgb_foreground
Date: Thu, 23 Jun 2016 13:34:33 +0200
Message-ID: <20160623113437.28416-12-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Do not opencode max3, use the macro.

Separate commands. Until now, I have not noticed the comma. Make it
one line, one command. And make the code obvious.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 63972336de20..acecd6662426 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1260,18 +1260,23 @@ static void rgb_from_256(int i, struct rgb *c)
 
 static void rgb_foreground(struct vc_data *vc, const struct rgb *c)
 {
-	u8 hue, max = c->r;
-	if (c->g > max)
-		max = c->g;
-	if (c->b > max)
-		max = c->b;
-	hue = (c->r > max/2 ? 4 : 0)
-	    | (c->g > max/2 ? 2 : 0)
-	    | (c->b > max/2 ? 1 : 0);
-	if (hue == 7 && max <= 0x55)
-		hue = 0, vc->vc_intensity = 2;
+	u8 hue = 0, max = max3(c->r, c->g, c->b);
+
+	if (c->r > max / 2)
+		hue |= 4;
+	if (c->g > max / 2)
+		hue |= 2;
+	if (c->b > max / 2)
+		hue |= 1;
+
+	if (hue == 7 && max <= 0x55) {
+		hue = 0;
+		vc->vc_intensity = 2;
+	} else if (max > 0xaa)
+		vc->vc_intensity = 2;
 	else
-		vc->vc_intensity = (max > 0xaa) + 1;
+		vc->vc_intensity = 1;
+
 	vc->vc_color = (vc->vc_color & 0xf0) | hue;
 }
 
-- 
2.9.0
