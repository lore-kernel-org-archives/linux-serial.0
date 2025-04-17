Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F724BBFD;
	Thu, 17 Apr 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915751; cv=none; b=S7RYU1cCp6r1LiyghIY2dVzOwen9xHEcx+9Gi0T5K6ArZFBfMHh+7SACZGvO8okX0Yujy6R1mYUHm5uqf7yd3rJ6Bxal5iIJYz3I0WeRWeQKaKnPOYn1ZXuInO3v5QQ3FzTDW6ZSp0RFSEKxISQSZBNwIQvRFO7rhUdWi7P5qaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915751; c=relaxed/simple;
	bh=eCtjv4ULOHwciSXw7vzPC0pBgrfZ2RCk2OycsVuaCF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlFcWKOr336feQcUVFRxWwfWU/yhsb9f7DmVdBDWd4rzjBL6oN3F9KVOEkHXunsteZDX6XLOQ4azA9El2+rByw99TKI8kviYeKQtlJEk/nNIl1518GhOl+IYbMKLLRlsZxHXTwHlEjO4qII95gvPfmWKtHrq5hezHLdYzxr0DwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=ln922AG8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjJEQgoR; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="ln922AG8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjJEQgoR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 2168011400D7;
	Thu, 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 17 Apr 2025 14:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915747; x=
	1745002147; bh=nfs/yzqp0drx1eXNiOGQPpizGNcJVMSe3SYZgR9m6jo=; b=l
	n922AG8fLXg6lHpMHyLXxd+zCYeIb+1pGaUErZlhFKQ8QFUQEzqny4YrFgMa+/yZ
	SYBaXFXyKVuqr6i+D+aA4kfEr/KkmIKNPefvyKSFar/Jq6CffKNmcq4BQKKsnypi
	QfaIzkIBNxqftoYX5XHxuwgSbXDjajxnbftrPaY5MCqoSz9D/nP8SowYckOeqIW6
	SK3P8AO0TE1ZqN7nfvx3MIWv1fcM3sgXF8ZfHHVnGHq1UBZG8Nyv68rIyTjLZ6nT
	UJvM5Swn2fE1iU3AkQEZuB/ipACWSmmXD/X1WLlgN0BlgX7oPHYn9YRM/YsdOQbk
	43c/mQrePTVwQ0eIBXBpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915747; x=1745002147; bh=n
	fs/yzqp0drx1eXNiOGQPpizGNcJVMSe3SYZgR9m6jo=; b=QjJEQgoRGwZRekxDV
	E7AGWOvpyNeX6oc1rz5FGJ1KIGqZwEjmvCfFKdx/GyDEPbJ+EWY/Gt6FUe/bHbGa
	zsDyheDyAWQ1GzNuIua1omEOPDNPnqV6rn9FPIPa8m1fMDUfOgJJelVeBF+ZoVzI
	TMozC0J1UuTAaURwMIHtYaAW6+hZiYGcN+jeG9jodCSXF0XghLwhpkcrWSJdOlpF
	Kpqb+Fm2d/avsZBCJYmGqHcj6Eq8ZyB+3MwYleVimsEdtHXqrn+0v6EhIUpiG3Yi
	g1IcZPIAUyyXRd4bv0LlZKsVYTEaUfG86Hggxwkxlr90optKdM5iTBbruvhtMpI2
	kUoZQ==
X-ME-Sender: <xms:I00BaFMqsIGdxCwDh50vfRBbb6aHFsek-518DGJ_ELFb0HlOLoWERA>
    <xme:I00BaH-zgsT5R6-NXKeACH9FVkdrtTl_b2XDH9w89-Ifsseb7zoVjx_Ngz3b9uywp
    4J_eQ3T3S45iye6eS4>
X-ME-Received: <xmr:I00BaETfXqu1rgPF4l5ZJe0tyagW_lo6WtGJFZ3Y9CnQcSHdbZOfhw9yQ8pCC-6SL1S33i2TBQjMdKyV_dJeeMzz4l7q5ssDSXPgI20JxHE5HRLSng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedttddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:I00BaBuUj0N6JrX3FAo20mXAHVnTAi-GGLnRiRfW7tDHNg2e0oII7Q>
    <xmx:I00BaNcVWvKMs2wBBU3TK8R9oNtHr1gLf8I1kRxVw01K88CMks4AaQ>
    <xmx:I00BaN0SFTVt6cM5OysX7oEZomnTJmzL3NpNNX7nrmmB0bUbHYARxA>
    <xmx:I00BaJ8nRQUyuvEX2pgmRqNzUxGLf_oRj5v6sMIDK4km5lMXmPmn5w>
    <xmx:I00BaKdhP5Suo4pvB3CHGG1LJzMhCEKQ5c7QZLRzpmQVxb61-oR5c82r>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:07 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 20F2311443CC;
	Thu, 17 Apr 2025 14:49:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/14] vt: properly support zero-width Unicode code points
Date: Thu, 17 Apr 2025 14:45:05 -0400
Message-ID: <20250417184849.475581-4-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417184849.475581-1-nico@fluxnic.net>
References: <20250417184849.475581-1-nico@fluxnic.net>
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

VS16 (Variation Selector 16, U+FE0F) is special as it typically doubles
the width of the preceding single-width code point. We handle that case
by giving VS16 a width of 1 instead of 0 when that happens.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
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

