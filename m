Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7C2566D1;
	Thu, 17 Apr 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915751; cv=none; b=uwkI4k2egKDacW2RscVRZl8N/tRzuwhEXkx6esqDCJNtH2a88DHtar2/Euxl1Nxlukh3J7yMW24QbzzAR3rzbNkrcFmzU81pcyat8EKX4+DTgaOnPLxCBl2DPBloXzy5UYNROUiNsiOAOWkw7DmaRtRArDVXnaiHHAzkhmqppJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915751; c=relaxed/simple;
	bh=QU7c5TLdc70T99bcvA6HgWM/Jzz877a1KLiBOqwlKxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oopD2eZ0GbKh9qBVbKZY/SMqhyvyD4hpCZJDNU1u1lXQKXFTq+nKcKewUz5wSFpR8nz2j7hdX2wpAL4vIdlBVxtBT5Zy1QJXAcMsubzBipvcKSKZyQTJUKKarpVawYFsqdnFkokLfTzNIIy0Yav7II5ih22ncuurrnURvO0b43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=dz75BCDe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bF5kWaaT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="dz75BCDe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bF5kWaaT"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2B74E2540127;
	Thu, 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 17 Apr 2025 14:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915748; x=
	1745002148; bh=TCJd1ihEUnVWBCs2IF3R7qLyU0rcj5kwl5KEKOzYmtk=; b=d
	z75BCDeobwrHkeXfwkPK478Olk1fT+jy0IVbUVebmirMu4M82f/pTmdSB6NnNY/q
	QhtqsK2fZA4hxXX7SqzXEMRwS34Ta21lSQWAzDQwLbdfHWLNLnhJPEAy1WzaPc6J
	WhTokLP/W59bPWKpBUPWXez9n55oVJewwsqFjdGl/282VK3VQHBXxR/IkKgvG3g5
	F7K/9fYR17X1PS3mkz7R22BwbBR73Sci1sTn+jwfsoo5kB82mnMBpl8s0IACO7y7
	xF6zRn3uchF7oIWrKlHYNsa1lw/L/BOCPecq2pFfJugbueV0t15sVEv5o9OFnNyd
	N9e2iAmhd0KnhzPgtOlWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915748; x=1745002148; bh=T
	CJd1ihEUnVWBCs2IF3R7qLyU0rcj5kwl5KEKOzYmtk=; b=bF5kWaaTmRH0zqqso
	99w3VkSXKlVdMcD2uAl9soMQtLry8N+v28+cTLXYiFttmCR3GXy0zPWhr0jQeEhu
	efWxyhcL639R4muQwjPUVq09MNTkvJlqD588v1JTRB4QDRvW+DU3hFajRRKLP2oj
	iETNhhKdAi8PyYFteB1+Y07uc1a16/iL5oJwEJNgKQPpC4AEZWLLodMV7nozsqk2
	0Jecm9w4FN03GdlvAEF8RwZJC1O3g7NYcsjC4NB+oUPxXmG8w+XCkONdukve8wGF
	aXZjPutwv36IzAl6aC24WYDBMkNypOfJUcajDI8u6KLmXH7g7xWkcLlKnoGDNvxA
	yIozA==
X-ME-Sender: <xms:I00BaHAKL8DuKmhn06S3Ak3_5nSC2uI0v_lxrTypu0YzUx77cLtqJw>
    <xme:I00BaNgtnh5Gfu6gq9vwmfbFKdwWbMNntug02cUDnZQd7gH9ZLCY2kVJ9rsMfVN6g
    9X2lZSqGrdIuAwt07Y>
X-ME-Received: <xmr:I00BaCntCbEnI1bOW20DNpN0nh9ZE4wHlOFelSuX9KeeBTEyNak9B-6kogWeomN-a0eD18YjG5Mxqj8Vw2fdBwdj4zCf8SyUeN9PFWcqLzeDbIfMKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedttddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:I00BaJw8_MBHLMV6VS-zkLOoxhbfkJtH0mpJ0wpDnnNIQZVfQ0QOsQ>
    <xmx:I00BaMS67S3RltsYJDfJ4jwSC5sY174mNmTJRVlexc27A7p0VCq7cg>
    <xmx:I00BaMY5m8kaMTqgKmVV4EAtcWE8pAHY3gyptWjbHfhI2yqXqtg7MA>
    <xmx:I00BaNQOJbYrHyCONvJAaIDnofsGYi1c-h4iMUUU1vUfEHJVi8OsUQ>
    <xmx:JE0BaBBCWLWQ8l8tF30MYU0MC0K6X9ayGTsq1hSqZmyV_JJ_DnnVuMYA>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:07 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 0D95611443CA;
	Thu, 17 Apr 2025 14:49:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] vt: move unicode processing to a separate file
Date: Thu, 17 Apr 2025 14:45:04 -0400
Message-ID: <20250417184849.475581-3-nico@fluxnic.net>
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

This will make it easier to maintain. Also make it depend on
CONFIG_CONSOLE_TRANSLATIONS.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/Makefile    |  3 +-
 drivers/tty/vt/ucs.c       | 57 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/vt/vt.c        | 40 +-------------------------
 include/linux/consolemap.h |  6 ++++
 4 files changed, 66 insertions(+), 40 deletions(-)
 create mode 100644 drivers/tty/vt/ucs.c

diff --git a/drivers/tty/vt/Makefile b/drivers/tty/vt/Makefile
index 2c8ce8b592..e24c8546ac 100644
--- a/drivers/tty/vt/Makefile
+++ b/drivers/tty/vt/Makefile
@@ -7,7 +7,8 @@ FONTMAPFILE = cp437.uni
 obj-$(CONFIG_VT)			+= vt_ioctl.o vc_screen.o \
 					   selection.o keyboard.o \
 					   vt.o defkeymap.o
-obj-$(CONFIG_CONSOLE_TRANSLATIONS)	+= consolemap.o consolemap_deftbl.o
+obj-$(CONFIG_CONSOLE_TRANSLATIONS)	+= consolemap.o consolemap_deftbl.o \
+					   ucs.o
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c
diff --git a/drivers/tty/vt/ucs.c b/drivers/tty/vt/ucs.c
new file mode 100644
index 0000000000..dc4a6e7945
--- /dev/null
+++ b/drivers/tty/vt/ucs.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ucs.c - Universal Character Set processing
+ */
+
+#include <linux/array_size.h>
+#include <linux/bsearch.h>
+#include <linux/consolemap.h>
+#include <linux/minmax.h>
+
+/* ucs_is_double_width() is based on the wcwidth() implementation by
+ * Markus Kuhn -- 2007-05-26 (Unicode 5.0)
+ * Latest version: https://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c
+ */
+
+struct ucs_interval {
+	u32 first;
+	u32 last;
+};
+
+static const struct ucs_interval ucs_double_width_ranges[] = {
+	{ 0x1100, 0x115F }, { 0x2329, 0x232A }, { 0x2E80, 0x303E },
+	{ 0x3040, 0xA4CF }, { 0xAC00, 0xD7A3 }, { 0xF900, 0xFAFF },
+	{ 0xFE10, 0xFE19 }, { 0xFE30, 0xFE6F }, { 0xFF00, 0xFF60 },
+	{ 0xFFE0, 0xFFE6 }, { 0x20000, 0x2FFFD }, { 0x30000, 0x3FFFD }
+};
+
+static int interval_cmp(const void *key, const void *element)
+{
+	u32 cp = *(u32 *)key;
+	const struct ucs_interval *entry = element;
+
+	if (cp < entry->first)
+		return -1;
+	if (cp > entry->last)
+		return 1;
+	return 0;
+}
+
+/**
+ * ucs_is_double_width() - Determine if a Unicode code point is double-width.
+ * @cp: Unicode code point (UCS-4)
+ *
+ * Return: true if the character is double-width, false otherwise
+ */
+bool ucs_is_double_width(u32 cp)
+{
+	size_t size = ARRAY_SIZE(ucs_double_width_ranges);
+
+	if (!in_range(cp, ucs_double_width_ranges[0].first,
+			  ucs_double_width_ranges[size - 1].last))
+		return false;
+
+	return __inline_bsearch(&cp, ucs_double_width_ranges, size,
+				sizeof(*ucs_double_width_ranges),
+				interval_cmp) != NULL;
+}
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b5f3c8a818..bcb508bc15 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -104,7 +104,6 @@
 #include <linux/uaccess.h>
 #include <linux/kdb.h>
 #include <linux/ctype.h>
-#include <linux/bsearch.h>
 #include <linux/gcd.h>
 
 #define MAX_NR_CON_DRIVER 16
@@ -2712,43 +2711,6 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 	}
 }
 
-/* is_double_width() is based on the wcwidth() implementation by
- * Markus Kuhn -- 2007-05-26 (Unicode 5.0)
- * Latest version: https://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c
- */
-struct interval {
-	uint32_t first;
-	uint32_t last;
-};
-
-static int ucs_cmp(const void *key, const void *elt)
-{
-	uint32_t ucs = *(uint32_t *)key;
-	struct interval e = *(struct interval *) elt;
-
-	if (ucs > e.last)
-		return 1;
-	else if (ucs < e.first)
-		return -1;
-	return 0;
-}
-
-static int is_double_width(uint32_t ucs)
-{
-	static const struct interval double_width[] = {
-		{ 0x1100, 0x115F }, { 0x2329, 0x232A }, { 0x2E80, 0x303E },
-		{ 0x3040, 0xA4CF }, { 0xAC00, 0xD7A3 }, { 0xF900, 0xFAFF },
-		{ 0xFE10, 0xFE19 }, { 0xFE30, 0xFE6F }, { 0xFF00, 0xFF60 },
-		{ 0xFFE0, 0xFFE6 }, { 0x20000, 0x2FFFD }, { 0x30000, 0x3FFFD }
-	};
-	if (ucs < double_width[0].first ||
-	    ucs > double_width[ARRAY_SIZE(double_width) - 1].last)
-		return 0;
-
-	return bsearch(&ucs, double_width, ARRAY_SIZE(double_width),
-			sizeof(struct interval), ucs_cmp) != NULL;
-}
-
 struct vc_draw_region {
 	unsigned long from, to;
 	int x;
@@ -2953,7 +2915,7 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 	bool inverse = false;
 
 	if (vc->vc_utf && !vc->vc_disp_ctrl) {
-		if (is_double_width(c))
+		if (ucs_is_double_width(c))
 			width = 2;
 	}
 
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index c35db4896c..caf079bcb8 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -28,6 +28,7 @@ int conv_uni_to_pc(struct vc_data *conp, long ucs);
 u32 conv_8bit_to_uni(unsigned char c);
 int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
+bool ucs_is_double_width(uint32_t cp);
 #else
 static inline u16 inverse_translate(const struct vc_data *conp, u16 glyph,
 		bool use_unicode)
@@ -57,6 +58,11 @@ static inline int conv_uni_to_8bit(u32 uni)
 }
 
 static inline void console_map_init(void) { }
+
+static inline bool ucs_is_double_width(uint32_t cp)
+{
+	return false;
+}
 #endif /* CONFIG_CONSOLE_TRANSLATIONS */
 
 #endif /* __LINUX_CONSOLEMAP_H__ */
-- 
2.49.0

