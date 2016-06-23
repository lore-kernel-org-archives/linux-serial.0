From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/16] tty: vt, separate T.416 high colors handler
Date: Thu, 23 Jun 2016 13:34:31 +0200
Message-ID: <20160623113437.28416-10-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

The code with T.416 high colors handling is flushed to the right and
hard to read. Move the code to a separate function and remove code
duplication for foreground & background colors.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 85 +++++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 6e12d9c0ea41..da49f5cfa654 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1284,6 +1284,40 @@ static void rgb_background(struct vc_data *vc, struct rgb c)
 		| (c.r&0x80) >> 1 | (c.g&0x80) >> 2 | (c.b&0x80) >> 3;
 }
 
+/*
+ * ITU T.416 Higher colour modes. They break the usual properties of SGR codes
+ * and thus need to be detected and ignored by hand. Strictly speaking, that
+ * standard also wants : rather than ; as separators, contrary to ECMA-48, but
+ * no one produces such codes and almost no one accepts them.
+ *
+ * Subcommands 3 (CMY) and 4 (CMYK) are so insane there's no point in
+ * supporting them.
+ */
+static int vc_t416_color(struct vc_data *vc, int i,
+		void(*set_color)(struct vc_data *vc, struct rgb c))
+{
+	i++;
+	if (i > vc->vc_npar)
+		return i;
+
+	if (vc->vc_par[i] == 5 && i < vc->vc_npar) {
+		/* 256 colours -- ubiquitous */
+		i++;
+		set_color(vc, rgb_from_256(vc->vc_par[i]));
+	} else if (vc->vc_par[i] == 2 && i <= vc->vc_npar + 3) {
+		/* 24 bit -- extremely rare */
+		struct rgb c = {
+			.r = vc->vc_par[i + 1],
+			.g = vc->vc_par[i + 2],
+			.b = vc->vc_par[i + 3],
+		};
+		set_color(vc, c);
+		i += 3;
+	}
+
+	return i;
+}
+
 /* console_lock is held */
 static void csi_m(struct vc_data *vc)
 {
@@ -1355,56 +1389,11 @@ static void csi_m(struct vc_data *vc)
 			case 27:
 				vc->vc_reverse = 0;
 				break;
-			case 38: /* ITU T.416
-				  * Higher colour modes.
-				  * They break the usual properties of SGR codes
-				  * and thus need to be detected and ignored by
-				  * hand.  Strictly speaking, that standard also
-				  * wants : rather than ; as separators, contrary
-				  * to ECMA-48, but no one produces such codes
-				  * and almost no one accepts them.
-				  */
-				i++;
-				if (i > vc->vc_npar)
-					break;
-				if (vc->vc_par[i] == 5 &&  /* 256 colours */
-				    i < vc->vc_npar) {     /* ubiquitous */
-					i++;
-					rgb_foreground(vc,
-						rgb_from_256(vc->vc_par[i]));
-				} else if (vc->vc_par[i] == 2 &&  /* 24 bit */
-				           i <= vc->vc_npar + 3) {/* extremely rare */
-					struct rgb c = {
-						.r = vc->vc_par[i + 1],
-						.g = vc->vc_par[i + 2],
-						.b = vc->vc_par[i + 3],
-					};
-					rgb_foreground(vc, c);
-					i += 3;
-				}
-				/* Subcommands 3 (CMY) and 4 (CMYK) are so insane
-				 * there's no point in supporting them.
-				 */
+			case 38:
+				i = vc_t416_color(vc, i, rgb_foreground);
 				break;
 			case 48:
-				i++;
-				if (i > vc->vc_npar)
-					break;
-				if (vc->vc_par[i] == 5 &&  /* 256 colours */
-				    i < vc->vc_npar) {
-					i++;
-					rgb_background(vc,
-						rgb_from_256(vc->vc_par[i]));
-				} else if (vc->vc_par[i] == 2 && /* 24 bit */
-				           i <= vc->vc_npar + 3) {
-					struct rgb c = {
-						.r = vc->vc_par[i + 1],
-						.g = vc->vc_par[i + 2],
-						.b = vc->vc_par[i + 3],
-					};
-					rgb_background(vc, c);
-					i += 3;
-				}
+				i = vc_t416_color(vc, i, rgb_background);
 				break;
 			case 39:
 				vc->vc_color = (vc->vc_def_color & 0x0f) | (vc->vc_color & 0xf0);
-- 
2.9.0
