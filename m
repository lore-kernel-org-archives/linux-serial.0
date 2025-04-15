Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED2C2459FF;
	Tue, 15 Apr 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744942; cv=none; b=rjIrroXWwsgbq1u05PbcqXdsRwByT7ntBUlQ/Lvb7RUiv6qgoAA85axKZ1V8GSNVCrlOyyAvduTbNHSsYvRttiiI9uyE1RaAmOIx2bnQsA9EGjs/YhHdswSNSPi2NIAS2Cmh+JJTf1/ygIeey/OW4FGkI3KV/6iA8oQtnqh6uuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744942; c=relaxed/simple;
	bh=5vzet0daixK6Zv4nyIFtUBpAIrRvYYu6oy/iAxqi9Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STyZWqLWKh5Uw0n9Th03ZVbyNvY1Up2/8Iw+uD8OzOrB/rvZxcndOafmuXJpzeF+OPO4uOrpgx3V63ZOOIBnKL/ZnzfTktyovxws5HAfkntX3jty6ovE26jfHaterXiltGdTEDY5tPfPjbHhov+YsiWJoPAKqBApQ1S2ElqEJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=KxGSqw81; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aI848t2r; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="KxGSqw81";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aI848t2r"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EC82B13801E3;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 15 Apr 2025 15:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744744939; x=
	1744831339; bh=gH4J9klRNhPiPpbUtkscVBihYK1f2oEF5ZwuY51ocAQ=; b=K
	xGSqw811DbSFe5HYEuMPiBLt2matpQI62rSBnqaIjtQRKkLbUDLltRR0xsMxRG0e
	tf1NAHMvp/xEkNeoRaCodRY9w2BF9tr9GFg7zwrBWYQIJvhcXpavjxuxo3LkSG8J
	NVhJjUSKDs2n7e0Yz5oGgGKfrVayeWz7rZ6E6CejwLHF+dHSD0sTRndVdeZdEWT0
	QOWoSCgp9U5EfaLVBHRVbtLSE2SfSQGgIkpajsLHX4pO/sqrqfZ0hmSzihrWOv54
	CFXZc6gbhI1U4V30q/A/8A+JgcDBpp6FA4hLM+59dvh2Hq7mCgJAe7IeJ8GsMfVk
	N3FHxDtnc+x0il1mckPxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744744939; x=1744831339; bh=g
	H4J9klRNhPiPpbUtkscVBihYK1f2oEF5ZwuY51ocAQ=; b=aI848t2rZKaf7JRTt
	Tcer7oc1sMeqteZm8jsEtYeRPTWgKyMI3LnTn2Dt2tcXPspdRKVY03VXSAcFfVU9
	M+pnxHRKqGcIm5qUz9wSXiqQ+LUlWgjnjrj5hKtGefQZcKeYxjSDAYLv7HeRCb6m
	QJOIffh9vNbqUu9qL+zrJBnwW7+r3IafFZ1qPfzmAEjecIYJUbCgIdgKgGOkCzN/
	3rG888K5HAP5BvAbCo1oV6Xf0Oy5DgXtGvMLRFkkeoXvOq8rP7nEenc3bFpLOFiY
	exqLpbvlQpLytsHSOffN57IWt5Qn6IC+nSJc256C4GNg11zqpmoNkCIBXBCyxVLC
	g6XMg==
X-ME-Sender: <xms:67H-Z3FZupJJIhsyg7dsk5iGPab9rbMjVlQlQ5Pu_CYtyXWevNqAuQ>
    <xme:67H-Z0W31Z9JolWVCm-z2xhC9r3jBlkmnLzPfgMgtt_H1KoB8cCFeuDcWmukdhP-5
    EYrv_sdo04FLyIWoZA>
X-ME-Received: <xmr:67H-Z5Jeo9GC1OUSmPs4Z_1YQOo5GTIXMT0e29aHOJDK27ToSdOhM2y3OOql-CGn4SI-0BjAzjz3RFhhlNwARkAdeniow-UyMRO2H51lZLp12wVRow>
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
X-ME-Proxy: <xmx:67H-Z1HcARk7BFFSDQ9G6aaL2N03GEFIKFqqXNPVq7q2qnGhrKHsmQ>
    <xmx:67H-Z9VYq-ZMEXaznUPkjNfA0YQUMXZ3tQUjMUo4NXSp0UvQ6qbm5w>
    <xmx:67H-ZwPNBkSdbhYiYZvbmIV90cqolFbKQGPjD0tpIZ8uMhGNWUVMmw>
    <xmx:67H-Z82Ndx4gZzEnmIbP1rRcuSc7MRN6f1-xZWUIVX_m1UW-DHVXAA>
    <xmx:67H-Z828V9AplxFykzuC1qnCfj-hJDBhO0d0R6SkQp9yUMXabqckpT2f>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id EB4CD1116612;
	Tue, 15 Apr 2025 15:22:18 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] vt: support Unicode recomposition
Date: Tue, 15 Apr 2025 15:17:58 -0400
Message-ID: <20250415192212.33949-10-nico@fluxnic.net>
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

Try replacing any decomposed Unicode sequence by the corresponding
recomposed code point. Code point to glyph correspondance works best
after recomposition, and this apply mostly to single-width code points
therefore we can't preserve them in their decomposed form anyway.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/ucs.c       | 62 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/vt/vt.c        | 14 +++++++--
 include/linux/consolemap.h |  6 ++++
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/ucs.c b/drivers/tty/vt/ucs.c
index 5e71aa3896..07b2bd1714 100644
--- a/drivers/tty/vt/ucs.c
+++ b/drivers/tty/vt/ucs.c
@@ -56,3 +56,65 @@ bool ucs_is_double_width(u32 cp)
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
+ * Attempt to recompose two Unicode characters into a single character.
+ *
+ * @param base: Base Unicode code point (UCS-4)
+ * @param mark: Combining mark Unicode code point (UCS-4)
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

