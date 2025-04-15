Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6972459E3;
	Tue, 15 Apr 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744943; cv=none; b=AIUrt9hCpjXs1EqW6/E9OumsfAs8ck735y4obAlN+4Mc/pnVXQChd3I4DG/7faeTGQDHXmbuWpKPlFWBESlGy1Cvm7FJiH38dz9OYQCnjbE3lgIlRWVGhgcB2JenZDje+FeTRPshAzt2fah3/I1x/0vneT9ADqJjZNYEiqxOEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744943; c=relaxed/simple;
	bh=BFavNU87Pi/qvKEXP74cUYtLTr7vP9t8MY72DZobvHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecowT/A3JbFLKGg+NKgE6kbYo0gbp4FPRz7/FCbCSZbvtadoybChTneSiP9LnBxRBlvDVc2oDxbhjXRdMZlonmpYyo3oBZ7J7ZxeCLACWNbJTBm1p/V56IIy9Z5TX+CuT2IfyDZ/dPcoBSY8Wws57Be39OYm95IhSzSXukjQnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=lHPORPlQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sruOCi+g; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="lHPORPlQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sruOCi+g"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E11A11401C8;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 15 Apr 2025 15:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744744939; x=
	1744831339; bh=u9E209kSt5qFpINKL5/QIsJ9CN000ksi85W38AnQZP0=; b=l
	HPORPlQ8kAr+4TZWPbblrYKEdK2JAbHP0cn+dv/eM9Egb+e1tHQKEmA8HLTX9rQ8
	1GR4pio53k9bcG/YlQz1C57aidEaHcRZs3hp5Lc9Trro1fiwIPwYaU0FRG9ajMtK
	LZnXNtOLvY7HH21vJBpLN/3EQCxK/0PpJFTwb6Rj28GbsHOX0+jrMjZDcC7hCQxG
	ZeEN15znWOxzjWVMYxxGgUDM9vpgQHIh5aCeUdFbvHjebphmVPIVvYxs6RP7jtag
	X49M+tW8HwV7+9qxigPP/LownY+6R4sBfgpzWoQhQBUXATpyUdS8n3d6+wXnby25
	kNG+bvxdJBtFxhJzudf0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744744939; x=1744831339; bh=u
	9E209kSt5qFpINKL5/QIsJ9CN000ksi85W38AnQZP0=; b=sruOCi+g2URSOnD9W
	DvcLkeN4BRkwOFCuhwi4GDXtoQ2xoP9Qw6AflUcjAqt2/ladLnH6BpnjeI4AmNJh
	1DolCP4KRnAGTGAXxU4gNfWfZLAjacJcsAyTQsA4lqgpQA/LdASLkCwiVTqqSo3T
	O34/JpMXV45EMPeQDuPTePgd7TfoNlplSd7FOVMQBvDgYu9NopyWcT+e07YeZjdj
	R89mDZT1chfILXzgMaCsV4vVXJM9wYjEDQGgQvxWGbAnEoycsq6yKqQ3LwV89kFa
	YlxOnkM7wQEzNoXDiNuDbgLd2msWaWjhi/uXaO3AP6+/AzxbIpxxFJpNsU1fa9RF
	CaX4A==
X-ME-Sender: <xms:6rH-Z_Wt6IrqsOsvzVIe1sZybxPpA9QGS4LFIvXD2Q-jnUDFX80Pcw>
    <xme:6rH-Z3lLLk1OW2LTE37QHSJmQaAfZupkYOjlAHy4icvng6XtqrU_7YQZgs946uemV
    p0m03z2-RtSLl-bXLo>
X-ME-Received: <xmr:6rH-Z7Ywce2HCoXmQRxsL2TTHrmnqJhwjTFNNz2A48t6L1NVNXe5QA5dqD1l-bw2bortQ6FlfYSA6LabFZ9_Jwh75U-Ld649w7w01DQMk1WksKkOeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeek
    udekfeffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhi
    hlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:6rH-Z6WtoMvdFPAf9q_8ebac7PeIeJy2WnAhE9xid-sYHEAXuEJnBg>
    <xmx:6rH-Z5nxy3VMBPvxHqrJE0PMnz02wZRCPqVWNe3UwbYRxEkzeynWrQ>
    <xmx:6rH-Z3fw10rvOJ2uVjPla4g7a2NEJBm2U1Q0_UOnQfUVs6t_vVelEw>
    <xmx:6rH-ZzHeTTKtZ7Q3AGhtSe1amzik3WfwHiXPuni9xFHzsqVhG2wb1A>
    <xmx:67H-Z0E-YKSFVqBF3OX3juy3rBDJp9FMSnQn81926D2oPeNtn7o3GYTg>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:18 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 20135111660A;
	Tue, 15 Apr 2025 15:22:18 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] vt: properly support zero-width Unicode code points
Date: Tue, 15 Apr 2025 15:17:52 -0400
Message-ID: <20250415192212.33949-4-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415192212.33949-1-nico@fluxnic.net>
References: <20250415192212.33949-1-nico@fluxnic.net>
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
 drivers/tty/vt/vt.c        | 70 ++++++++++++++++++++++++++++++++++++--
 include/linux/consolemap.h | 10 ++++++
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bcb508bc15..a989feffad 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -443,6 +443,15 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int top,
 	}
 }
 
+static u32 vc_uniscr_getc(struct vc_data *vc, int relative_pos)
+{
+	int pos = vc->state.x + vc->vc_need_wrap + relative_pos;
+
+	if (vc->vc_uni_lines && in_range(pos, 0, vc->vc_cols))
+		return vc->vc_uni_lines[vc->state.y][pos];
+	return 0;
+}
+
 static void vc_uniscr_copy_area(u32 **dst_lines,
 				unsigned int dst_cols,
 				unsigned int dst_rows,
@@ -2905,6 +2914,60 @@ static bool vc_is_control(struct vc_data *vc, int tc, int c)
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
+#define UCS_VS16	0xfe0f	/* Variation Selector 16 */
+
+static int vc_process_ucs(struct vc_data *vc, int c, int *tc)
+{
+	u32 prev_c, curr_c = c;
+
+	if (ucs_is_double_width(curr_c))
+		return 2;
+
+	if (!ucs_is_zero_width(curr_c))
+		return 1;
+
+	/* From here curr_c is known to be zero-width. */
+
+	if (ucs_is_double_width(vc_uniscr_getc(vc, -2))) {
+		/*
+		 * Let's merge this zero-width code point with the preceding
+		 * double-width code point by replacing the existing
+		 * whitespace padding. To do so we rewind one column and
+		 * pretend this has a width of 1.
+		 * We give the legacy display the same initial space padding.
+		 */
+		vc_con_rewind(vc);
+		*tc = ' ';
+		return 1;
+	}
+
+	/* From here the preceding character, if any, must be single-width. */
+	prev_c = vc_uniscr_getc(vc, -1);
+
+	if (curr_c == UCS_VS16 && prev_c != 0) {
+		/*
+		 * VS16 (U+FE0F) is special. It typically turns the preceding
+		 * single-width character into a double-width one. Let it
+		 * have a width of 1 effectively making the combination with
+		 * the preceding character double-width.
+		 */
+		*tc = ' ';
+		return 1;
+	}
+
+	/* Otherwise zero-width code points are ignored. */
+	return 0;
+}
+
 static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		struct vc_draw_region *draw)
 {
@@ -2915,8 +2978,9 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 	bool inverse = false;
 
 	if (vc->vc_utf && !vc->vc_disp_ctrl) {
-		if (ucs_is_double_width(c))
-			width = 2;
+		width = vc_process_ucs(vc, c, &tc);
+		if (!width)
+			goto out;
 	}
 
 	/* Now try to find out how to display it */
@@ -2995,6 +3059,8 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
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

