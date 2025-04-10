Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0B81ACA;
	Thu, 10 Apr 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247946; cv=none; b=E+6M9epmns2RKvhSWogDhAvGm7PllT3lNvbq5q4QOQlz3zPxalvAGOeH0tNSW69KHEGaTviyFDaU72REy3aZRMkz2QNYJBuLrtEJ97FNDopKhdAIFJzgQ16DGsLFCSau1cERip2OYpcpm4okswZ0i1WQL/Sht8lkqzdZzysmIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247946; c=relaxed/simple;
	bh=EPQ2+T5lvQ77EhfT2FB/qC2cOFBtiEGp1xB+ycffcgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR0gcR+8sFKiWwNTwzIMMto9TlBf7JYi3RN98lDl8KZBiMG7nl6X49Ol1MW8IBf+xHTfGxtxYKJF5j/nC6lnp2XOUBwBetOa70MKi4py2GVhvzv6aIeT72mdE+mzMxk2+YrjTc1HGiLLOHpwSOzrZLoblSVVhoWI2xJy4R3Adck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=JC/H7c1x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D1I7SxNz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="JC/H7c1x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1I7SxNz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E7C1114028B;
	Wed,  9 Apr 2025 21:19:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 09 Apr 2025 21:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744247942; x=
	1744334342; bh=a3C+3gt5QH+yfaJkHSgYOXuOg6LaWFH4BONRE0arKmk=; b=J
	C/H7c1xFAAgOmJ6shNYN4aRSpVAXhfSiivW6TGutdzopblZGzWOWEu+BxrPyaR4h
	mMI3rRl7LiLDDSqUQyA7gV4jGeDbMRsAjmwGk3QhVY+bXzIfe4z6Hv8U/sjDmf/O
	HFRY+IXCY3h8IjTFqmdRM1XPeGRaNSDYux68csEjIPoZLy6NbLcpjwq4d586kRDq
	Fd75ZOFArKm6XUcMVAuCvclnwy7eZ/0angkjJ3PuoYrgYmWyC2bj5xBEpv4WUPhg
	9I/a51eSfcDozVMT0+sevbTrAY/kaEMLiixBg4hCneoUwitjsZCUcTGwzNrKGH70
	U35UM3cQnD9w+D1gavZ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744247942; x=1744334342; bh=a
	3C+3gt5QH+yfaJkHSgYOXuOg6LaWFH4BONRE0arKmk=; b=D1I7SxNzyb0fIq56Z
	SrR4FfnOz4m0FdT2S7R++JJrCvUlfGvYa7+eYHlfdt/S4qWcasl/OIuaIAWPOt5N
	q046Sl/U+sfVDqOM2JrzWqaM9K0cMv+C37Wer76NtlQ2BdwSfvYdBaPbTObp6IUA
	XMz4yVsTkmYrMp7verkk2X7j+t3TVirkJAGYulsVcpB3XrPprftx4fivdfIRw/T8
	Y9oraBP0AsKJy6KDaZEOBZ72thbKHSnfZdSiqnC6NTSRFbt0IIqVqwhxleyW5YH3
	MmIcdXKA6KPCYmdzc6TsVYtvqLDnValHAyPTovhRMFVBGqoPIbRZxMQFhAxn4MlE
	G16CA==
X-ME-Sender: <xms:hhz3Z3PnfUmYyq-fSqllz-98PAqaxZx_3TOS1tReyZktrPDMOTJs-A>
    <xme:hhz3Zx_6hshqmJ3p4OQHpfEfwdPcp4IPxo7HWoVhQFLdiPnZNNG8POMmqc2oFDwKu
    PqsodiDwXmehpKLgdc>
X-ME-Received: <xmr:hhz3Z2SxJBSgUYoiR-hlq1BmYQF44hYuIYYfYTYXAirjSOI7AO3ESUV3uVrjS195XACTWiSlVSy3S2DL5kU5tg00n7dupaT-12_oEOrnA1Ril3XHEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnhepleektdffjeevfefhiedtudevudetjeejvdej
    uedtvdevveefuedujeejffetieeknecuffhomhgrihhnpegtrghmrdgrtgdruhhknecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehf
    lhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohep
    jhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhgvsehmihgv
    lhhkvgdrtggtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hhz3Z7vLEhC9QtdVf6aMXJrDYMCEyESPGdiTVJ3hpcOsK9ZQxs3QOw>
    <xmx:hhz3Z_eEsvGIOJpgA2YPM6nJxoBLJ_5TpVXjjSx-PMBJ42HgwNgM-w>
    <xmx:hhz3Z30jE5PDE5hFjjWBCyHcthnQPjfN3ZNNYXE_41Ei1jqEKeHtqw>
    <xmx:hhz3Z7_74WC9lUJGDs8SjgkWrltXCqrXpg5BBOHDfYcDztfnaMWMdw>
    <xmx:hhz3Z3-zZXDXCmpJF_3RjDJQkVbEY3lvbSYwDdpMQoYVzz5DbFiYtZ7F>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 21:19:02 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8858E10D8B70;
	Wed,  9 Apr 2025 21:19:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] vt: move unicode processing to a separate file
Date: Wed,  9 Apr 2025 21:13:54 -0400
Message-ID: <20250410011839.64418-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410011839.64418-1-nico@fluxnic.net>
References: <20250410011839.64418-1-nico@fluxnic.net>
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
 drivers/tty/vt/ucs_width.c | 45 ++++++++++++++++++++++++++++++++++++++
 drivers/tty/vt/vt.c        | 40 +--------------------------------
 include/linux/consolemap.h |  6 +++++
 4 files changed, 54 insertions(+), 40 deletions(-)
 create mode 100644 drivers/tty/vt/ucs_width.c

diff --git a/drivers/tty/vt/Makefile b/drivers/tty/vt/Makefile
index 2c8ce8b592..bee69277bb 100644
--- a/drivers/tty/vt/Makefile
+++ b/drivers/tty/vt/Makefile
@@ -7,7 +7,8 @@ FONTMAPFILE = cp437.uni
 obj-$(CONFIG_VT)			+= vt_ioctl.o vc_screen.o \
 					   selection.o keyboard.o \
 					   vt.o defkeymap.o
-obj-$(CONFIG_CONSOLE_TRANSLATIONS)	+= consolemap.o consolemap_deftbl.o
+obj-$(CONFIG_CONSOLE_TRANSLATIONS)	+= consolemap.o consolemap_deftbl.o \
+					   ucs_width.o
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c
diff --git a/drivers/tty/vt/ucs_width.c b/drivers/tty/vt/ucs_width.c
new file mode 100644
index 0000000000..5f0bde30a1
--- /dev/null
+++ b/drivers/tty/vt/ucs_width.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/types.h>
+#include <linux/array_size.h>
+#include <linux/bsearch.h>
+#include <linux/consolemap.h>
+
+/* ucs_is_double_width() is based on the wcwidth() implementation by
+ * Markus Kuhn -- 2007-05-26 (Unicode 5.0)
+ * Latest version: https://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c
+ */
+
+struct interval {
+	uint32_t first;
+	uint32_t last;
+};
+
+static int ucs_cmp(const void *key, const void *elt)
+{
+	uint32_t cp = *(uint32_t *)key;
+	struct interval e = *(struct interval *) elt;
+
+	if (cp > e.last)
+		return 1;
+	else if (cp < e.first)
+		return -1;
+	return 0;
+}
+
+static const struct interval double_width[] = {
+	{ 0x1100, 0x115F }, { 0x2329, 0x232A }, { 0x2E80, 0x303E },
+	{ 0x3040, 0xA4CF }, { 0xAC00, 0xD7A3 }, { 0xF900, 0xFAFF },
+	{ 0xFE10, 0xFE19 }, { 0xFE30, 0xFE6F }, { 0xFF00, 0xFF60 },
+	{ 0xFFE0, 0xFFE6 }, { 0x20000, 0x2FFFD }, { 0x30000, 0x3FFFD }
+};
+
+bool ucs_is_double_width(uint32_t cp)
+{
+	if (cp < double_width[0].first ||
+	    cp > double_width[ARRAY_SIZE(double_width) - 1].last)
+		return false;
+
+	return bsearch(&cp, double_width, ARRAY_SIZE(double_width),
+		       sizeof(struct interval), ucs_cmp) != NULL;
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

