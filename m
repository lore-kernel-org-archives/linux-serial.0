Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56350154BF5;
	Wed,  7 May 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627346; cv=none; b=cvvVYhmT9IwdKPb4baxg3NWfcTscGFDaawPZ/QGnwIRDWEtpSkpR2k9znDStKVN/d5VYFO62GcZm+GhjeEuNvumLW1mYKJKMWJu3Xv5zYhScwI3bODOV4WiU7Non7AtmPhZxz9EdkJjgLDWts92AWDHx5AZ94nTNiNSYIZkI4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627346; c=relaxed/simple;
	bh=fOydz4y/drJAKR93N8GFIJaT0o5lVRI0cMA3Qph5onc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaCPYX9JzGcFusTkJnhf6gwIPL7B8ujG30rHrBaMwlX3LY+YJbiObmBRYs748D263uanZseSz9VkzhF0+uVejFL8Nifsb/jmVqjs8XqTGhbuLh+1IdqDnbVAcu6NZcZAvX/JSlSSsBIpfuWUFA/JleNdsq3tKQPa+NLoEVJ1gRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=WHMglofU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQxI3y3Y; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="WHMglofU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQxI3y3Y"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BDEE114017C;
	Wed,  7 May 2025 10:15:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 10:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1746627343; x=
	1746713743; bh=Py0Va1HDiIsGqDWWb5pBWUG7kvw0GVMTGbRUvoizj3Q=; b=W
	HMglofUAwSeNBM2l8zXPrGUmQGNGi57xBOjbm+kiaT8ZJYzAwuuh4k1b+V+vSQUX
	Okrx8GvQlH8U7qYMUJ638dWu/0ZAc4yLEDBFkKnW7GjfuC7OR8M8f4oVFxNnGD38
	PVSEc9RaQkT7IuQGiifG2PSZY5HmLRWEyu7WafEEF0m6o9AtJJzIACwB772sHbgq
	nR07F46iDYnpXe5GmFyPJ/w0l9eYUbiMYm+aeFN3aw/HjrBG4sxV4yE/Cwb8Dg4o
	jfhULA0eoCObE5cXzuIaKySP/p8RriDcLBqyIKZQ/bpXMp/fdeCCwIUUFakZt6Np
	kDc+m8J8cqNJD2757tqKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746627343; x=1746713743; bh=P
	y0Va1HDiIsGqDWWb5pBWUG7kvw0GVMTGbRUvoizj3Q=; b=QQxI3y3YdBRIcRrPn
	jFa7duJhMtcOfe0y2DcmXiqTS02imsJ2ygUxAdJlLk9u3BXAEbpX3EnsttN56FzZ
	UqhUFb4D9Jas0D/3opatpkEdzPyGTDQqsuK9XMU9ppNkcr1mlJ8KOgqiCtBVWRo2
	CYyJdgOqnYE2Cgck9AemXtAngMe1w+VJna1x8sLIAlAg8BsDyyHK8MrmgR0AaKME
	zJWPwUzhgsbRgfSt9DdMYSx7F7aZK2KMC64SAPmuTfbg1s7HF6zuzF5hOJ5tVUK/
	ijB/5bhyqkYsL8y9hngJJC86zaD8M2jIhx/mkURZXFqo+mnlIzxNo3Mv6u5xUyDa
	MM5wA==
X-ME-Sender: <xms:D2sbaAYbzDn4wagFdICIRzO6KhcaLUJHJ1kHwDAJ5-2MmckJHtuywQ>
    <xme:D2sbaLYBrWEItdJiwBkbdkv9P-k067SriSSG3czipRudves79ihLFz9m7FgzmsKtC
    J7saEujf5sTcaEFTh8>
X-ME-Received: <xmr:D2sbaK-WW2U0dzI-ccoUYB7_log_FzQL6H3pArvK9PxL3KnyilWG8suwqmeEv85kIVBBgYfNu4XySDatukpIiwLoD5vbEGDnLZ_sCSpl5QSKanb6jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeek
    udekfeffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhi
    hlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:D2sbaKrOl2GI4U7y_4o_UUfNOfWPE1c06SUIhkeTcVnuzkYjG7juHg>
    <xmx:D2sbaLp-Sx5Atdm_bXWV6hsXiBUTsR8xxWOc1nAusk_0UCGyeXKmKQ>
    <xmx:D2sbaIStXlrWQEAJjK1TmVatlrIFi9YbO-EJ0ENw6qbhqV0UeDkQ-w>
    <xmx:D2sbaLoKgmqbJaTduorsp_Zwecpoxfc1nLw3Vlf6CQrXa7xdIc-EWw>
    <xmx:D2sbaM5a0iCASPD4u66oFEJU12fOr2iPTvZxRxV1mBg1grlTLXT1vx9V>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 10:15:42 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6A7C51189EA8;
	Wed, 07 May 2025 10:15:42 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] vt: add ucs_get_fallback()
Date: Wed,  7 May 2025 10:13:21 -0400
Message-ID: <20250507141535.40655-7-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507141535.40655-1-nico@fluxnic.net>
References: <20250507141535.40655-1-nico@fluxnic.net>
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
 drivers/tty/vt/ucs.c       | 84 ++++++++++++++++++++++++++++++++++++++
 include/linux/consolemap.h |  6 +++
 3 files changed, 92 insertions(+), 1 deletion(-)

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
index b0b23830170d..6c15c5deda5b 100644
--- a/drivers/tty/vt/ucs.c
+++ b/drivers/tty/vt/ucs.c
@@ -157,3 +157,87 @@ u32 ucs_recompose(u32 base, u32 mark)
 
 	return result ? result->recomposed : 0;
 }
+
+/*
+ * The fallback table structures implement a 2-level lookup.
+ */
+
+struct ucs_page_desc {
+	u8 page;	/* Page index (high byte of code points) */
+	u8 count;	/* Number of entries in this page */
+	u16 start;	/* Start index in entries array */
+};
+
+struct ucs_page_entry {
+	u8 offset;	/* Offset within page (0-255) */
+	u8 fallback;	/* Fallback character or range start marker */
+};
+
+#include "ucs_fallback_table.h"
+
+static int ucs_page_desc_cmp(const void *key, const void *element)
+{
+	u8 page = *(u8 *)key;
+	const struct ucs_page_desc *entry = element;
+
+	if (page < entry->page)
+		return -1;
+	if (page > entry->page)
+		return 1;
+	return 0;
+}
+
+static int ucs_page_entry_cmp(const void *key, const void *element)
+{
+	u8 offset = *(u8 *)key;
+	const struct ucs_page_entry *entry = element;
+
+	if (offset < entry->offset)
+		return -1;
+	if (entry->fallback == UCS_PAGE_ENTRY_RANGE_MARKER) {
+		if (offset > entry[1].offset)
+			return 1;
+	} else {
+		if (offset > entry->offset)
+			return 1;
+	}
+	return 0;
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
+	const struct ucs_page_desc *page;
+	const struct ucs_page_entry *entry;
+	u8 page_idx = cp >> 8, offset = cp;
+
+	if (!UCS_IS_BMP(cp))
+		return 0;
+
+	page = __inline_bsearch(&page_idx, ucs_fallback_pages,
+				ARRAY_SIZE(ucs_fallback_pages),
+				sizeof(*ucs_fallback_pages),
+				ucs_page_desc_cmp);
+	if (!page)
+		return 0;
+
+	entry = __inline_bsearch(&offset, ucs_fallback_entries + page->start,
+				 page->count, sizeof(*ucs_fallback_entries),
+				 ucs_page_entry_cmp);
+	if (!entry)
+		return 0;
+
+	if (entry->fallback == UCS_PAGE_ENTRY_RANGE_MARKER)
+		entry++;
+	return entry->fallback;
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

