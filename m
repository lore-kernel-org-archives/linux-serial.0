Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DBF2459C9;
	Tue, 15 Apr 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744942; cv=none; b=PmKYlEMtu+GKHmIY0MHO3GUYxMtMhnn9unpFvqJtjaBA/+ZiEdu3SnE+NGEpsCz9OeXMPKZNignurrLLLQXTOfaYBoJuHsCxM/q4mSnGbtincBF/WFdOlGgdmA4o9oGRqPTet+qYLIPVCtBuxlucsTG8fZ4wRZztM1P3FDDP8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744942; c=relaxed/simple;
	bh=NyX9+XHAPpgGkQEpbtB7kEzTbTnlO8qkKoMp0MY6b08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxvIH8JmihPECj4IxcrQQ0D4FnNi2SyKYO5U06yu9zUEXJ8ll+U19Fp8KK5bmZXuQHNnyvd/EH52TfvhRslJF19gQP4G8gxRcJGQXyTxlQt/DglSJS7OcIxrRq3qW2znaR8NlMPNfvyqo5S3t7CxmSLAn7FI2F2w4hQfgxD1ONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=bO7+uT8E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HxAUNMTf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="bO7+uT8E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HxAUNMTf"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D9C013801DE;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 15:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744744939; x=
	1744831339; bh=FpoEp//AvN/ZsJcRm4eIP7BGc+NywZPXBlR30kcYKCM=; b=b
	O7+uT8ElnC8vSrRRbw6IVwyAfg7rLSwmmmYgebXAGCcb6V784TH8ToG6exDdCz5V
	zIgRQeXxB1c0utGovMlPJzrcjPJWjeHOJoY8IX0DtLE6QQ7PHIbVt8L98UmcCzc+
	Dx9hN5Zk2tCmzct4ZQZdqdxpKFLLIWoFMGNKC5pDQAhsZT8wqJo0VY6ZISN8YZIl
	6hmbd3XRudfxkmYVebYNIiig3AEMpfAy0C9ZrtkmxIKdh0TBqEKOSKOVyDZo00HI
	8S3nu6KLhik5uATx5QJnCcKXLR0CpbohxyGzVuPuB5VTD3VW5EnDrXRE14nkRmbu
	w7rFYpfOfMvVqWTEBcegQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744744939; x=1744831339; bh=F
	poEp//AvN/ZsJcRm4eIP7BGc+NywZPXBlR30kcYKCM=; b=HxAUNMTf0owBaaRKm
	aPiqPHyn8Vi2jnvUBqri2bRtjZUb7ySng/jF3FAdE3EkUeMGJlbbMGiRDzxuuL7a
	hujRRSvqiBBjPlyRb2wxz//5RzDU0QJQzWlAYd3+42ABVzs2Do0ZTVTtsK2PMGjM
	x+bfDFmB2G5+GMYMehvhcRI/q4jjiET0yNG0UqeyzDsKjuwXU7lWC7JtW79qBX0l
	SIBpFcRSSbs6b0R02f8FMVWx8jkuazbhTIuwkomYt3NUEtBqUPmlzATapHwUc/Xo
	PqRubrsihnMVGe/2PqaEl5six42tQoOQAS3u9tColVMaLDTaNrhXMf7eTcLWdSEz
	T11Eg==
X-ME-Sender: <xms:6rH-Z889m1lrTvYku-F2s4aiJ55CjDrxY28TcFIEDV5N_PnHuR8ncg>
    <xme:6rH-Z0tna2XpybZYJm9g5CZEy6y5voga-lkeu9wTgZYhLB_HwGT23N8Z-YlGkTvVO
    sqFrP9OWRkXhRgMJys>
X-ME-Received: <xmr:6rH-ZyC1DOgznJy5fdvOox4Q8KFawKdAQTVkbvjNHwd3bmPzkCX9kQfkaA8mOp74v2fvQMXWombCQLgfqPKgrkSRBAiSoBjZosyls8MqDKmdTTnwoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:6rH-Z8dKhzZYLj3PmGqu_jDc3Mb-7hfBR-OkJhZMJaIkGvTTeBYlnA>
    <xmx:6rH-ZxNlgYK_x1lWkyo5bEFMDChzkT3UqLawz6HeKOevrt6il4d4ig>
    <xmx:6rH-Z2m3UfpUuQWNMSO3rRRPQ8Jlz_GeN7LVainjV55iazL_wCpSHQ>
    <xmx:6rH-Zzv__JRvGu4mi3wZsQTW20Ld_uiC1V-tRRVrjaMQZhBbyFovRg>
    <xmx:67H-ZzOo0AmJGzuKJ4uiVRUr0btK0IvmmR6JJ9Kdt6dvxo_NjgAEquy8>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:18 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 02B321116609;
	Tue, 15 Apr 2025 15:22:18 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] vt: move unicode processing to a separate file
Date: Tue, 15 Apr 2025 15:17:51 -0400
Message-ID: <20250415192212.33949-3-nico@fluxnic.net>
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

This will make it easier to maintain. Also make it depend on
CONFIG_CONSOLE_TRANSLATIONS.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/Makefile    |  3 ++-
 drivers/tty/vt/ucs.c       | 54 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/vt/vt.c        | 40 +---------------------------
 include/linux/consolemap.h |  6 +++++
 4 files changed, 63 insertions(+), 40 deletions(-)
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
index 0000000000..0f6c087158
--- /dev/null
+++ b/drivers/tty/vt/ucs.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
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
+ * Determine if a Unicode code point is double-width.
+ *
+ * @param cp: Unicode code point (UCS-4)
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

