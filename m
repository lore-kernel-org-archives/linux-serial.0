Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E219ABC6;
	Thu, 17 Apr 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915752; cv=none; b=tU0gNGytQ9dWFJVu6e+zuQVzvfa9Fc6RTDr40IeDyGvRTQN6tNi0BE+Z+ofsCOfuddhh17quzPZwac9kXh4jgoWuGmU1JQTqHgl/LS9Clv6jOuw+j7AAZySVypvVC+5v2X3F9pVw7g2vP5pf/4Y2DU4oJ7gXqlPQvaoMTgfkZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915752; c=relaxed/simple;
	bh=rUStBhaJZo62KGaIdMZrh1mrFObHiOrl6QxR9GZBl5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSRdsqp+J9KOVUX2l86Nwi7oUHmUsE0Ab3HZiTrmRxUarl9ldFaP/kznzzGPEXscZPs8SB3TVwh4NEGQmgqxnETNITANL+dk2Jtwt62SugmdCPp8zdjiOg3YZ1lQ8b6T0mIKeikP0HPoUu7gGxS/YPV9plwOoplW2QeOOA3oNFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=iTohIEQv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PphzqQZH; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="iTohIEQv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PphzqQZH"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F97211400DC;
	Thu, 17 Apr 2025 14:49:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 17 Apr 2025 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915748; x=
	1745002148; bh=F0YeLrJtygHFU6nH568VzC5840TAdlTewergicJA8qM=; b=i
	TohIEQvVhzUyG3Ej5JPnYx5kGskfIdWWQXaWkNKrRJLjRLNx/TjA1rUL7pcLFurT
	CxgtJUvYKJ6jpSSrnal+1GG+kdhh/nMqZphMqIqhSIPOQ9aXp98707LwUHojrCeI
	C6thXStDgsIm8sEdiChUI8/Grzfy9UGQtbrx/7nukNuMR2po/VlcpAYmlT8aXrn0
	eiynOVhWb8fm12hzbFDjRkZhhkRi7tvWn4ni11ep21wBazxfvMZfOBLU2SEsNKOp
	kDYqEqjod4C0rLuAgTiVGF59QOfq7rTjVWBpVIENRqH3Ksp4VylnfMHbKlZf5S/o
	y5OL7ABugZDfarb61bpmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915748; x=1745002148; bh=F
	0YeLrJtygHFU6nH568VzC5840TAdlTewergicJA8qM=; b=PphzqQZH0htYaa7GA
	a7xRdjGIGQEJ6LqnlfbpLw0hZHdUGkphtzCMWPl98MVl67QieiGoqjzgyisCvwLQ
	ESbtYkOEVProDToSd1Nd8YFV4Ob8rzSuYiAKRIVo43PgU5wtPTSd/1ukHwn9w3uE
	f2ar5HfmMhkVv/NopFzKIVg+zAM7JItgkejQinMiD8I+jS3OKW66rjQ6/T47TPP6
	2s1KApXTb7DPWQ1A5HkCD3elI5Os3vfYx/yR3OKyaDN5PYo/9Ji7R1x4gGFazHic
	YSOTYdMx3YrIgmrG+jh9EiBc3ziBzDKI4e2gClSa/uxMukhBE9t3zBoogKahKB+r
	c6nyQ==
X-ME-Sender: <xms:JE0BaHanP4rklkdkZHKQ2vrleEnP86V8YxD08qltWNBkGPZpIQ97OQ>
    <xme:JE0BaGZtTApEv-yjcVtdZ1_GL5YTh9qBq5BMm5LkvZXpkSdSD5aFbHZIGU16-2N22
    w9XuCOaJ659PoGTf9s>
X-ME-Received: <xmr:JE0BaJ-QPFLjQ2Wja4oYD52gkgtg9uosHQhBWU2jYqtdTgbpPibebgZI7zZVR-Bf2pLb6RvDA8d7q3ENt_igTqnkAWF7iDHp-nWMN4VtWcMSEhkqKA>
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
X-ME-Proxy: <xmx:JE0BaNrZL-d5E_NSyUbVhrCozmSFlJSysxT4pDEkf1n42p7vozmw3g>
    <xmx:JE0BaCpiVYrXAvJ8AK9NWT4W0v2xYkVd7lM-PwlzmQ9HSUdEXxLUVA>
    <xmx:JE0BaDQkKwi4U1kNKH3ULWOwhz403v1L-33ZDe9yvKlExnkCiDfGoQ>
    <xmx:JE0BaKqzcid5HDzpcXzH_KqgRMgRbPnEx6IWSnSZR5JOWFEpGb-20g>
    <xmx:JE0BaH4ZNikWChNpPy0merBiSMzA0Az3vlUm-Azl6oRYn52hEcD-B0jd>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id BE51611443D3;
	Thu, 17 Apr 2025 14:49:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/14] vt: create ucs_recompose_table.h with gen_ucs_recompose_table.py
Date: Thu, 17 Apr 2025 14:45:10 -0400
Message-ID: <20250417184849.475581-9-nico@fluxnic.net>
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

Table of base character + combining mark pairs with their precomposed
equivalents.

Note: scripts/checkpatch.pl complains about "... exceeds 100 columns".
      Please ignore.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/ucs_recompose_table.h | 102 +++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 drivers/tty/vt/ucs_recompose_table.h

diff --git a/drivers/tty/vt/ucs_recompose_table.h b/drivers/tty/vt/ucs_recompose_table.h
new file mode 100644
index 0000000000..bd91edde5d
--- /dev/null
+++ b/drivers/tty/vt/ucs_recompose_table.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ucs_recompose_table.h - Unicode character recomposition
+ *
+ * Auto-generated by gen_ucs_recompose_table.py
+ *
+ * Unicode Version: 16.0.0
+ *
+ * This file contains a table with most commonly used Latin, Greek, and
+ * Cyrillic recomposition pairs only (71 entries). To generate a table with
+ * all possible recomposition pairs from the Unicode BMP (1000 entries)
+ * instead, run:
+ *
+ *   python gen_ucs_recompose_table.py --full
+ */
+
+/*
+ * Table of most commonly used Latin, Greek, and Cyrillic recomposition pairs only
+ * Sorted by base character and then combining mark for binary search
+ */
+static const struct ucs_recomposition ucs_recomposition_table[] = {
+	{ 0x0041, 0x0300, 0x00C0 }, /* LATIN CAPITAL LETTER A + COMBINING GRAVE ACCENT = LATIN CAPITAL LETTER A WITH GRAVE */
+	{ 0x0041, 0x0301, 0x00C1 }, /* LATIN CAPITAL LETTER A + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER A WITH ACUTE */
+	{ 0x0041, 0x0302, 0x00C2 }, /* LATIN CAPITAL LETTER A + COMBINING CIRCUMFLEX ACCENT = LATIN CAPITAL LETTER A WITH CIRCUMFLEX */
+	{ 0x0041, 0x0303, 0x00C3 }, /* LATIN CAPITAL LETTER A + COMBINING TILDE = LATIN CAPITAL LETTER A WITH TILDE */
+	{ 0x0041, 0x0308, 0x00C4 }, /* LATIN CAPITAL LETTER A + COMBINING DIAERESIS = LATIN CAPITAL LETTER A WITH DIAERESIS */
+	{ 0x0041, 0x030A, 0x00C5 }, /* LATIN CAPITAL LETTER A + COMBINING RING ABOVE = LATIN CAPITAL LETTER A WITH RING ABOVE */
+	{ 0x0043, 0x0327, 0x00C7 }, /* LATIN CAPITAL LETTER C + COMBINING CEDILLA = LATIN CAPITAL LETTER C WITH CEDILLA */
+	{ 0x0045, 0x0300, 0x00C8 }, /* LATIN CAPITAL LETTER E + COMBINING GRAVE ACCENT = LATIN CAPITAL LETTER E WITH GRAVE */
+	{ 0x0045, 0x0301, 0x00C9 }, /* LATIN CAPITAL LETTER E + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER E WITH ACUTE */
+	{ 0x0045, 0x0302, 0x00CA }, /* LATIN CAPITAL LETTER E + COMBINING CIRCUMFLEX ACCENT = LATIN CAPITAL LETTER E WITH CIRCUMFLEX */
+	{ 0x0045, 0x0308, 0x00CB }, /* LATIN CAPITAL LETTER E + COMBINING DIAERESIS = LATIN CAPITAL LETTER E WITH DIAERESIS */
+	{ 0x0049, 0x0300, 0x00CC }, /* LATIN CAPITAL LETTER I + COMBINING GRAVE ACCENT = LATIN CAPITAL LETTER I WITH GRAVE */
+	{ 0x0049, 0x0301, 0x00CD }, /* LATIN CAPITAL LETTER I + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER I WITH ACUTE */
+	{ 0x0049, 0x0302, 0x00CE }, /* LATIN CAPITAL LETTER I + COMBINING CIRCUMFLEX ACCENT = LATIN CAPITAL LETTER I WITH CIRCUMFLEX */
+	{ 0x0049, 0x0308, 0x00CF }, /* LATIN CAPITAL LETTER I + COMBINING DIAERESIS = LATIN CAPITAL LETTER I WITH DIAERESIS */
+	{ 0x004E, 0x0303, 0x00D1 }, /* LATIN CAPITAL LETTER N + COMBINING TILDE = LATIN CAPITAL LETTER N WITH TILDE */
+	{ 0x004F, 0x0300, 0x00D2 }, /* LATIN CAPITAL LETTER O + COMBINING GRAVE ACCENT = LATIN CAPITAL LETTER O WITH GRAVE */
+	{ 0x004F, 0x0301, 0x00D3 }, /* LATIN CAPITAL LETTER O + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER O WITH ACUTE */
+	{ 0x004F, 0x0302, 0x00D4 }, /* LATIN CAPITAL LETTER O + COMBINING CIRCUMFLEX ACCENT = LATIN CAPITAL LETTER O WITH CIRCUMFLEX */
+	{ 0x004F, 0x0303, 0x00D5 }, /* LATIN CAPITAL LETTER O + COMBINING TILDE = LATIN CAPITAL LETTER O WITH TILDE */
+	{ 0x004F, 0x0308, 0x00D6 }, /* LATIN CAPITAL LETTER O + COMBINING DIAERESIS = LATIN CAPITAL LETTER O WITH DIAERESIS */
+	{ 0x0055, 0x0300, 0x00D9 }, /* LATIN CAPITAL LETTER U + COMBINING GRAVE ACCENT = LATIN CAPITAL LETTER U WITH GRAVE */
+	{ 0x0055, 0x0301, 0x00DA }, /* LATIN CAPITAL LETTER U + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER U WITH ACUTE */
+	{ 0x0055, 0x0302, 0x00DB }, /* LATIN CAPITAL LETTER U + COMBINING CIRCUMFLEX ACCENT = LATIN CAPITAL LETTER U WITH CIRCUMFLEX */
+	{ 0x0055, 0x0308, 0x00DC }, /* LATIN CAPITAL LETTER U + COMBINING DIAERESIS = LATIN CAPITAL LETTER U WITH DIAERESIS */
+	{ 0x0059, 0x0301, 0x00DD }, /* LATIN CAPITAL LETTER Y + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER Y WITH ACUTE */
+	{ 0x0061, 0x0300, 0x00E0 }, /* LATIN SMALL LETTER A + COMBINING GRAVE ACCENT = LATIN SMALL LETTER A WITH GRAVE */
+	{ 0x0061, 0x0301, 0x00E1 }, /* LATIN SMALL LETTER A + COMBINING ACUTE ACCENT = LATIN SMALL LETTER A WITH ACUTE */
+	{ 0x0061, 0x0302, 0x00E2 }, /* LATIN SMALL LETTER A + COMBINING CIRCUMFLEX ACCENT = LATIN SMALL LETTER A WITH CIRCUMFLEX */
+	{ 0x0061, 0x0303, 0x00E3 }, /* LATIN SMALL LETTER A + COMBINING TILDE = LATIN SMALL LETTER A WITH TILDE */
+	{ 0x0061, 0x0308, 0x00E4 }, /* LATIN SMALL LETTER A + COMBINING DIAERESIS = LATIN SMALL LETTER A WITH DIAERESIS */
+	{ 0x0061, 0x030A, 0x00E5 }, /* LATIN SMALL LETTER A + COMBINING RING ABOVE = LATIN SMALL LETTER A WITH RING ABOVE */
+	{ 0x0063, 0x0327, 0x00E7 }, /* LATIN SMALL LETTER C + COMBINING CEDILLA = LATIN SMALL LETTER C WITH CEDILLA */
+	{ 0x0065, 0x0300, 0x00E8 }, /* LATIN SMALL LETTER E + COMBINING GRAVE ACCENT = LATIN SMALL LETTER E WITH GRAVE */
+	{ 0x0065, 0x0301, 0x00E9 }, /* LATIN SMALL LETTER E + COMBINING ACUTE ACCENT = LATIN SMALL LETTER E WITH ACUTE */
+	{ 0x0065, 0x0302, 0x00EA }, /* LATIN SMALL LETTER E + COMBINING CIRCUMFLEX ACCENT = LATIN SMALL LETTER E WITH CIRCUMFLEX */
+	{ 0x0065, 0x0308, 0x00EB }, /* LATIN SMALL LETTER E + COMBINING DIAERESIS = LATIN SMALL LETTER E WITH DIAERESIS */
+	{ 0x0069, 0x0300, 0x00EC }, /* LATIN SMALL LETTER I + COMBINING GRAVE ACCENT = LATIN SMALL LETTER I WITH GRAVE */
+	{ 0x0069, 0x0301, 0x00ED }, /* LATIN SMALL LETTER I + COMBINING ACUTE ACCENT = LATIN SMALL LETTER I WITH ACUTE */
+	{ 0x0069, 0x0302, 0x00EE }, /* LATIN SMALL LETTER I + COMBINING CIRCUMFLEX ACCENT = LATIN SMALL LETTER I WITH CIRCUMFLEX */
+	{ 0x0069, 0x0308, 0x00EF }, /* LATIN SMALL LETTER I + COMBINING DIAERESIS = LATIN SMALL LETTER I WITH DIAERESIS */
+	{ 0x006E, 0x0303, 0x00F1 }, /* LATIN SMALL LETTER N + COMBINING TILDE = LATIN SMALL LETTER N WITH TILDE */
+	{ 0x006F, 0x0300, 0x00F2 }, /* LATIN SMALL LETTER O + COMBINING GRAVE ACCENT = LATIN SMALL LETTER O WITH GRAVE */
+	{ 0x006F, 0x0301, 0x00F3 }, /* LATIN SMALL LETTER O + COMBINING ACUTE ACCENT = LATIN SMALL LETTER O WITH ACUTE */
+	{ 0x006F, 0x0302, 0x00F4 }, /* LATIN SMALL LETTER O + COMBINING CIRCUMFLEX ACCENT = LATIN SMALL LETTER O WITH CIRCUMFLEX */
+	{ 0x006F, 0x0303, 0x00F5 }, /* LATIN SMALL LETTER O + COMBINING TILDE = LATIN SMALL LETTER O WITH TILDE */
+	{ 0x006F, 0x0308, 0x00F6 }, /* LATIN SMALL LETTER O + COMBINING DIAERESIS = LATIN SMALL LETTER O WITH DIAERESIS */
+	{ 0x0075, 0x0300, 0x00F9 }, /* LATIN SMALL LETTER U + COMBINING GRAVE ACCENT = LATIN SMALL LETTER U WITH GRAVE */
+	{ 0x0075, 0x0301, 0x00FA }, /* LATIN SMALL LETTER U + COMBINING ACUTE ACCENT = LATIN SMALL LETTER U WITH ACUTE */
+	{ 0x0075, 0x0302, 0x00FB }, /* LATIN SMALL LETTER U + COMBINING CIRCUMFLEX ACCENT = LATIN SMALL LETTER U WITH CIRCUMFLEX */
+	{ 0x0075, 0x0308, 0x00FC }, /* LATIN SMALL LETTER U + COMBINING DIAERESIS = LATIN SMALL LETTER U WITH DIAERESIS */
+	{ 0x0079, 0x0301, 0x00FD }, /* LATIN SMALL LETTER Y + COMBINING ACUTE ACCENT = LATIN SMALL LETTER Y WITH ACUTE */
+	{ 0x0079, 0x0308, 0x00FF }, /* LATIN SMALL LETTER Y + COMBINING DIAERESIS = LATIN SMALL LETTER Y WITH DIAERESIS */
+	{ 0x0391, 0x0301, 0x0386 }, /* GREEK CAPITAL LETTER ALPHA + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER ALPHA WITH TONOS */
+	{ 0x0395, 0x0301, 0x0388 }, /* GREEK CAPITAL LETTER EPSILON + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER EPSILON WITH TONOS */
+	{ 0x0397, 0x0301, 0x0389 }, /* GREEK CAPITAL LETTER ETA + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER ETA WITH TONOS */
+	{ 0x0399, 0x0301, 0x038A }, /* GREEK CAPITAL LETTER IOTA + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER IOTA WITH TONOS */
+	{ 0x039F, 0x0301, 0x038C }, /* GREEK CAPITAL LETTER OMICRON + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER OMICRON WITH TONOS */
+	{ 0x03A5, 0x0301, 0x038E }, /* GREEK CAPITAL LETTER UPSILON + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER UPSILON WITH TONOS */
+	{ 0x03A9, 0x0301, 0x038F }, /* GREEK CAPITAL LETTER OMEGA + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER OMEGA WITH TONOS */
+	{ 0x03B1, 0x0301, 0x03AC }, /* GREEK SMALL LETTER ALPHA + COMBINING ACUTE ACCENT = GREEK SMALL LETTER ALPHA WITH TONOS */
+	{ 0x03B5, 0x0301, 0x03AD }, /* GREEK SMALL LETTER EPSILON + COMBINING ACUTE ACCENT = GREEK SMALL LETTER EPSILON WITH TONOS */
+	{ 0x03B7, 0x0301, 0x03AE }, /* GREEK SMALL LETTER ETA + COMBINING ACUTE ACCENT = GREEK SMALL LETTER ETA WITH TONOS */
+	{ 0x03B9, 0x0301, 0x03AF }, /* GREEK SMALL LETTER IOTA + COMBINING ACUTE ACCENT = GREEK SMALL LETTER IOTA WITH TONOS */
+	{ 0x03BF, 0x0301, 0x03CC }, /* GREEK SMALL LETTER OMICRON + COMBINING ACUTE ACCENT = GREEK SMALL LETTER OMICRON WITH TONOS */
+	{ 0x03C5, 0x0301, 0x03CD }, /* GREEK SMALL LETTER UPSILON + COMBINING ACUTE ACCENT = GREEK SMALL LETTER UPSILON WITH TONOS */
+	{ 0x03C9, 0x0301, 0x03CE }, /* GREEK SMALL LETTER OMEGA + COMBINING ACUTE ACCENT = GREEK SMALL LETTER OMEGA WITH TONOS */
+	{ 0x0418, 0x0306, 0x0419 }, /* CYRILLIC CAPITAL LETTER I + COMBINING BREVE = CYRILLIC CAPITAL LETTER SHORT I */
+	{ 0x0423, 0x0306, 0x040E }, /* CYRILLIC CAPITAL LETTER U + COMBINING BREVE = CYRILLIC CAPITAL LETTER SHORT U */
+	{ 0x0438, 0x0306, 0x0439 }, /* CYRILLIC SMALL LETTER I + COMBINING BREVE = CYRILLIC SMALL LETTER SHORT I */
+	{ 0x0443, 0x0306, 0x045E }, /* CYRILLIC SMALL LETTER U + COMBINING BREVE = CYRILLIC SMALL LETTER SHORT U */
+};
+
+/*
+ * Boundary values for quick rejection
+ * These are calculated by analyzing the table during generation
+ */
+#define UCS_RECOMPOSE_MIN_BASE  0x0041
+#define UCS_RECOMPOSE_MAX_BASE  0x0443
+#define UCS_RECOMPOSE_MIN_MARK  0x0300
+#define UCS_RECOMPOSE_MAX_MARK  0x0327
-- 
2.49.0

