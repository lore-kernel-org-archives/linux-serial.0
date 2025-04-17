Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69DB256C6B;
	Thu, 17 Apr 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915751; cv=none; b=jPWnUUW5lEF5c9+CyRypJIqEKINTOgpt3aasfaDtoEP1LPuEENN/pVeqhCakKQLdQhBtLs+sJcPugLxU8brH7Xzvh0D8D7cCXhW7rGgcTTEyor3N0SzwoPMnSqrnAfjuEWx+T+ePWjnnp6AAvhHrNQ/O8TGRnbthuEnbwBrzjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915751; c=relaxed/simple;
	bh=uxGsu/wxj7Y9HMsOw9sXMws2D/dMPtGMl9cKeewvKXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm+R1wtPDPSI2fySHXNqyUaX8hHtq1Eav6idaCXn5c0qZKuBzLclV0ZUlZDnWxPJWGhtAoWC7ZmuYeuFLeCuFcfrG2GGxbmfIqn3q412x1Djfv+g8fU1FO7SD7JyHg+vLaUE9HLHCJBkeEi/IBCeuHnoKi7FjCObuEUNYDyfzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=fIUQBKOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k+iuIjo6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="fIUQBKOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+iuIjo6"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13ADA25400A1;
	Thu, 17 Apr 2025 14:49:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 17 Apr 2025 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915748; x=
	1745002148; bh=x+K1zhmTOuyWbLByYmIv9Lh65bEKEmySLPXhoU2GsVc=; b=f
	IUQBKOQTaMz8jIOx9LNA2Wa1H52JrznO28mn6vGgyVpm35jjFPsWAXpRtU4VIVXf
	Jf3N/Z++Gzk3RggyExZNyNUXoHp3SUuayYIufnW0jrNQT28LGthAns5ylMV4IrBq
	TQPvsyF3bgWuGIIIszoy7PeNKW3pBglQt2IDCcN3nRtyk/fmVmrDIT19YVVESXTF
	kdKy+CaFUx208DcGx7IoUa8fkZosP3dO4uL7TcrkgCLAZ7ZVzomfhR8rc1vJU4GJ
	tiEci78FlHJqf45elqOkjL1r6ix/lt9u2Y6RjRSIZCwm5B5tT8kGS8JP5XL9uJga
	nMGPPVpbtZefpWY9h2UjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915748; x=1745002148; bh=x
	+K1zhmTOuyWbLByYmIv9Lh65bEKEmySLPXhoU2GsVc=; b=k+iuIjo6DRJBuOW+h
	N5L9W3w2AeVz5C4lZQI44TrLAb/EFf0sGjrchOVFIgxNVYIe1/JNWXji6J58aiVh
	ySEILMgoVEnXE4iWhcqqGQyGBz7KvucNbmTu8AoFPNMu3A2nwEBj9/Z3/EPe1ZKu
	4StNTjoZdQAgc1Kr+AOwLNEhTeAyf+1M5NRMXwEVmQtuh9FsOla1AuYceEQNoOT1
	vwi5RiCVl+EGLJGcYR1F/EMGk4jZgZYsfRG2IysOkKAqlL8bHyaZD+SMTXdbPQl2
	EvSDw/OBmLvZncRfZV0aWq1J2ukAea5R/rNlVRurEkUfhaVNJddYHCzp0uxIvKxV
	p7gLg==
X-ME-Sender: <xms:JE0BaNGB6lfyk2IYERJ5QoY4Hfuj46ab4UtncZlqEpJxWg4YsMl7uQ>
    <xme:JE0BaCUoHVIji0DH6zBDekL97WeSlrGxBgXyytU733CFuM5pSJ61dcjWVu_tXGKHb
    Y7T48eZfd5_EfMP4rQ>
X-ME-Received: <xmr:JE0BaPKt9zcDQrskXQ-8oldtlgYqK2O_nzwp4G-IhhG-oyhS6CaJIJFLYwm4IWiP8RoeaypJ20qIGnjDBAonspujVi20eivsWS5wa1o0lh83n39aQA>
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
X-ME-Proxy: <xmx:JE0BaDHot9YMCzfEk6xWCWJNfgJf_fic0rLuKuhHGpdsumUVH9tnhA>
    <xmx:JE0BaDWnWW74yO6-HFrTGm2Lc67dowxG9gD7D2mmJQrK5dlRB1FgPg>
    <xmx:JE0BaONrKCSyx_f5oP1WYYcAJy95do47NlEPiLvE6asLG3qgeMUFWQ>
    <xmx:JE0BaC1zBXgiOzU4rFuTGTfh9dcSuFyyqAmRF8Vk6W7hXOnHxmVYIQ>
    <xmx:JE0BaK0r7I0Rdm7GyTuhzV-_vsSJmy7C2GnBjLbdsIpOwWBf8KI3T4j7>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8004211443D0;
	Thu, 17 Apr 2025 14:49:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/14] vt: use new tables in ucs.c
Date: Thu, 17 Apr 2025 14:45:08 -0400
Message-ID: <20250417184849.475581-7-nico@fluxnic.net>
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

This removes the table from ucs.c and substitutes the generated tables
from ucs_width_table.h providing comprehensive ranges for double-width
and zero-width Unicode code points.

Also implements ucs_is_zero_width() to query the new zero-width table.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/ucs.c       | 44 +++++++++++++++++++++-----------------
 include/linux/consolemap.h |  6 +-----
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/vt/ucs.c b/drivers/tty/vt/ucs.c
index dc4a6e7945..5f9f25bd20 100644
--- a/drivers/tty/vt/ucs.c
+++ b/drivers/tty/vt/ucs.c
@@ -8,22 +8,12 @@
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
@@ -37,6 +27,27 @@ static int interval_cmp(const void *key, const void *element)
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
+ * ucs_is_zero_width() - Determine if a Unicode code point is zero-width.
+ * @cp: Unicode code point (UCS-4)
+ *
+ * Return: true if the character is zero-width, false otherwise
+ */
+bool ucs_is_zero_width(u32 cp)
+{
+	return cp_in_range(cp, ucs_zero_width_ranges,
+			   ARRAY_SIZE(ucs_zero_width_ranges));
+}
+
 /**
  * ucs_is_double_width() - Determine if a Unicode code point is double-width.
  * @cp: Unicode code point (UCS-4)
@@ -45,13 +56,6 @@ static int interval_cmp(const void *key, const void *element)
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

