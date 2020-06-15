Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C8CC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B36206D7
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgFOHvn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:39916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbgFOHtP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 80B0EAFBC;
        Mon, 15 Jun 2020 07:49:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/38] vc: switch state to bool
Date:   Mon, 15 Jun 2020 09:48:35 +0200
Message-Id: <20200615074910.19267-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The code currently uses bitfields to store true-false values. Switch all
of that to bools. Apart from the cleanup, it saves 20B of code as many
shifts, ANDs, and ORs became simple movzb's.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c                     | 32 ++++++++++++-------------
 drivers/usb/misc/sisusbvga/sisusb_con.c |  3 ++-
 drivers/video/console/mdacon.c          | 11 +++++----
 drivers/video/console/sticon.c          |  3 ++-
 drivers/video/console/vgacon.c          |  3 ++-
 include/linux/console.h                 |  2 +-
 include/linux/console_struct.h          |  8 +++----
 7 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 71bf483e5640..26cb1fc48b27 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -706,8 +706,8 @@ void update_region(struct vc_data *vc, unsigned long start, int count)
 /* Structure of attributes is hardware-dependent */
 
 static u8 build_attr(struct vc_data *vc, u8 _color,
-		enum vc_intensity _intensity, u8 _blink, u8 _underline,
-		u8 _reverse, u8 _italic)
+		enum vc_intensity _intensity, bool _blink, bool _underline,
+		bool _reverse, bool _italic)
 {
 	if (vc->vc_sw->con_build_attr)
 		return vc->vc_sw->con_build_attr(vc, _color, _intensity,
@@ -755,8 +755,8 @@ static void update_attr(struct vc_data *vc)
 	              vc->state.blink, vc->state.underline,
 	              vc->state.reverse ^ vc->vc_decscnm, vc->state.italic);
 	vc->vc_video_erase_char = ' ' | (build_attr(vc, vc->state.color,
-				VCI_NORMAL, vc->state.blink, 0, vc->vc_decscnm,
-				0) << 8);
+				VCI_NORMAL, vc->state.blink, false,
+				vc->vc_decscnm, false) << 8);
 }
 
 /* Note: inverting the screen twice should revert to the original state */
@@ -1614,10 +1614,10 @@ static void csi_X(struct vc_data *vc, int vpar) /* erase the following vpar posi
 static void default_attr(struct vc_data *vc)
 {
 	vc->state.intensity = VCI_NORMAL;
-	vc->state.italic = 0;
-	vc->state.underline = 0;
-	vc->state.reverse = 0;
-	vc->state.blink = 0;
+	vc->state.italic = false;
+	vc->state.underline = false;
+	vc->state.reverse = false;
+	vc->state.blink = false;
 	vc->state.color = vc->vc_def_color;
 }
 
@@ -1723,7 +1723,7 @@ static void csi_m(struct vc_data *vc)
 			vc->state.intensity = VCI_HALF_BRIGHT;
 			break;
 		case 3:
-			vc->state.italic = 1;
+			vc->state.italic = true;
 			break;
 		case 21:
 			/*
@@ -1731,13 +1731,13 @@ static void csi_m(struct vc_data *vc)
 			 * convert it to a single underline.
 			 */
 		case 4:
-			vc->state.underline = 1;
+			vc->state.underline = true;
 			break;
 		case 5:
-			vc->state.blink = 1;
+			vc->state.blink = true;
 			break;
 		case 7:
-			vc->state.reverse = 1;
+			vc->state.reverse = true;
 			break;
 		case 10: /* ANSI X3.64-1979 (SCO-ish?)
 			  * Select primary font, don't display control chars if
@@ -1769,16 +1769,16 @@ static void csi_m(struct vc_data *vc)
 			vc->state.intensity = VCI_NORMAL;
 			break;
 		case 23:
-			vc->state.italic = 0;
+			vc->state.italic = false;
 			break;
 		case 24:
-			vc->state.underline = 0;
+			vc->state.underline = false;
 			break;
 		case 25:
-			vc->state.blink = 0;
+			vc->state.blink = false;
 			break;
 		case 27:
-			vc->state.reverse = 0;
+			vc->state.reverse = false;
 			break;
 		case 38:
 			i = vc_t416_color(vc, i, rgb_foreground);
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index c59fe641b8b5..80657c49310a 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -303,7 +303,8 @@ sisusbcon_deinit(struct vc_data *c)
 /* interface routine */
 static u8
 sisusbcon_build_attr(struct vc_data *c, u8 color, enum vc_intensity intensity,
-			    u8 blink, u8 underline, u8 reverse, u8 unused)
+			    bool blink, bool underline, bool reverse,
+			    bool unused)
 {
 	u8 attr = color;
 
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index e3da664df16c..00cb6245fbef 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -396,7 +396,8 @@ static inline u16 mda_convert_attr(u16 ch)
 
 static u8 mdacon_build_attr(struct vc_data *c, u8 color,
 			    enum vc_intensity intensity,
-			    u8 blink, u8 underline, u8 reverse, u8 italic)
+			    bool blink, bool underline, bool reverse,
+			    bool italic)
 {
 	/* The attribute is just a bit vector:
 	 *
@@ -407,10 +408,10 @@ static u8 mdacon_build_attr(struct vc_data *c, u8 color,
 	 */
 
 	return (intensity & VCI_MASK) |
-		((underline & 1) << 2) |
-		((reverse   & 1) << 3) |
-		(!!italic << 4) |
-		((blink     & 1) << 7);
+		(underline << 2) |
+		(reverse << 3) |
+		(italic << 4) |
+		(blink << 7);
 }
 
 static void mdacon_invert_region(struct vc_data *c, u16 *p, int count)
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index a847067abbe5..bbcdfd312c36 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -290,7 +290,8 @@ static unsigned long sticon_getxy(struct vc_data *conp, unsigned long pos,
 
 static u8 sticon_build_attr(struct vc_data *conp, u8 color,
 			    enum vc_intensity intens,
-			    u8 blink, u8 underline, u8 reverse, u8 italic)
+			    bool blink, bool underline, bool reverse,
+			    bool italic)
 {
     u8 attr = ((color & 0x70) >> 1) | ((color & 7));
 
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index d0b26e2318d3..c1c4ce28ac5e 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -631,7 +631,8 @@ static void vgacon_deinit(struct vc_data *c)
 
 static u8 vgacon_build_attr(struct vc_data *c, u8 color,
 			    enum vc_intensity intensity,
-			    u8 blink, u8 underline, u8 reverse, u8 italic)
+			    bool blink, bool underline, bool reverse,
+			    bool italic)
 {
 	u8 attr = color;
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 10c04779ae49..964b67912b04 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -78,7 +78,7 @@ struct consw {
 	void	(*con_save_screen)(struct vc_data *vc);
 	u8	(*con_build_attr)(struct vc_data *vc, u8 color,
 			enum vc_intensity intensity,
-			u8 blink, u8 underline, u8 reverse, u8 italic);
+			bool blink, bool underline, bool reverse, bool italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
 	u16    *(*con_screen_pos)(struct vc_data *vc, int offset);
 	unsigned long (*con_getxy)(struct vc_data *vc, unsigned long position,
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index e901d98790bf..fa1abffe64be 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -54,10 +54,10 @@ struct vc_state {
 
 	/* attribute flags */
 	enum vc_intensity intensity;
-	unsigned int	italic		: 1;
-	unsigned int	underline	: 1;
-	unsigned int	blink		: 1;
-	unsigned int	reverse		: 1;
+	bool		italic;
+	bool		underline;
+	bool		blink;
+	bool		reverse;
 };
 
 /*
-- 
2.27.0

