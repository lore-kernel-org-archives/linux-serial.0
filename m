Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460825525D;
	Thu, 17 Apr 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915752; cv=none; b=EX9LYDXgOLRvRkKQr1JIcE2ZUx0aWlfxcC95uvdRAsLTchJqC4FhIzUZvM92EWJn7r3XMHR3gSx9+x+5FVIwt8ojNIy8sGWnlL8SOy4iYtrlo0wXt/zA1WHyVy4zIYMPbyCs8xXwdarhcio/iKlE7YqSfvlPPDVl2f9GmzJD2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915752; c=relaxed/simple;
	bh=92EDpQGpYpkVOEkCQSKmP2HkQnCuwdJCwXt7xWBGs40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zwm/e87tgdxpL/zOTbtCFR9wInRPcR7l19KwQkWenHpdC05JY1C5ifdvebmyKI442DCky7kbHQoMtjl9xbV5w38+X2Dx/tHp7tPPj2WM7jNUswBfRqhTutlkyV1vEVu8KafVTOav7aHFCFcetDxUhj8YEAtfx/biRarTiWcX2e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=okEOOUTk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A0Jgtvs5; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="okEOOUTk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A0Jgtvs5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CB3011400DB;
	Thu, 17 Apr 2025 14:49:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 17 Apr 2025 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915748; x=
	1745002148; bh=S34coVXmtNFMq7RzmeuThti+HGlleP/xQrm4SlS8LX0=; b=o
	kEOOUTklZPGeYPsa8gACdwb+LlB919tXuhRFlTM+w7M/xrWuS02+AcvkfPciZJfC
	Um4W17LstJIKTeglW61wC9XOaJBNEMBDR5f/qRIHEHgMzudZ8XUs3ziOkYHVuouX
	+g/dW4G7D/k7Cn7a4iqvv+JS0llwKpNyFtD9CGYyDZFidEgfEmHeGeksV7pZcwjK
	WmnyBUDowHKzB+OY3qkNOkfS0XprlbO+6/ZaB1cOJNEulaTZF31VaQyD2/bck7Cr
	cWg44I2sJKQ//U5fQJuBJOXiNV8jzqsoRRrP1nVnzHEDsKwSqUv0/SVpnQlk/rjM
	QguZabCfk5662ALVGMTIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915748; x=1745002148; bh=S
	34coVXmtNFMq7RzmeuThti+HGlleP/xQrm4SlS8LX0=; b=A0Jgtvs53g9CVnt3P
	bVxg2YoSFgTP1T2dzCTM30hFgTcaMmy4tB6gpSHvWx+XcNUarDQhj50ow52rISBu
	Pwkfhl39fpuzlGzskK7kWWellSXSOAges0JGyixx63mj1wiEcPJSt3Ni5gGxTD7s
	VCvtHJ7km9Gs/jqNbqLOvHdectyqDkFMXKIfr4woc/McZPlCQBLLS02PVlFbh/Dd
	YXaR3QkxFy/ExBmAw40dBG6KpA4gEBTfB8ruRYEe4FCcVB20XPgufv4NrxIdchPB
	4ozQ0TJmgE5c36oCmNTIUv+jlQZJLYkZitU+3ZiMzjeb32GhcQBrm7wNEqUFb/Lc
	zlCgg==
X-ME-Sender: <xms:JE0BaEPwaYLaIrzZjgIzGzKNJX8fT1IyPgSVYaHQlSCwnWDB5t5pGw>
    <xme:JE0BaK-asZS9MYiBOTnnEX4Lor_8FDGYQyZTmLTQlNficHdjWeJ1PfzDQCZIO-Wah
    Z00_QTmSIootbGMdfo>
X-ME-Received: <xmr:JE0BaLRuTDOb9g7Bdw7GpPL0gdePTFoEUkEi4lAypOSawc5h001UU_67VbWPECJa-Y2gBFt2XnmdlFdQlokkqM_Wt_xBRGCc89M0WQzs4lsz-DDG1A>
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
X-ME-Proxy: <xmx:JE0BaMtG1O1gu0XHiKwy6Y58nRXiNOIF_kdY7neUtrN6jfGAGhMlDg>
    <xmx:JE0BaMdKZITSCA9mAiOo9Z3YQkNp_AQ96j8TAUXBZSOAZ2A0Fnw4eg>
    <xmx:JE0BaA09PXxxir8f-9ZyY6zD8T_-HFJhVvshxVCCrYuKiC7YCon8Zw>
    <xmx:JE0BaA8-huv-WGPACE-2Bh7Hub4S_yomBcKn0B0bTW0pp0j57PaimQ>
    <xmx:JE0BaNcTvvbTJkfWJyF8VdLAwpvtaKGqlu1IfKBGnAok1Yx1gr2GwFoU>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id DB41211443D4;
	Thu, 17 Apr 2025 14:49:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/14] vt: support Unicode recomposition
Date: Thu, 17 Apr 2025 14:45:11 -0400
Message-ID: <20250417184849.475581-10-nico@fluxnic.net>
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

Try replacing any decomposed Unicode sequence by the corresponding
recomposed code point. Code point to glyph correspondance works best
after recomposition, and this apply mostly to single-width code points
therefore we can't preserve them in their decomposed form anyway.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/ucs.c       | 62 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/vt/vt.c        | 14 +++++++--
 include/linux/consolemap.h |  6 ++++
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/ucs.c b/drivers/tty/vt/ucs.c
index 5f9f25bd20..bf25d63cea 100644
--- a/drivers/tty/vt/ucs.c
+++ b/drivers/tty/vt/ucs.c
@@ -59,3 +59,65 @@ bool ucs_is_double_width(u32 cp)
 	return cp_in_range(cp, ucs_double_width_ranges,
 			   ARRAY_SIZE(ucs_double_width_ranges));
 }
+
+/*
+ * Structure for base with combining mark pairs and resulting recompositions.
+ * Using u16 to save space since all values are within BMP range.
+ */
+struct ucs_recomposition {
+	u16 base;	/* base character */
+	u16 mark;	/* combining mark */
+	u16 recomposed;	/* corresponding recomposed character */
+};
+
+#include "ucs_recompose_table.h"
+
+struct compare_key {
+	u16 base;
+	u16 mark;
+};
+
+static int recomposition_cmp(const void *key, const void *element)
+{
+	const struct compare_key *search_key = key;
+	const struct ucs_recomposition *entry = element;
+
+	/* Compare base character first */
+	if (search_key->base < entry->base)
+		return -1;
+	if (search_key->base > entry->base)
+		return 1;
+
+	/* Base characters match, now compare combining character */
+	if (search_key->mark < entry->mark)
+		return -1;
+	if (search_key->mark > entry->mark)
+		return 1;
+
+	/* Both match */
+	return 0;
+}
+
+/**
+ * ucs_recompose() - Attempt to recompose two Unicode characters into a single character.
+ * @base: Base Unicode code point (UCS-4)
+ * @mark: Combining mark Unicode code point (UCS-4)
+ *
+ * Return: Recomposed Unicode code point, or 0 if no recomposition is possible
+ */
+u32 ucs_recompose(u32 base, u32 mark)
+{
+	/* Check if characters are within the range of our table */
+	if (!in_range(base, UCS_RECOMPOSE_MIN_BASE, UCS_RECOMPOSE_MAX_BASE) ||
+	    !in_range(mark, UCS_RECOMPOSE_MIN_MARK, UCS_RECOMPOSE_MAX_MARK))
+		return 0;
+
+	struct compare_key key = { base, mark };
+	struct ucs_recomposition *result =
+		__inline_bsearch(&key, ucs_recomposition_table,
+				 ARRAY_SIZE(ucs_recomposition_table),
+				 sizeof(*ucs_recomposition_table),
+				 recomposition_cmp);
+
+	return result ? result->recomposed : 0;
+}
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a989feffad..76554c2040 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2925,9 +2925,9 @@ static void vc_con_rewind(struct vc_data *vc)
 
 #define UCS_VS16	0xfe0f	/* Variation Selector 16 */
 
-static int vc_process_ucs(struct vc_data *vc, int c, int *tc)
+static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 {
-	u32 prev_c, curr_c = c;
+	u32 prev_c, curr_c = *c;
 
 	if (ucs_is_double_width(curr_c))
 		return 2;
@@ -2964,6 +2964,14 @@ static int vc_process_ucs(struct vc_data *vc, int c, int *tc)
 		return 1;
 	}
 
+	/* try recomposition */
+	prev_c = ucs_recompose(prev_c, curr_c);
+	if (prev_c != 0) {
+		vc_con_rewind(vc);
+		*tc = *c = prev_c;
+		return 1;
+	}
+
 	/* Otherwise zero-width code points are ignored. */
 	return 0;
 }
@@ -2978,7 +2986,7 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 	bool inverse = false;
 
 	if (vc->vc_utf && !vc->vc_disp_ctrl) {
-		width = vc_process_ucs(vc, c, &tc);
+		width = vc_process_ucs(vc, &c, &tc);
 		if (!width)
 			goto out;
 	}
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index b3a9118666..8167494229 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -30,6 +30,7 @@ int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
 bool ucs_is_double_width(uint32_t cp);
 bool ucs_is_zero_width(uint32_t cp);
+u32 ucs_recompose(u32 base, u32 mark);
 #else
 static inline u16 inverse_translate(const struct vc_data *conp, u16 glyph,
 		bool use_unicode)
@@ -69,6 +70,11 @@ static inline bool ucs_is_zero_width(uint32_t cp)
 {
 	return false;
 }
+
+static inline u32 ucs_recompose(u32 base, u32 mark)
+{
+	return 0;
+}
 #endif /* CONFIG_CONSOLE_TRANSLATIONS */
 
 #endif /* __LINUX_CONSOLEMAP_H__ */
-- 
2.49.0

