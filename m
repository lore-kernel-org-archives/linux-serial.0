Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2E19DF9A;
	Mon,  5 May 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464472; cv=none; b=D48LTgi+Q6xnKCQdL4+JXeb87x2WoR8Gn/z6eru/ho1PV/z0bHgaMfVaDKmAkLAWgg5B6Nf/24Z6yeYL1moivdBf2G2NTwyHiRPAQu0Jp9b6xUXgx0/E8Tn0l+wF91kFyOCl3RON7RaldS2cC6TkN0ILhkHfoFDN6UEPUxhENPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464472; c=relaxed/simple;
	bh=VrQfqaCff0TzNO2Np5z6BwKA6w26xVl7NYjFtF1dW8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFrj1tHndbL9jj69SjD7IFaBaS5nNmds6/3fy9GSomzT7iKsOErmw6Ph1FQhGEfGdBuBdkEOSkv1OD3Gv0Jjkg1NaWnooMN4LIg6wuULRsCzdJCT0t4wH0hKLN6bv7sRGx/SZPALtjeybAk/2WofN65rejWU366xq3lcKQlYwdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=SocgBIa/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbstplUW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="SocgBIa/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbstplUW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A5F211140094;
	Mon,  5 May 2025 13:01:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 05 May 2025 13:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1746464469; x=
	1746550869; bh=/9If94DVO0au8SHfNbEV3VaGwGSUnwCUNokFneS1rHM=; b=S
	ocgBIa/qf5dZ3Z77GQTBbvACR2yEuI6svhdYp3jEPrhDcVxZfSuAW6pvmjX0cvEc
	j6FYWKDRLo8z00cANHtLRunONR4Z946DIE82wPRUAMk8KSUlCaHz3bswDcW5dbhC
	n8OHVzy2oScpEYixMLrgAtsAaRqUQzUUk2USh1v93Rgw8qCD1tAs7qxO2GK/d8J9
	P3qlLAFliTiWMrC0/DPs7t7EA7HITCpnxjZAtYOkFbcoRw97/7CAcNE5w/cadxJn
	xckOXDoiv/niSr48Cjgaw/xInWbrurLmaf5Q6CKvMNDxsnoEYeLNt9nqKnEOxybC
	5akiZdl214gRAbXampXLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746464469; x=1746550869; bh=/
	9If94DVO0au8SHfNbEV3VaGwGSUnwCUNokFneS1rHM=; b=TbstplUWZ4TwZdNkJ
	1b4spXHV00gUffy9O53+N1qMMpbvAEIqE/bGlN1U7hgVj1csmu73397khkdPLKhk
	8TBJZIBOlo8p9rzKh+j7GR/XBMRrDU1HIVk93Jv10YOOoiTCQg/ceeRx7qeryBks
	dS9NaQJJPAFHO6O+QwuREL5M+MZoXIEuiKAsvGKzu0kg6fPJDyqBQuRQWKw03f+0
	wVJIqH7dTXQjnNp9esaK783nLW3QcEZmSzAteensuKZOV6qLYYUQqCAdJEzhtcOg
	nVuz6jh2IgXZkFy+ss7lpD1DcjKNFYwFRUgaBdchH4yprvi4D8CxB5NZxqn4/7bz
	BFGyA==
X-ME-Sender: <xms:1e4YaCSgifA6hQLBlPbxGFAxdDest83hg9NcU5tMkL9CV9FrrbS6-A>
    <xme:1e4YaHyjnzHSJlutz7kuRULVZ2Tb58DfaEqVnDB8rFCy8b55sgAjd5l1ZZlXf9A9D
    uOqXoGxzfkMwOs9nwE>
X-ME-Received: <xmr:1e4YaP1bisPyvmisxZyLyandjcfZhQ_eJ1ohyEXPgv_EckXEKqR1guzc7nz-jScqk_2py8ww3YGL-lKT61gtMRQ4P7mjGdrzZYj726vUUg48HBaPgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduieegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1e4YaODkrQgO8c5EHH5cJn7yjGQwAy8iOYfTxnF16l2ySLJwcZi4Jw>
    <xmx:1e4YaLh3b2gWm8WskbIkGm3U3MEMHu7xVqZJhdS6qPqhE2x9R9VP7Q>
    <xmx:1e4YaKrliwvKQw-yVl9PZFxVMBbGK8TZoOBFRyWf-jcJfN3nVbLN8w>
    <xmx:1e4YaOgWPTIvROFE3eZwww5AYV6Q7dZgz8lo9fWWHI0Zjm2MgnQAZg>
    <xmx:1e4YaPQza8IHecBs3WBC2mFcYyfOsaBhi5vSXGI5rSgkseFFW4RZbdKm>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 13:01:09 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 2AAB4118545F;
	Mon, 05 May 2025 13:01:08 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] vt: add ucs_get_fallback()
Date: Mon,  5 May 2025 12:55:29 -0400
Message-ID: <20250505170021.29944-7-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505170021.29944-1-nico@fluxnic.net>
References: <20250505170021.29944-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

This is the code querying the newly introduced tables.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/Makefile    |  3 +-
 drivers/tty/vt/ucs.c       | 73 ++++++++++++++++++++++++++++++++++++--
 include/linux/consolemap.h |  6 ++++
 3 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/Makefile b/drivers/tty/vt/Makefile
index 509362a3e11e..ae746dcdeec8 100644
--- a/drivers/tty/vt/Makefile
+++ b/drivers/tty/vt/Makefile
@@ -36,7 +36,8 @@ $(obj)/defkeymap.c: $(obj)/%.c: $(src)/%.map
 
 endif
 
-$(obj)/ucs.o: $(src)/ucs.c $(obj)/ucs_width_table.h $(obj)/ucs_recompose_table.h
+$(obj)/ucs.o:	$(src)/ucs.c $(obj)/ucs_width_table.h \
+		$(obj)/ucs_recompose_table.h $(obj)/ucs_fallback_table.h
 
 # You may uncomment one of those to have the UCS tables be regenerated
 # during the build process. By default the _shipped versions are used.
diff --git a/drivers/tty/vt/ucs.c b/drivers/tty/vt/ucs.c
index b0b23830170d..dcce733b80cb 100644
--- a/drivers/tty/vt/ucs.c
+++ b/drivers/tty/vt/ucs.c
@@ -44,13 +44,20 @@ static int interval32_cmp(const void *key, const void *element)
 	return 0;
 }
 
-static bool cp_in_range16(u16 cp, const struct ucs_interval16 *ranges, size_t size)
+static const struct ucs_interval16 *find_cp_in_range16(u16 cp,
+						       const struct ucs_interval16 *ranges,
+						       size_t size)
 {
 	if (cp < ranges[0].first || cp > ranges[size - 1].last)
-		return false;
+		return NULL;
 
 	return __inline_bsearch(&cp, ranges, size, sizeof(*ranges),
-				interval16_cmp) != NULL;
+				interval16_cmp);
+}
+
+static bool cp_in_range16(u16 cp, const struct ucs_interval16 *ranges, size_t size)
+{
+	return find_cp_in_range16(cp, ranges, size) != NULL;
 }
 
 static bool cp_in_range32(u32 cp, const struct ucs_interval32 *ranges, size_t size)
@@ -157,3 +164,63 @@ u32 ucs_recompose(u32 base, u32 mark)
 
 	return result ? result->recomposed : 0;
 }
+
+/*
+ * The fallback tables are using struct ucs_interval16 or plain literals
+ * directly. We reuse interval16_cmp() for the former, but another compare
+ * function is needed in the singles case.
+ */
+
+#include "ucs_fallback_table.h"
+
+static int u16_cmp(const void *key, const void *element)
+{
+	u16 cp = *(u16 *)key;
+	u16 entry = *(u16 *)element;
+
+	if (cp < entry)
+		return -1;
+	if (cp > entry)
+		return 1;
+	return 0;
+}
+
+static u16 *find_cp_in_table16(u16 cp, const u16 *table, size_t size)
+{
+	if (cp < table[0] || cp > table[size - 1])
+		return NULL;
+
+	return __inline_bsearch(&cp, table, size, sizeof(u16), u16_cmp);
+}
+
+/**
+ * ucs_get_fallback() - Get a substitution for the provided Unicode character
+ * @base: Base Unicode code point (UCS-4)
+ *
+ * Get a simpler fallback character for the provided Unicode character.
+ * This is used for terminal display when corresponding glyph is unavailable.
+ * The substitution may not be as good as the actual glyph for the original
+ * character but still way more helpful than a squared question mark.
+ *
+ * Return: Fallback Unicode code point, or 0 if none is available
+ */
+u32 ucs_get_fallback(u32 cp)
+{
+	const struct ucs_interval16 *interval;
+	u16 *single;
+
+	if (!UCS_IS_BMP(cp))
+		return 0;
+
+	interval = find_cp_in_range16(cp, ucs_fallback_intervals,
+				      ARRAY_SIZE(ucs_fallback_intervals));
+	if (interval)
+		return ucs_fallback_intervals_subs[interval - ucs_fallback_intervals];
+
+	single = find_cp_in_table16(cp, ucs_fallback_singles,
+				    ARRAY_SIZE(ucs_fallback_singles));
+	if (single)
+		return ucs_fallback_singles_subs[single - ucs_fallback_singles];
+
+	return 0;
+}
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index 8167494229db..6180b803795c 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -31,6 +31,7 @@ void console_map_init(void);
 bool ucs_is_double_width(uint32_t cp);
 bool ucs_is_zero_width(uint32_t cp);
 u32 ucs_recompose(u32 base, u32 mark);
+u32 ucs_get_fallback(u32 cp);
 #else
 static inline u16 inverse_translate(const struct vc_data *conp, u16 glyph,
 		bool use_unicode)
@@ -75,6 +76,11 @@ static inline u32 ucs_recompose(u32 base, u32 mark)
 {
 	return 0;
 }
+
+static inline u32 ucs_get_fallback(u32 cp)
+{
+	return 0;
+}
 #endif /* CONFIG_CONSOLE_TRANSLATIONS */
 
 #endif /* __LINUX_CONSOLEMAP_H__ */
-- 
2.49.0

