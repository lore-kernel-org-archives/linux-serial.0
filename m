Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4E13C695;
	Thu, 10 Apr 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247945; cv=none; b=r0SpE8qO18kCDW4RrhgAI7WjwNdSx/N0hhbq38ONTZ0C5lesXfbO4JmYgUXzgQZsW85yvIdtqqT/EI3W7/8JoDIvteGnN9zZFHfvwdzt3YS2uibSxp7BlBH2NvvU9SDhI/MCPzofVk+eQc8sXHGvvHWXlYd6xVr7iem3ulsZHnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247945; c=relaxed/simple;
	bh=gcqSMWGe//HpgJ0uuOoj1Z1QowqSEzpoSR6AckfBzdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RD/Il6qOheX3gIOHbH16wNWt3lVH+zPmAV+1d0aN0ZVMNeOsX+wDjKBpqJvnnCggHrBNygohZCi4DM14Z6f3VUhtgL0rJRZ7HZa9+JJG0KxrkrWc2Uk9g0eAIz+4hq5kGdSalLYxOXiyuuQM8tx/Hv814exHCdaTIcCk3z3MJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=gf3ZRIZC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GBeUHmGY; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="gf3ZRIZC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBeUHmGY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D21A1140262;
	Wed,  9 Apr 2025 21:19:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 09 Apr 2025 21:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744247942; x=
	1744334342; bh=ugSjOtKUvF1Fs7tFsnjRkTf9rFKxSG6I+VHXKwAvhMo=; b=g
	f3ZRIZCdkckuHfg1d2wYFeP0N9sdRsLmEGzzqZvbos9YL5BySGOLp0uLNBPPXGvM
	Qz3cHFK4ZEtnP+Fkkr8zxdGgorr3Nj072q+iZTeABgL9z4lD4XanP3QjuA+HMwFZ
	agazFEU562UfsTfGOsGrGUyj5p9dHoG1eHgmow0EN1Hozwi38R99hmIEKM+KJlZ8
	jW/RU+eFscOlLCEF3BOXoNudhhSEgCYBquWzY8eGVAVyND6q/apurIsEnmvpGRGP
	gncfBkC4PIFef9M99IuUkJDQRL2dj/VAxB+8qJktEFR5kMROfe3DKoBdIKuSW1x/
	Hpi9EelNxgyCFGe2fk8UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744247942; x=1744334342; bh=u
	gSjOtKUvF1Fs7tFsnjRkTf9rFKxSG6I+VHXKwAvhMo=; b=GBeUHmGY/8BqjhnfN
	UH0B4cm5qq7kf1Aw1OwHNgvyPUzpxc0II7tesTX9Pj9ZDvu/033f7GZuu5MKmdm2
	tzPdILrjOOi1UidY06QcFiTxg26jnva/T8KWM1G/BEI+VFDiDdoR5+jdfmgsS2+B
	M4+qgsedv5ruOeMiyaQwXV1VKziT9B4LfEODWjlppaThRuLIvU81YeF4PIeTiR9Y
	RR06OKzT83Rud7rhZwCThh6zWqcKjSlQwd8V8maE+i82GyrV/UGoMXCpGDhZHTmv
	rv+YWYGMkJHDOKinxeTJj2bc6dNrWQoJAcaLzFx1jGGANTfTL9aE/4UQptMuO1AX
	wDkOg==
X-ME-Sender: <xms:hhz3ZzYWQiy64zv_UH-dxmruyqmCO8S3ujzmuXBhTbHNpCvTSE-7kg>
    <xme:hhz3ZyYV1s3ZYrxiKKrsKMvqB-97Jnmrh96MYBF-j0NBU9BeHwi95PoNKrS_ymdI4
    b6rDJOvTNxEt5fjmSc>
X-ME-Received: <xmr:hhz3Z199j2WSCh9kGobzUZAVW4EHiqAHYTmsb3WcX77RCZY3WZ95lCORiIupicJfqcI6DXuP3xrv7alMiH1LYV_gW3ttiDKt7ECggPB366brqRuQeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeek
    udekfeffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhi
    hlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepuggrvhgvsehmihgvlhhkvgdrtggtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hhz3Z5onM2OvHAFHFOSXOt5Zu2U_8WnizAEOgYSXIVziEspN5qOHWg>
    <xmx:hhz3Z-r8l3wGC4EuE7DCHNGvBgpW0PGzGtzArzncOfPcPLZ-pdir8Q>
    <xmx:hhz3Z_SHjy4at1xlou1RGcd5mN5QzhVJaBuxEt-Zg3kZSAxrWCK6UA>
    <xmx:hhz3Z2qszyZnp31ktT4_5C1jCYBL_hEwnKMPcaiq_sOFGcfR9qTqYA>
    <xmx:hhz3Z_49YNiA1TQWy68j0xZTeI-G5G8VMmEjPlClmgrhSPK6Se17VB0n>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 21:19:02 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id A5C0C10D8B71;
	Wed,  9 Apr 2025 21:19:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] vt: properly support zero-width Unicode code points
Date: Wed,  9 Apr 2025 21:13:55 -0400
Message-ID: <20250410011839.64418-4-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410011839.64418-1-nico@fluxnic.net>
References: <20250410011839.64418-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

Zero-width Unicode code points are causing misalignment in vertically
aligned content, disrupting the visual layout. Let's handle zero-width
code points more intelligently.

Double-width code points are stored in the screen grid followed by a white
space code point to create the expected screen layout. When a double-width
code point is followed by a zero-width code point in the console incoming
bytestream (e.g., an emoji with a presentation selector) then we may
replace the white space padding by that zero-width code point instead of
dropping it. This maximize screen content information while preserving
proper layout.

If a zero-width code point is preceded by a single-width code point then
the above trick is not possible and such zero-width code point must
be dropped.

VS16 (Variation Selector 16, U+FE0F) is special as it doubles the width
of the preceding single-width code point. We handle that case by giving
VS16 a width of 1 when that happens.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c        | 46 ++++++++++++++++++++++++++++++++++++--
 include/linux/consolemap.h | 10 +++++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bcb508bc15..5d53feeb5d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -443,6 +443,15 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int top,
 	}
 }
 
+static u32 vc_uniscr_getc(struct vc_data *vc, int relative_pos)
+{
+	int pos = vc->state.x + vc->vc_need_wrap + relative_pos;
+
+	if (vc->vc_uni_lines && pos >= 0 && pos < vc->vc_cols)
+		return vc->vc_uni_lines[vc->state.y][pos];
+	return 0;
+}
+
 static void vc_uniscr_copy_area(u32 **dst_lines,
 				unsigned int dst_cols,
 				unsigned int dst_rows,
@@ -2905,18 +2914,49 @@ static bool vc_is_control(struct vc_data *vc, int tc, int c)
 	return false;
 }
 
+static void vc_con_rewind(struct vc_data *vc)
+{
+	if (vc->state.x && !vc->vc_need_wrap) {
+		vc->vc_pos -= 2;
+		vc->state.x--;
+	}
+	vc->vc_need_wrap = 0;
+}
+
 static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		struct vc_draw_region *draw)
 {
-	int next_c;
+	int next_c, prev_c;
 	unsigned char vc_attr = vc->vc_attr;
 	u16 himask = vc->vc_hi_font_mask, charmask = himask ? 0x1ff : 0xff;
 	u8 width = 1;
 	bool inverse = false;
 
 	if (vc->vc_utf && !vc->vc_disp_ctrl) {
-		if (ucs_is_double_width(c))
+		if (ucs_is_double_width(c)) {
 			width = 2;
+		} else if (ucs_is_zero_width(c)) {
+			prev_c = vc_uniscr_getc(vc, -1);
+			if (prev_c == ' ' &&
+			    ucs_is_double_width(vc_uniscr_getc(vc, -2))) {
+				/*
+				 * Let's merge this zero-width code point with
+				 * the preceding double-width code point by
+				 * replacing the existing whitespace padding.
+				 */
+				vc_con_rewind(vc);
+			} else if (c == 0xfe0f && prev_c != 0) {
+				/*
+				 * VS16 (U+FE0F) is special. Let it have a
+				 * width of 1 when preceded by a single-width
+				 * code point effectively making the later
+				 * double-width.
+				 */
+			} else {
+				/* Otherwise zero-width code points are ignored */
+				goto out;
+			}
+		}
 	}
 
 	/* Now try to find out how to display it */
@@ -2995,6 +3035,8 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 			tc = ' ';
 		next_c = ' ';
 	}
+
+out:
 	notify_write(vc, c);
 
 	if (inverse)
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index caf079bcb8..7d778752dc 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -29,6 +29,11 @@ u32 conv_8bit_to_uni(unsigned char c);
 int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
 bool ucs_is_double_width(uint32_t cp);
+static inline bool ucs_is_zero_width(uint32_t cp)
+{
+	/* coming soon */
+	return false;
+}
 #else
 static inline u16 inverse_translate(const struct vc_data *conp, u16 glyph,
 		bool use_unicode)
@@ -63,6 +68,11 @@ static inline bool ucs_is_double_width(uint32_t cp)
 {
 	return false;
 }
+
+static inline bool ucs_is_zero_width(uint32_t cp)
+{
+	return false;
+}
 #endif /* CONFIG_CONSOLE_TRANSLATIONS */
 
 #endif /* __LINUX_CONSOLEMAP_H__ */
-- 
2.49.0

