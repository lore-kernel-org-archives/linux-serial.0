Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8E189906;
	Thu, 10 Apr 2025 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247947; cv=none; b=ZE5CQ+q2SKvjGA1IiTi+ulJN7aPmStOqw0Dj+w6pa4yxAOs556Kd/9xiASdCSGFLaeZTJ/iMB6st3ErRklBf/ZdZ3114Rc34vA+BN5huhp5/LWXkZtuoRNaDZTCrvkcgDQ1r6XruVz1ivoOOkigxLBptuOaqHJJF+Faf7u8+LNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247947; c=relaxed/simple;
	bh=I74X3sNLnMcqf/fraokExTqQ2HZKrSMo4U9rtX1aImo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdMMmiY3jDLYQZ8R0lpQycntNq8nn3pD5fVGjcBdLhg5rr85nDx+mZfGSfVdZyM4NGkeeDnD5FB5DTjD8auz199Sx1zhNK4B5yTuWgVdEjIQj/I5epa766vNtZnfByBQK6wJj7Ohv7M9A0QLEiTpMaILxaKIJ0x28fnU2XISafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=GYTfy2k3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBV5dJKW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="GYTfy2k3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBV5dJKW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7049A13801EB;
	Wed,  9 Apr 2025 21:19:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 09 Apr 2025 21:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744247943; x=
	1744334343; bh=bvC8V9DFp+JhuTcgzAWmVeg0PQPFYt6N1mRS0QfFSWk=; b=G
	YTfy2k3r3UJO8ftEYdZ1ldp/jIGNLo+MdmgJnYZUEbGDG4UJi6V+fze44veVs98/
	lvFKKF6SPHzlTVPbOHL7xlIWiPjHt5QwNTb5bc+ryQ1Q9MvM7aLkTVHNVKh3JNim
	SBhk4dLpxKKaajSqEZBtTTQTDXtcJfBPh/JzWTSKPAY8wfg7Nm0vn8pthSein0qH
	SB6Z5c1pt6Szx9FenEN1qxVVk7tbV82BeZVM9bLavfsfsWFTwxYDIUMTjr2RmXZf
	qy1t1Asz4sg9S09luLLS9opQge8sFH0PCBr1u5/Rk8eWVcGCHErDtgUN/ERqLKTu
	qM5RzChAqiesktEKA56sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744247943; x=1744334343; bh=b
	vC8V9DFp+JhuTcgzAWmVeg0PQPFYt6N1mRS0QfFSWk=; b=jBV5dJKWzdPxFZ4XY
	44rg8cs5+nqdkjGp1U1udhya6AKPm5l1gGKs22RipQnk6NnnAnyixUbsHcDQPrsv
	IHhGN7ps5D5S7iRNShOKsN/QrHvqQxY/EXiqa5f5bkrdG17NuTooeIvkweOJodCb
	5lovt9N5KEsht/9LBBljo5YrZxXfwxYhK32ixeRP3qFijUm+qLDSd/aSywZg2MvZ
	Wv2ApcD3MmOZsRym1pJgARfKJqljnFhkeQFsjCwuIQrK2uZIwEb5VXnbBM0I5bCX
	0llfvIznYXVy/fdOtVPS0bxHboBGeSRPv5l9RtXJb5C4N0jWJ1lbw2dtuHFrtUWl
	EFaVA==
X-ME-Sender: <xms:hxz3ZxpkhtfzF2NzrD-gROfwidD3pU424Eg3dCVRvLa_qjOLlb2cLg>
    <xme:hxz3ZzoXFp4HJxOXVS43JtfFjug-TJureDpsJT1u20XMM4rcAVXQa2hSZ0ZGVAOvU
    hBd01DOlXXASs4em8I>
X-ME-Received: <xmr:hxz3Z-NXHtWwVzgnGEhdtK3nRLfOGgKkYMasL1SCP-Gpnt6hwPRzITFgrKD1xQtN6WUxiOYDvxdbORkuxzjI9KU2pa9Wfc6HCGKyDNVo_UWiNYNxBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeek
    udekfeffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhi
    hlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepuggrvhgvsehmihgvlhhkvgdrtggtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hxz3Z87JCCXhLsjunXTy0dQg50GM6vPgQQlJWx-kCrTzWUSSqdsv6g>
    <xmx:hxz3Zw7FOJSlKTca3jt5xGH1DStrdnVYtvmTU4xuMD1GDzBdbvjyrQ>
    <xmx:hxz3Z0gXBWsd8ye-hxfU8ZIEq84QuWgbIp5HT5vVeWRubOONFv1f_w>
    <xmx:hxz3Zy4rE32OAHRF2r58kbJExzfZDMxxgvtforvccaHAiZ7q4Pbazg>
    <xmx:hxz3Zz5aI3eFbvYmuXTCQOTj_-_Gd0CLdlCW9s-2XiTRA-l1gfvGb9PC>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 21:19:03 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6C1C410D8B77;
	Wed,  9 Apr 2025 21:19:02 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] vt: create ucs_recompose.c using gen_ucs_recompose.py
Date: Wed,  9 Apr 2025 21:13:59 -0400
Message-ID: <20250410011839.64418-8-nico@fluxnic.net>
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

This provides ucs_recompose() to recompose two Unicode characters into
a single character if possible. This is needed for the VT to properly
display decomposed UTF8 sequences.

Note: scripts/checkpatch.pl complains about "... exceeds 100 columns".
      Please ignore.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/Makefile        |   2 +-
 drivers/tty/vt/ucs_recompose.c | 170 +++++++++++++++++++++++++++++++++
 include/linux/consolemap.h     |   6 ++
 3 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tty/vt/ucs_recompose.c

diff --git a/drivers/tty/vt/Makefile b/drivers/tty/vt/Makefile
index bee69277bb..a63f6c9438 100644
--- a/drivers/tty/vt/Makefile
+++ b/drivers/tty/vt/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_VT)			+= vt_ioctl.o vc_screen.o \
 					   selection.o keyboard.o \
 					   vt.o defkeymap.o
 obj-$(CONFIG_CONSOLE_TRANSLATIONS)	+= consolemap.o consolemap_deftbl.o \
-					   ucs_width.o
+					   ucs_width.o ucs_recompose.o
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c
diff --git a/drivers/tty/vt/ucs_recompose.c b/drivers/tty/vt/ucs_recompose.c
new file mode 100644
index 0000000000..5c30c989de
--- /dev/null
+++ b/drivers/tty/vt/ucs_recompose.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ucs_recompose.c - Unicode character recomposition
+ *
+ * Auto-generated by gen_ucs_recompose.py
+ *
+ * Unicode Version: 16.0.0
+ *
+ * This file contains a table with most commonly used Latin, Greek, and
+ * Cyrillic recomposition pairs only (71 entries). To generate a table with
+ * all possible recomposition pairs from the Unicode BMP (1000 entries)
+ * instead, run:
+ *
+ *   python gen_ucs_recompose.py --full
+ */
+
+#include <linux/types.h>
+#include <linux/array_size.h>
+#include <linux/bsearch.h>
+#include <linux/consolemap.h>
+
+/*
+ * Structure for recomposition pairs.
+ * First element is the base character, second is the combining mark,
+ * third is the recomposed character.
+ * Using uint16_t to save space since all values are within BMP range.
+ */
+struct recomposition {
+	uint16_t base;
+	uint16_t combining;
+	uint16_t recomposed;
+};
+
+/*
+ * Table of most commonly used Latin, Greek, and Cyrillic recomposition pairs only
+ * Sorted by base character and then combining character for binary search
+ */
+static const struct recomposition recomposition_table[] = {
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
+#define MIN_BASE_CHAR       0x0041
+#define MAX_BASE_CHAR       0x0443
+#define MIN_COMBINING_CHAR  0x0300
+#define MAX_COMBINING_CHAR  0x0327
+
+struct compare_key {
+	uint16_t base;
+	uint16_t combining;
+};
+
+static int recomposition_compare(const void *key, const void *element)
+{
+	const struct compare_key *search_key = key;
+	const struct recomposition *table_entry = element;
+
+	/* Compare base character first */
+	if (search_key->base < table_entry->base)
+		return -1;
+	if (search_key->base > table_entry->base)
+		return 1;
+
+	/* Base characters match, now compare combining character */
+	if (search_key->combining < table_entry->combining)
+		return -1;
+	if (search_key->combining > table_entry->combining)
+		return 1;
+
+	/* Both match */
+	return 0;
+}
+
+/**
+ * Attempt to recompose two Unicode characters into a single character.
+ *
+ * @param previous: Previous Unicode code point (UCS-4)
+ * @param current: Current Unicode code point (UCS-4)
+ * Return: Recomposed Unicode code point, or 0 if no recomposition is possible
+ */
+uint32_t ucs_recompose(uint32_t base, uint32_t combining)
+{
+	/* Check if characters are within the range of our table */
+	if (base < MIN_BASE_CHAR || base > MAX_BASE_CHAR ||
+	    combining < MIN_COMBINING_CHAR || combining > MAX_COMBINING_CHAR)
+		return 0;
+
+	struct compare_key key = { base, combining };
+
+	struct recomposition *result =
+		__inline_bsearch(&key, recomposition_table,
+				 ARRAY_SIZE(recomposition_table),
+				 sizeof(*recomposition_table),
+				 recomposition_compare);
+
+	return result ? result->recomposed : 0;
+}
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index b3a9118666..4d3a34c288 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -30,6 +30,7 @@ int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
 bool ucs_is_double_width(uint32_t cp);
 bool ucs_is_zero_width(uint32_t cp);
+uint32_t ucs_recompose(uint32_t base, uint32_t combining);
 #else
 static inline u16 inverse_translate(const struct vc_data *conp, u16 glyph,
 		bool use_unicode)
@@ -69,6 +70,11 @@ static inline bool ucs_is_zero_width(uint32_t cp)
 {
 	return false;
 }
+
+static inline uint32_t ucs_recompose(uint32_t base, uint32_t combining)
+{
+	return 0;
+}
 #endif /* CONFIG_CONSOLE_TRANSLATIONS */
 
 #endif /* __LINUX_CONSOLEMAP_H__ */
-- 
2.49.0

