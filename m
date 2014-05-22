From: Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH] vt: emulate 8- and 24-bit colour codes.
Date: Fri, 23 May 2014 01:33:08 +0200
Message-ID: <1400801588-11590-1-git-send-email-kilobyte@angband.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:55920 "EHLO
	tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbaEWAR7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 May 2014 20:17:59 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Adam Borowski <kilobyte@angband.pl>

Most other mainstream terminals support "xterm256" colours, which means
people sometimes use these blindly without checking capabilities.

Because of hardware limitations of VGA consoles, colours are downgraded to
16 foregrounds and 8 backgrounds.  On fbdev consoles it would be possible
to support them without quality loss, but adding that would require quite a
large amount of code.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3ad0b61..5149a72 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1231,6 +1231,52 @@ static void default_attr(struct vc_data *vc)
 	vc->vc_color = vc->vc_def_color;
 }
 
+struct rgb { u8 r; u8 g; u8 b; };
+
+struct rgb rgb_from_256(int i)
+{
+	struct rgb c;
+	if (i < 8) {            /* Standard colours. */
+		c.r = i&1 ? 0xaa : 0x00;
+		c.g = i&2 ? 0xaa : 0x00;
+		c.b = i&4 ? 0xaa : 0x00;
+	} else if (i < 16) {
+		c.r = i&1 ? 0xff : 0x55;
+		c.g = i&2 ? 0xff : 0x55;
+		c.b = i&4 ? 0xff : 0x55;
+	} else if (i < 232) {   /* 6x6x6 colour cube. */
+		c.r = (i - 16) / 36 * 85 / 2;
+		c.g = (i - 16) / 6 % 6 * 85 / 2;
+		c.b = (i - 16) % 6 * 85 / 2;
+	} else                  /* Grayscale ramp. */
+		c.r = c.g = c.b = i * 10 - 2312;
+	return c;
+}
+
+static void rgb_foreground(struct vc_data *vc, struct rgb c)
+{
+	u8 hue, max = c.r;
+	if (c.g > max)
+		max = c.g;
+	if (c.b > max)
+		max = c.b;
+	hue = (c.r > max/2 ? 4 : 0)
+	    | (c.g > max/2 ? 2 : 0)
+	    | (c.b > max/2 ? 1 : 0);
+	if (hue == 7 && max <= 0x55)
+		hue = 0, vc->vc_intensity = 2;
+	else
+		vc->vc_intensity = (max > 0xaa) + 1;
+	vc->vc_color = (vc->vc_color & 0xf0) | hue;
+}
+
+static void rgb_background(struct vc_data *vc, struct rgb c)
+{
+	/* For backgrounds, err on the dark side. */
+	vc->vc_color = (vc->vc_color & 0x0f)
+		| (c.r&0x80) >> 1 | (c.g&0x80) >> 2 | (c.b&0x80) >> 3;
+}
+
 /* console_lock is held */
 static void csi_m(struct vc_data *vc)
 {
@@ -1302,8 +1348,7 @@ static void csi_m(struct vc_data *vc)
 			case 27:
 				vc->vc_reverse = 0;
 				break;
-			case 38:
-			case 48: /* ITU T.416
+			case 38: /* ITU T.416
 				  * Higher colour modes.
 				  * They break the usual properties of SGR codes
 				  * and thus need to be detected and ignored by
@@ -1315,15 +1360,41 @@ static void csi_m(struct vc_data *vc)
 				i++;
 				if (i > vc->vc_npar)
 					break;
-				if (vc->vc_par[i] == 5)      /* 256 colours */
-					i++;                 /* ubiquitous */
-				else if (vc->vc_par[i] == 2) /* 24 bit colours */
-					i += 3;              /* extremely rare */
+				if (vc->vc_par[i] == 5 &&  /* 256 colours */
+				    i < vc->vc_npar) {     /* ubiquitous */
+					i++;
+					rgb_foreground(vc,
+						rgb_from_256(vc->vc_par[i]));
+				} else if (vc->vc_par[i] == 2 &&  /* 24 bit */
+				           i <= vc->vc_npar + 3) {/* extremely rare */
+					struct rgb c = {r:vc->vc_par[i+1],
+							g:vc->vc_par[i+2],
+							b:vc->vc_par[i+3]};
+					rgb_foreground(vc, c);
+					i += 3;
+				}
 				/* Subcommands 3 (CMY) and 4 (CMYK) are so insane
-				 * that detecting them is not worth the few extra
-				 * bytes of kernel's size.
+				 * there's no point in supporting them.
 				 */
 				break;
+			case 48:
+				i++;
+				if (i > vc->vc_npar)
+					break;
+				if (vc->vc_par[i] == 5 &&  /* 256 colours */
+				    i < vc->vc_npar) {
+					i++;
+					rgb_background(vc,
+						rgb_from_256(vc->vc_par[i]));
+				} else if (vc->vc_par[i] == 2 && /* 24 bit */
+				           i <= vc->vc_npar + 3) {
+					struct rgb c = {r:vc->vc_par[i+1],
+							g:vc->vc_par[i+2],
+							b:vc->vc_par[i+3]};
+					rgb_background(vc, c);
+					i += 3;
+				}
+				break;
 			case 39:
 				vc->vc_color = (vc->vc_def_color & 0x0f) | (vc->vc_color & 0xf0);
 				break;
-- 
2.0.0.rc4

