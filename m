Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0B2C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE3D2067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgFOHtN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgFOHtN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51E84AFB5;
        Mon, 15 Jun 2020 07:49:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/38] vt: introduce enum vc_intensity for intensity
Date:   Mon, 15 Jun 2020 09:48:34 +0200
Message-Id: <20200615074910.19267-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Introduce names (en enum) for 0, 1, and 2 constants. We now have
VCI_HALF_BRIGHT, VCI_NORMAL, and VCI_BOLD instead.

Apart from the cleanup,
1) the enum allows for better type checking, and
2) this saves some code. No more fiddling with bits is needed in
   assembly now. (OTOH, the structure is larger.)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c                     | 32 +++++++++++++------------
 drivers/usb/misc/sisusbvga/sisusb_con.c |  6 ++---
 drivers/video/console/mdacon.c          |  5 ++--
 drivers/video/console/sticon.c          |  3 ++-
 drivers/video/console/vgacon.c          |  9 +++----
 include/linux/console.h                 |  5 +++-
 include/linux/console_struct.h          | 11 +++++++--
 7 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 76f52935e0c8..71bf483e5640 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -705,8 +705,9 @@ void update_region(struct vc_data *vc, unsigned long start, int count)
 
 /* Structure of attributes is hardware-dependent */
 
-static u8 build_attr(struct vc_data *vc, u8 _color, u8 _intensity, u8 _blink,
-    u8 _underline, u8 _reverse, u8 _italic)
+static u8 build_attr(struct vc_data *vc, u8 _color,
+		enum vc_intensity _intensity, u8 _blink, u8 _underline,
+		u8 _reverse, u8 _italic)
 {
 	if (vc->vc_sw->con_build_attr)
 		return vc->vc_sw->con_build_attr(vc, _color, _intensity,
@@ -734,13 +735,13 @@ static u8 build_attr(struct vc_data *vc, u8 _color, u8 _intensity, u8 _blink,
 		a = (a & 0xF0) | vc->vc_itcolor;
 	else if (_underline)
 		a = (a & 0xf0) | vc->vc_ulcolor;
-	else if (_intensity == 0)
+	else if (_intensity == VCI_HALF_BRIGHT)
 		a = (a & 0xf0) | vc->vc_halfcolor;
 	if (_reverse)
 		a = ((a) & 0x88) | ((((a) >> 4) | ((a) << 4)) & 0x77);
 	if (_blink)
 		a ^= 0x80;
-	if (_intensity == 2)
+	if (_intensity == VCI_BOLD)
 		a ^= 0x08;
 	if (vc->vc_hi_font_mask == 0x100)
 		a <<= 1;
@@ -753,8 +754,9 @@ static void update_attr(struct vc_data *vc)
 	vc->vc_attr = build_attr(vc, vc->state.color, vc->state.intensity,
 	              vc->state.blink, vc->state.underline,
 	              vc->state.reverse ^ vc->vc_decscnm, vc->state.italic);
-	vc->vc_video_erase_char = ' ' | (build_attr(vc, vc->state.color, 1,
-				vc->state.blink, 0, vc->vc_decscnm, 0) << 8);
+	vc->vc_video_erase_char = ' ' | (build_attr(vc, vc->state.color,
+				VCI_NORMAL, vc->state.blink, 0, vc->vc_decscnm,
+				0) << 8);
 }
 
 /* Note: inverting the screen twice should revert to the original state */
@@ -1611,7 +1613,7 @@ static void csi_X(struct vc_data *vc, int vpar) /* erase the following vpar posi
 
 static void default_attr(struct vc_data *vc)
 {
-	vc->state.intensity = 1;
+	vc->state.intensity = VCI_NORMAL;
 	vc->state.italic = 0;
 	vc->state.underline = 0;
 	vc->state.reverse = 0;
@@ -1652,11 +1654,11 @@ static void rgb_foreground(struct vc_data *vc, const struct rgb *c)
 
 	if (hue == 7 && max <= 0x55) {
 		hue = 0;
-		vc->state.intensity = 2;
+		vc->state.intensity = VCI_BOLD;
 	} else if (max > 0xaa)
-		vc->state.intensity = 2;
+		vc->state.intensity = VCI_BOLD;
 	else
-		vc->state.intensity = 1;
+		vc->state.intensity = VCI_NORMAL;
 
 	vc->state.color = (vc->state.color & 0xf0) | hue;
 }
@@ -1715,10 +1717,10 @@ static void csi_m(struct vc_data *vc)
 			default_attr(vc);
 			break;
 		case 1:
-			vc->state.intensity = 2;
+			vc->state.intensity = VCI_BOLD;
 			break;
 		case 2:
-			vc->state.intensity = 0;
+			vc->state.intensity = VCI_HALF_BRIGHT;
 			break;
 		case 3:
 			vc->state.italic = 1;
@@ -1764,7 +1766,7 @@ static void csi_m(struct vc_data *vc)
 			vc->vc_toggle_meta = 1;
 			break;
 		case 22:
-			vc->state.intensity = 1;
+			vc->state.intensity = VCI_NORMAL;
 			break;
 		case 23:
 			vc->state.italic = 0;
@@ -1795,7 +1797,7 @@ static void csi_m(struct vc_data *vc)
 		default:
 			if (vc->vc_par[i] >= 90 && vc->vc_par[i] <= 107) {
 				if (vc->vc_par[i] < 100)
-					vc->state.intensity = 2;
+					vc->state.intensity = VCI_BOLD;
 				vc->vc_par[i] -= 60;
 			}
 			if (vc->vc_par[i] >= 30 && vc->vc_par[i] <= 37)
@@ -1934,7 +1936,7 @@ static void setterm_command(struct vc_data *vc)
 	case 2:	/* set color for half intensity mode */
 		if (vc->vc_can_do_color && vc->vc_par[1] < 16) {
 			vc->vc_halfcolor = color_table[vc->vc_par[1]];
-			if (vc->state.intensity == 0)
+			if (vc->state.intensity == VCI_HALF_BRIGHT)
 				update_attr(vc);
 		}
 		break;
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index cd0155310fea..c59fe641b8b5 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -302,14 +302,14 @@ sisusbcon_deinit(struct vc_data *c)
 
 /* interface routine */
 static u8
-sisusbcon_build_attr(struct vc_data *c, u8 color, u8 intensity,
+sisusbcon_build_attr(struct vc_data *c, u8 color, enum vc_intensity intensity,
 			    u8 blink, u8 underline, u8 reverse, u8 unused)
 {
 	u8 attr = color;
 
 	if (underline)
 		attr = (attr & 0xf0) | c->vc_ulcolor;
-	else if (intensity == 0)
+	else if (intensity == VCI_HALF_BRIGHT)
 		attr = (attr & 0xf0) | c->vc_halfcolor;
 
 	if (reverse)
@@ -320,7 +320,7 @@ sisusbcon_build_attr(struct vc_data *c, u8 color, u8 intensity,
 	if (blink)
 		attr ^= 0x80;
 
-	if (intensity == 2)
+	if (intensity == VCI_BOLD)
 		attr ^= 0x08;
 
 	return attr;
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index d64c5ce84125..e3da664df16c 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -394,7 +394,8 @@ static inline u16 mda_convert_attr(u16 ch)
 		(ch & 0x00ff) | attr;
 }
 
-static u8 mdacon_build_attr(struct vc_data *c, u8 color, u8 intensity, 
+static u8 mdacon_build_attr(struct vc_data *c, u8 color,
+			    enum vc_intensity intensity,
 			    u8 blink, u8 underline, u8 reverse, u8 italic)
 {
 	/* The attribute is just a bit vector:
@@ -405,7 +406,7 @@ static u8 mdacon_build_attr(struct vc_data *c, u8 color, u8 intensity,
 	 *	Bit 7    : blink
 	 */
 
-	return (intensity & 3) |
+	return (intensity & VCI_MASK) |
 		((underline & 1) << 2) |
 		((reverse   & 1) << 3) |
 		(!!italic << 4) |
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 90083eb80515..a847067abbe5 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -288,7 +288,8 @@ static unsigned long sticon_getxy(struct vc_data *conp, unsigned long pos,
     return ret;
 }
 
-static u8 sticon_build_attr(struct vc_data *conp, u8 color, u8 intens,
+static u8 sticon_build_attr(struct vc_data *conp, u8 color,
+			    enum vc_intensity intens,
 			    u8 blink, u8 underline, u8 reverse, u8 italic)
 {
     u8 attr = ((color & 0x70) >> 1) | ((color & 7));
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index d073fa167e87..d0b26e2318d3 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -629,7 +629,8 @@ static void vgacon_deinit(struct vc_data *c)
 	con_set_default_unimap(c);
 }
 
-static u8 vgacon_build_attr(struct vc_data *c, u8 color, u8 intensity,
+static u8 vgacon_build_attr(struct vc_data *c, u8 color,
+			    enum vc_intensity intensity,
 			    u8 blink, u8 underline, u8 reverse, u8 italic)
 {
 	u8 attr = color;
@@ -639,7 +640,7 @@ static u8 vgacon_build_attr(struct vc_data *c, u8 color, u8 intensity,
 			attr = (attr & 0xF0) | c->vc_itcolor;
 		else if (underline)
 			attr = (attr & 0xf0) | c->vc_ulcolor;
-		else if (intensity == 0)
+		else if (intensity == VCI_HALF_BRIGHT)
 			attr = (attr & 0xf0) | c->vc_halfcolor;
 	}
 	if (reverse)
@@ -648,14 +649,14 @@ static u8 vgacon_build_attr(struct vc_data *c, u8 color, u8 intensity,
 				       0x77);
 	if (blink)
 		attr ^= 0x80;
-	if (intensity == 2)
+	if (intensity == VCI_BOLD)
 		attr ^= 0x08;
 	if (!vga_can_do_color) {
 		if (italic)
 			attr = (attr & 0xF8) | 0x02;
 		else if (underline)
 			attr = (attr & 0xf8) | 0x01;
-		else if (intensity == 0)
+		else if (intensity == VCI_HALF_BRIGHT)
 			attr = (attr & 0xf0) | 0x08;
 	}
 	return attr;
diff --git a/include/linux/console.h b/include/linux/console.h
index 75dd20650fbe..10c04779ae49 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -35,6 +35,8 @@ enum con_scroll {
 	SM_DOWN,
 };
 
+enum vc_intensity;
+
 /**
  * struct consw - callbacks for consoles
  *
@@ -74,7 +76,8 @@ struct consw {
 	void	(*con_scrolldelta)(struct vc_data *vc, int lines);
 	int	(*con_set_origin)(struct vc_data *vc);
 	void	(*con_save_screen)(struct vc_data *vc);
-	u8	(*con_build_attr)(struct vc_data *vc, u8 color, u8 intensity,
+	u8	(*con_build_attr)(struct vc_data *vc, u8 color,
+			enum vc_intensity intensity,
 			u8 blink, u8 underline, u8 reverse, u8 italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
 	u16    *(*con_screen_pos)(struct vc_data *vc, int offset);
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 162f4337c767..e901d98790bf 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -22,6 +22,13 @@ struct uni_screen;
 
 #define NPAR 16
 
+enum vc_intensity {
+	VCI_HALF_BRIGHT,
+	VCI_NORMAL,
+	VCI_BOLD,
+	VCI_MASK = 0x3,
+};
+
 /**
  * struct vc_state -- state of a VC
  * @x: cursor's x-position
@@ -30,7 +37,7 @@ struct uni_screen;
  * @G0_charset: what's G0 slot set to (like GRAF_MAP, LAT1_MAP)
  * @G1_charset: what's G1 slot set to (like GRAF_MAP, LAT1_MAP)
  * @charset: what character set to use (0=G0 or 1=G1)
- * @intensity: 0=half-bright, 1=normal, 2=bold
+ * @intensity: see enum vc_intensity for values
  * @reverse: reversed foreground/background colors
  *
  * These members are defined separately from struct vc_data as we save &
@@ -46,7 +53,7 @@ struct vc_state {
 	unsigned int	charset		: 1;
 
 	/* attribute flags */
-	unsigned int	intensity	: 2;
+	enum vc_intensity intensity;
 	unsigned int	italic		: 1;
 	unsigned int	underline	: 1;
 	unsigned int	blink		: 1;
-- 
2.27.0

