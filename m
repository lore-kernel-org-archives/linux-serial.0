Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8222459CC;
	Tue, 15 Apr 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744942; cv=none; b=CAyA+TxwOollvdpGnpWrvAqb9Ry3H8SPDOhQtXUQYALhPfEaCwuEqebJVf4FEuBq0k2LJsUKS8eunpntaLMURBxywrgNKMhOirX/1LFoDZaoetq+kD7CZMwKLimnwLLSkVQDM9TrJOnzosxxbmWMvnW72LiQ6RtYwBBoKv45Q9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744942; c=relaxed/simple;
	bh=7/xbGdXgd44hVPhgMkh8EAfbgYFKxyQauPlAl58TBpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxRqwP/in5iEpd5hKiUq2TKqx0Ss/EApcrYD5Hn7dhH8udsDDNI7TEeyNeevDyCcRr4UpxhQB6OBER9QE6TNplVE0l32PN9Mya3zlOimEUllHCeWAfbQlewlQCVZp2dxiXD9sN5f0cIVyvYXQ1WI3O/jFwpDzytv61eY67zJFwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=rKCmq1ey; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q/+82lS8; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="rKCmq1ey";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/+82lS8"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B325511401FB;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 15 Apr 2025 15:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744744939; x=
	1744831339; bh=LPrIBk7ZKDmr77uKzmMXChvb1JdCEHvs4IMZkPmQtyE=; b=r
	KCmq1eyV3m3S9uF+fyPj1EvA5ZjeHQ6L40TyO6tGN9jxeevkjyelOXs3kGXBEfHm
	CnmwoN1wIOkfVQZqELltVVm+KvEHB6LgNFazxV2/emtpOYnH/afXs69+VsXptrYC
	0fKU+1nduFZPcBprbdDpnLZN6hjJDiv/hHqTa6vYtuLvGRiNbNnfJvimqZpFeees
	lf8GQFxeQF+XTVFojFF7Zd7wlt82XsYMC9GbvLNo9ZZT8OEFHg7Z1ft6yGYqYZ7t
	cG3f2Hs3J28JSqbmDnndbYO/+uvHzf38293NVtE2XvSZ5FJKAh8KIJSgkfUWIsM2
	3VCU+NKeKw232/52QSTIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744744939; x=1744831339; bh=L
	PrIBk7ZKDmr77uKzmMXChvb1JdCEHvs4IMZkPmQtyE=; b=Q/+82lS84hZeif9iI
	xxqjFPQk/Zm1Jtqw2nuQfd+36Vw35OctMynknVKafvaC8+/yrH08jDJp89lY6qTV
	p3J46kzc1xKfoEW9eHLwGyoe/StRoQKY8SShv8HtodY0pAEQPPhP9Qb9Ms3drL4c
	R8ZT9Tf/VkonOXZOz4mD0c3CY279vFYm4V5JeYsqpRCq4FITWWRYji6OK17k1Wca
	5sLP8CPVx2neIW8jn1344LsOrhFBCOq70JLo/ryXQEyfq0vu7AGUb1fxZqQ5rc5M
	G2lu0h6nHQFKdMXQC6NiGTC8dE3zOd9KIhBAP+9tP1CPX96EWDV9/U+NpFsPku+g
	HeeKw==
X-ME-Sender: <xms:67H-ZygWg36Ik1PRQboxBHsJRBpsI6Hg6evQdvXxNCMGKMiaIgLlUg>
    <xme:67H-ZzB7jggpQmV0SQmlhCzdrOc6pHI5NncYdPi0a6R4fySJxWgUZdnf0JQ8BJjiC
    gazmQtOqGT5Lsu2fEE>
X-ME-Received: <xmr:67H-Z6Hr984KrRoi9jZE__hvKsQzy7_obwrLSY66t96yRdJp_vWeHZePHUQX8JM_AKs2qBRn47b6b7kgiBvxSDaFBBeM48w6OlNM2dYF0UbNm1Gh9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnhepleektdffjeevfefhiedtudevudetjeejvdej
    uedtvdevveefuedujeejffetieeknecuffhomhgrihhnpegtrghmrdgrtgdruhhknecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehf
    lhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohep
    jhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsh
    gvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:67H-Z7RlkfhAj1NZtQ2i_ru9FZ1sscO6hLH6iSR33f_Mkrc0JIDDuw>
    <xmx:67H-Z_zJe40j_FtWhZ0xQpk-FcT3caBgBdjvgYNcnnk0IYREp_qbVQ>
    <xmx:67H-Z54EZLJ0wtTSnw1I7adQ7VJxC991GsZ_2PhV0jEeBMh9VffeEg>
    <xmx:67H-Z8x8AYnWFShg8unnNyWZdXAnwLif-X0-4ia4ZwnSSCGmI4rF0Q>
    <xmx:67H-Z-jwBevoDskGLQzCzwrbSEQLZMLd21xi3JMX6gMjoGYtSW_aDbIX>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8FF59111660F;
	Tue, 15 Apr 2025 15:22:18 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] vt: use new tables in ucs.c
Date: Tue, 15 Apr 2025 15:17:55 -0400
Message-ID: <20250415192212.33949-7-nico@fluxnic.net>
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

This removes the table from ucs.c and substitutes the generated tables
from ucs_width_table.h providing comprehensive ranges for double-width
and zero-width Unicode code points.

Also implements ucs_is_zero_width() to query the new zero-width table.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/ucs.c       | 44 +++++++++++++++++++++-----------------
 include/linux/consolemap.h |  6 +-----
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/vt/ucs.c b/drivers/tty/vt/ucs.c
index 0f6c087158..5e71aa3896 100644
--- a/drivers/tty/vt/ucs.c
+++ b/drivers/tty/vt/ucs.c
@@ -5,22 +5,12 @@
 #include <linux/consolemap.h>
 #include <linux/minmax.h>
 
-/* ucs_is_double_width() is based on the wcwidth() implementation by
- * Markus Kuhn -- 2007-05-26 (Unicode 5.0)
- * Latest version: https://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c
- */
-
 struct ucs_interval {
 	u32 first;
 	u32 last;
 };
 
-static const struct ucs_interval ucs_double_width_ranges[] = {
-	{ 0x1100, 0x115F }, { 0x2329, 0x232A }, { 0x2E80, 0x303E },
-	{ 0x3040, 0xA4CF }, { 0xAC00, 0xD7A3 }, { 0xF900, 0xFAFF },
-	{ 0xFE10, 0xFE19 }, { 0xFE30, 0xFE6F }, { 0xFF00, 0xFF60 },
-	{ 0xFFE0, 0xFFE6 }, { 0x20000, 0x2FFFD }, { 0x30000, 0x3FFFD }
-};
+#include "ucs_width_table.h"
 
 static int interval_cmp(const void *key, const void *element)
 {
@@ -34,6 +24,27 @@ static int interval_cmp(const void *key, const void *element)
 	return 0;
 }
 
+static bool cp_in_range(u32 cp, const struct ucs_interval *ranges, size_t size)
+{
+	if (!in_range(cp, ranges[0].first, ranges[size - 1].last))
+		return false;
+
+	return __inline_bsearch(&cp, ranges, size, sizeof(*ranges),
+				interval_cmp) != NULL;
+}
+
+/**
+ * Determine if a Unicode code point is zero-width.
+ *
+ * @param cp: Unicode code point (UCS-4)
+ * Return: true if the character is zero-width, false otherwise
+ */
+bool ucs_is_zero_width(u32 cp)
+{
+	return cp_in_range(cp, ucs_zero_width_ranges,
+			   ARRAY_SIZE(ucs_zero_width_ranges));
+}
+
 /**
  * Determine if a Unicode code point is double-width.
  *
@@ -42,13 +53,6 @@ static int interval_cmp(const void *key, const void *element)
  */
 bool ucs_is_double_width(u32 cp)
 {
-	size_t size = ARRAY_SIZE(ucs_double_width_ranges);
-
-	if (!in_range(cp, ucs_double_width_ranges[0].first,
-			  ucs_double_width_ranges[size - 1].last))
-		return false;
-
-	return __inline_bsearch(&cp, ucs_double_width_ranges, size,
-				sizeof(*ucs_double_width_ranges),
-				interval_cmp) != NULL;
+	return cp_in_range(cp, ucs_double_width_ranges,
+			   ARRAY_SIZE(ucs_double_width_ranges));
 }
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index 7d778752dc..b3a9118666 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -29,11 +29,7 @@ u32 conv_8bit_to_uni(unsigned char c);
 int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
 bool ucs_is_double_width(uint32_t cp);
-static inline bool ucs_is_zero_width(uint32_t cp)
-{
-	/* coming soon */
-	return false;
-}
+bool ucs_is_zero_width(uint32_t cp);
 #else
 static inline u16 inverse_translate(const struct vc_data *conp, u16 glyph,
 		bool use_unicode)
-- 
2.49.0

