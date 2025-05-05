Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283D19CC22;
	Mon,  5 May 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464473; cv=none; b=gyxEaeTIGtGoZ7Vi9KePKBs0+RgrRyk48heQCNaaASIlnPR38t4gcgSSHYl6rjBBYZ0iqrf7WDhhEC5TEhWnlprwg3VPl0AivW8+u7vtAKVkc/ovlR09q8whb2JaaqOpH9nlANXoQvv9G/7vUWX8qnF3gNBfYxrEb03rD4IaDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464473; c=relaxed/simple;
	bh=lGzc1lF5g51qXYW6xvM3BpOjNHJumWCFwhwPiHuxGiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzthKKARlqAnkqP9ryto+pzfA2fRN8iPHmlFFUWbtNe3SGY2iz+84T/sO4nIB6aF3fMFZFUmU84UCp1pQaZWmkqSNL8/6QrsiiER5wkA3gWaddppDQEEpmjMdkE7sAu7e8xvX5rkq4f2OmXeQuXfQsAF/AHFPgKKQAf1C6214/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=DWBdC3eE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OPQpep4N; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="DWBdC3eE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OPQpep4N"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A0F80254029B;
	Mon,  5 May 2025 13:01:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 13:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1746464468; x=
	1746550868; bh=/zNLwsKS2hhHKOxH0Wzfk7zy/DySlTwgIQS+BKvVvd8=; b=D
	WBdC3eE++vX7YnBgxOQGxJ3l3pzdtBoSnUdOitpaAHSQAd/3ABsf2EnlpQOFGchk
	N0XsDDs8MXjtAMw7A2QrWsgDQQAJttT0G4jUSVfDEouZrcg292Ro9pyzwCA7Io5o
	aHvkKGMNpTzYq4fqCX8GjgxSUpfkkM6lsKAkm5Av2wiuWQ1RNvrfcbrONSfARnEB
	YepOrw0M9N6zT3XU0g5obi8j3QXhSH7Zjsnhi+i2zCJEHOXSkobE0eQvHDCLAxyZ
	kSIn4Ki/Fok1WUIBbFfxlZmp9+ZAdK+3FjjWN1oFsJ0uy/x4NM99Xbz4I/5+M5n4
	XA7hQexdKc7d4BV9ZToMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746464468; x=1746550868; bh=/
	zNLwsKS2hhHKOxH0Wzfk7zy/DySlTwgIQS+BKvVvd8=; b=OPQpep4NEUezueAf9
	BOYNI1NQLPKce3gOrvlIaNtAIExcc9zKnheiyf8m1L4uQ64xRHj3ZSdFbRfXU7jS
	B9zq1uEWbKE2TIrLjj+b5klVFPOpDY363CtRqWvm4X9NNltBKbsWjz89x06maFNs
	brNfPI3djGaXHBTdF5LVRAtDCtXZ07Q540FjILx6vxffk+GGV5yPyEVd4xvuAEkt
	CwqK7kFRbdUw5LOK/tNz9fco+B5Ek8L6snpw8B8FtRSMVp5Mv6DG2l5wj+AesyZT
	gShdR7iOYtN73b4pzlw+Ls0QAotGEQxvwf/OoFHSxabpJMtE1ebiy2BZSWGkaFMi
	uuz7g==
X-ME-Sender: <xms:1O4YaC7ThHUBr9vVkKEto5VFFr-a71o4ypfckRHqC0pA3rn0nmWBDQ>
    <xme:1O4YaL5apzl8-pCvKKWmGD24lbFQrK44V9CeIH-tG1U9LyQhnkwnOTlznZVlMK-vE
    0qWWkdRYB-_2owWpfg>
X-ME-Received: <xmr:1O4YaBevUEqTyj8ot8euNQKi9GcDYHsoqwwm_sfY_DcmA4kGCbNhwutCxMAv9wBcMDIwR-R9ajfNWsrg95O_wznK6DcPYAdR0Bbl7-1rIpl8qxrEQg>
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
X-ME-Proxy: <xmx:1O4YaPKiwME5hp0BibO7d5bkzm08Fb31PwTjCqbm5_pgbYcEFh51wA>
    <xmx:1O4YaGKRxuDYpYu2qGoc6jEaSaXciFnglHUlFpw-qTw2FCWQ7Tfl_g>
    <xmx:1O4YaAyPaJ44P2yFngOqd25tOiUcgCn1CHmcOy188vQWgA3OcyJ3bQ>
    <xmx:1O4YaKJBtxzxjmnaC8ulvyoZbTB1hjGIE91oiem1fWuzjut2p211Ew>
    <xmx:1O4YaFZoyOhGSYZ-Hi7mp-MhVhm8GAo-8rYL849jjmHk0rzLYsgjouke>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 13:01:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 9C296118545B;
	Mon, 05 May 2025 13:01:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] vt: move glyph determination to a separate function
Date: Mon,  5 May 2025 12:55:26 -0400
Message-ID: <20250505170021.29944-4-nico@fluxnic.net>
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

No logical changes. Make it easier for enhancements to come.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c | 73 +++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 58fa1b285f22..4e80384a419b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2925,6 +2925,7 @@ static void vc_con_rewind(struct vc_data *vc)
 
 #define UCS_ZWS		0x200b	/* Zero Width Space */
 #define UCS_VS16	0xfe0f	/* Variation Selector 16 */
+#define UCS_REPLACEMENT	0xfffd	/* Replacement Character */
 
 static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 {
@@ -2984,12 +2985,40 @@ static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 	return 0;
 }
 
+static int vc_get_glyph(struct vc_data *vc, int tc)
+{
+	int glyph = conv_uni_to_pc(vc, tc);
+	int charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+
+	if (!(glyph & ~charmask))
+		return glyph;
+
+	if (glyph == -1)
+		return -1; /* nothing to display */
+
+	/* Glyph not found */
+
+	if ((!vc->vc_utf || vc->vc_disp_ctrl || tc < 128) && !(tc & ~charmask)) {
+		/*
+		 * In legacy mode use the glyph we get by a 1:1 mapping.
+		 * This would make absolutely no sense with Unicode in mind,
+		 * but do this for ASCII characters since a font may lack
+		 * Unicode mapping info and we don't want to end up with
+		 * having question marks only.
+		 */
+		return tc;
+	}
+
+	/* Display U+FFFD (Unicode Replacement Character). */
+	return conv_uni_to_pc(vc, UCS_REPLACEMENT);
+}
+
 static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		struct vc_draw_region *draw)
 {
 	int next_c;
 	unsigned char vc_attr = vc->vc_attr;
-	u16 himask = vc->vc_hi_font_mask, charmask = himask ? 0x1ff : 0xff;
+	u16 himask = vc->vc_hi_font_mask;
 	u8 width = 1;
 	bool inverse = false;
 
@@ -3000,39 +3029,17 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 	}
 
 	/* Now try to find out how to display it */
-	tc = conv_uni_to_pc(vc, tc);
-	if (tc & ~charmask) {
-		if (tc == -1)
-			return -1; /* nothing to display */
+	tc = vc_get_glyph(vc, tc);
+	if (tc == -1)
+		return -1; /* nothing to display */
+	if (tc < 0) {
+		inverse = true;
+		tc = conv_uni_to_pc(vc, '?');
+		if (tc < 0)
+			tc = '?';
 
-		/* Glyph not found */
-		if ((!vc->vc_utf || vc->vc_disp_ctrl || c < 128) &&
-				!(c & ~charmask)) {
-			/*
-			 * In legacy mode use the glyph we get by a 1:1
-			 * mapping.
-			 * This would make absolutely no sense with Unicode in
-			 * mind, but do this for ASCII characters since a font
-			 * may lack Unicode mapping info and we don't want to
-			 * end up with having question marks only.
-			 */
-			tc = c;
-		} else {
-			/*
-			 * Display U+FFFD. If it's not found, display an inverse
-			 * question mark.
-			 */
-			tc = conv_uni_to_pc(vc, 0xfffd);
-			if (tc < 0) {
-				inverse = true;
-				tc = conv_uni_to_pc(vc, '?');
-				if (tc < 0)
-					tc = '?';
-
-				vc_attr = vc_invert_attr(vc);
-				con_flush(vc, draw);
-			}
-		}
+		vc_attr = vc_invert_attr(vc);
+		con_flush(vc, draw);
 	}
 
 	next_c = c;
-- 
2.49.0

