Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F826738B;
	Mon,  5 May 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464481; cv=none; b=Wz855W73GuVRIuiso+loDiz7Sy8VttpoiibxFI1dcKgWGQvVEPLukmcmqgeac8SjsmGP7ReZmPAJpGvIIkpDNknvzgOT2RG1zWneAYzMprewrvWjnixwo6/T6/zcAFfgeaxSAix+EhoiAb3yBlL1L85beumaAp72QGX+UBEJlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464481; c=relaxed/simple;
	bh=2j5Ofg5BLmtWpoLQrgQksoC/1ql11j2laUy1NR6Udg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoWhDUtg4bP719Cyi3j4FmkvoS+xK0BBHEqpUEwHjb8VM94zJDf+JaTX5y6wk+q1tde1HLCiXlsLuuAt+PFTAIDRm8BX5dx8u3whz7VYrVdoDxZEr6E44/qcHmA1Me2aw5OrFbkGNUdEIzbep6gLaoJJoX6LLuN2/S1BW4b5e4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=YTi884bu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wQx1gh+Z; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="YTi884bu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wQx1gh+Z"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B1C281140097;
	Mon,  5 May 2025 13:01:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 05 May 2025 13:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746464469;
	 x=1746550869; bh=tBKs41Mxkg0h0njmKXsU9oExiVamYbZey9ou+QZlT9M=; b=
	YTi884bu0DXrEwfBdw2T1RABpG7jegGxsMEJob1Gb3Wt6oGHYuiwg2R+gKIBZypR
	ZyaGiW9hFDNcdsatR0KYSP2TFV2ZJ5MRTUt7OOUq/CS5FcCbKi4hRtTNSEZ09+tM
	vbankmp1ileITUww9jFsvE1rLHFZ4Vaur2TdFwxuW9bVWkiNnmhwhO8i1ypaF9a8
	Q3dNhVqKAOsCKsZaskV9c4ZSy1jI0e1yQOWp7kYD5L4Ugxx6h3hLS5WVaxn+Y1tW
	8uORCRDuJ7tmbGRfiW77WO/kyN20lBWL2JsGkgL7NidNgRVbsJ2xi48Xt8YkdeDg
	3ia2w1PfhE6iZKUGioYBvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746464469; x=
	1746550869; bh=tBKs41Mxkg0h0njmKXsU9oExiVamYbZey9ou+QZlT9M=; b=w
	Qx1gh+ZBRDGeDJOaOuqyowmBRAdTBB/DxgTntHdNYQfeKyZ97KL7sNcxJ93wOEA/
	b/4g4lNLaaqRrRnl94O0g0r/GMUP8gOHov/nZghd5E2zB1KXg4umOdkm4n+3GMF9
	/1h3at4szuoRfu+4QqAlX/AOTLcRy3i2MWGMNCfIvcuqiQGGU9YA8zYxDx8vweG+
	nKYZHLHtjK+cZA7x7/0d4YISTRtsYmRJ93eSDAhBj5ZXOd41Pi6mYj0FaExaVXCu
	JMFWDOUppJ+7N/0hWTtgpY2/RLa3Gtd6L6c3yWpt/28A8amD7g1uzJSrxND3LO+S
	Ts2xmHnoYHahp5UNxnUuQ==
X-ME-Sender: <xms:1e4YaE6bol-96_UQer7XsqBuvcVJwDo6MCCPncFnE5jDEfJEGgWeTQ>
    <xme:1e4YaF5QoudjAfdfLPXe4jZ1wIyj496sngIRwM6DI3_OGYQpdQ1ujbfwpcfVOgTEf
    tPazOVarpY23Pukoqk>
X-ME-Received: <xmr:1e4YaDcEWQYUE81Du156Q8pX-C8dchjkClzdNfabEvpxNrjonY1FI5LJQ6rGOBAeDpSn8UtgTiJD9tltFPS9BxYUjcs0jbGAwn6331qCNn9D6KqLZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnih
    gtrdhnvghtqeenucggtffrrghtthgvrhhnpedufedvleehffethffhffelkeekieekgeev
    ffelleejteehieeghfeluedvvdehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhpihhtrhgvsegsrg
    ihlhhisghrvgdrtghomhdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:1e4YaJKhR4cKsdVpXX9mq3e2Pl5HmeLmUPV3v-bSaKfqlhUBiOjkpA>
    <xmx:1e4YaIK7hL9Ok1jv5Dv6LfsYvqGfDf9y5wDlvkzzalfgAnFTvKUoGw>
    <xmx:1e4YaKw-ueSndkAe1quBPG9o0K73JaXMG0CcG7JKE3LmV1_S1X9AKA>
    <xmx:1e4YaMLIWzJRWbV5OHVH1SaJVBNQJUB1Jw0WARPc38yJ_TZbg-nIJw>
    <xmx:1e4YaPYH4rW8m8Tt-n1rnO79uFOM1s1xwmO7wJq_VMex9L7rSCH_zhG3>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 13:01:09 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 5DE8F1185463;
	Mon, 05 May 2025 13:01:08 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] vt: process the full-width ASCII fallback range programmatically
Date: Mon,  5 May 2025 12:55:31 -0400
Message-ID: <20250505170021.29944-9-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505170021.29944-1-nico@fluxnic.net>
References: <20250505170021.29944-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

This saves about 258 bytes of text.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/gen_ucs_fallback_table.py    |  11 +-
 drivers/tty/vt/ucs.c                        |   8 +
 drivers/tty/vt/ucs_fallback_table.h_shipped | 188 --------------------
 3 files changed, 13 insertions(+), 194 deletions(-)

diff --git a/drivers/tty/vt/gen_ucs_fallback_table.py b/drivers/tty/vt/gen_ucs_fallback_table.py
index cb4e75b454fe..3a725d47366d 100755
--- a/drivers/tty/vt/gen_ucs_fallback_table.py
+++ b/drivers/tty/vt/gen_ucs_fallback_table.py
@@ -666,12 +666,11 @@ def collect_drawing_character_mappings():
     fallback_map[0x2746] = ord('*')  # ❆ HEAVY CHEVRON SNOWFLAKE
     fallback_map[0x2698] = ord('*')  # ⚘ FLOWER
 
-    # Add special ASCII characters with full-width equivalents
-    # Map between full-width and ASCII forms
-    for i, cp in enumerate(range(0xFF01, 0xFF5E+1)):
-        # Full-width to ASCII mapping (covering all printable ASCII 33-126)
-        # 0xFF01 (！) to 0xFF5E (～) -> ASCII 33 (!) to 126 (~)
-        fallback_map[cp] = 33 + i
+    # Full-width to ASCII mapping (covering all printable ASCII 33-126)
+    # 0xFF01 (！) to 0xFF5E (～) -> ASCII 33 (!) to 126 (~)
+    # Those are not included here to reduce the table size.
+    # It is more efficient to process them programmatically in
+    # ucs.c:ucs_get_fallback().
 
     return fallback_map
 
diff --git a/drivers/tty/vt/ucs.c b/drivers/tty/vt/ucs.c
index dcce733b80cb..ae3254302760 100644
--- a/drivers/tty/vt/ucs.c
+++ b/drivers/tty/vt/ucs.c
@@ -222,5 +222,13 @@ u32 ucs_get_fallback(u32 cp)
 	if (single)
 		return ucs_fallback_singles_subs[single - ucs_fallback_singles];
 
+	/*
+	 * Full-width to ASCII mapping (covering all printable ASCII 33-126)
+	 * 0xFF01 (！) to 0xFF5E (～) -> ASCII 33 (!) to 126 (~)
+	 * We process them programmatically to reduce the table size.
+	 */
+	if (cp >= 0xFF01 && cp <= 0xFF5E)
+		return cp - 0xFF01 + 33;
+
 	return 0;
 }
diff --git a/drivers/tty/vt/ucs_fallback_table.h_shipped b/drivers/tty/vt/ucs_fallback_table.h_shipped
index d528d500ec9d..fe61418497ee 100644
--- a/drivers/tty/vt/ucs_fallback_table.h_shipped
+++ b/drivers/tty/vt/ucs_fallback_table.h_shipped
@@ -817,100 +817,6 @@ static const u16 ucs_fallback_singles[] = {
 	0x2718, /* HEAVY BALLOT X -> LATIN CAPITAL LETTER X */
 	0x27F8, /* LONG LEFTWARDS DOUBLE ARROW -> LESS-THAN SIGN */
 	0x27F9, /* LONG RIGHTWARDS DOUBLE ARROW -> GREATER-THAN SIGN */
-	0xFF01, /* FULLWIDTH EXCLAMATION MARK -> EXCLAMATION MARK */
-	0xFF02, /* FULLWIDTH QUOTATION MARK -> QUOTATION MARK */
-	0xFF03, /* FULLWIDTH NUMBER SIGN -> NUMBER SIGN */
-	0xFF04, /* FULLWIDTH DOLLAR SIGN -> DOLLAR SIGN */
-	0xFF05, /* FULLWIDTH PERCENT SIGN -> PERCENT SIGN */
-	0xFF06, /* FULLWIDTH AMPERSAND -> AMPERSAND */
-	0xFF07, /* FULLWIDTH APOSTROPHE -> APOSTROPHE */
-	0xFF08, /* FULLWIDTH LEFT PARENTHESIS -> LEFT PARENTHESIS */
-	0xFF09, /* FULLWIDTH RIGHT PARENTHESIS -> RIGHT PARENTHESIS */
-	0xFF0A, /* FULLWIDTH ASTERISK -> ASTERISK */
-	0xFF0B, /* FULLWIDTH PLUS SIGN -> PLUS SIGN */
-	0xFF0C, /* FULLWIDTH COMMA -> COMMA */
-	0xFF0D, /* FULLWIDTH HYPHEN-MINUS -> HYPHEN-MINUS */
-	0xFF0E, /* FULLWIDTH FULL STOP -> FULL STOP */
-	0xFF0F, /* FULLWIDTH SOLIDUS -> SOLIDUS */
-	0xFF10, /* FULLWIDTH DIGIT ZERO -> DIGIT ZERO */
-	0xFF11, /* FULLWIDTH DIGIT ONE -> DIGIT ONE */
-	0xFF12, /* FULLWIDTH DIGIT TWO -> DIGIT TWO */
-	0xFF13, /* FULLWIDTH DIGIT THREE -> DIGIT THREE */
-	0xFF14, /* FULLWIDTH DIGIT FOUR -> DIGIT FOUR */
-	0xFF15, /* FULLWIDTH DIGIT FIVE -> DIGIT FIVE */
-	0xFF16, /* FULLWIDTH DIGIT SIX -> DIGIT SIX */
-	0xFF17, /* FULLWIDTH DIGIT SEVEN -> DIGIT SEVEN */
-	0xFF18, /* FULLWIDTH DIGIT EIGHT -> DIGIT EIGHT */
-	0xFF19, /* FULLWIDTH DIGIT NINE -> DIGIT NINE */
-	0xFF1A, /* FULLWIDTH COLON -> COLON */
-	0xFF1B, /* FULLWIDTH SEMICOLON -> SEMICOLON */
-	0xFF1C, /* FULLWIDTH LESS-THAN SIGN -> LESS-THAN SIGN */
-	0xFF1D, /* FULLWIDTH EQUALS SIGN -> EQUALS SIGN */
-	0xFF1E, /* FULLWIDTH GREATER-THAN SIGN -> GREATER-THAN SIGN */
-	0xFF1F, /* FULLWIDTH QUESTION MARK -> QUESTION MARK */
-	0xFF20, /* FULLWIDTH COMMERCIAL AT -> COMMERCIAL AT */
-	0xFF21, /* FULLWIDTH LATIN CAPITAL LETTER A -> LATIN CAPITAL LETTER A */
-	0xFF22, /* FULLWIDTH LATIN CAPITAL LETTER B -> LATIN CAPITAL LETTER B */
-	0xFF23, /* FULLWIDTH LATIN CAPITAL LETTER C -> LATIN CAPITAL LETTER C */
-	0xFF24, /* FULLWIDTH LATIN CAPITAL LETTER D -> LATIN CAPITAL LETTER D */
-	0xFF25, /* FULLWIDTH LATIN CAPITAL LETTER E -> LATIN CAPITAL LETTER E */
-	0xFF26, /* FULLWIDTH LATIN CAPITAL LETTER F -> LATIN CAPITAL LETTER F */
-	0xFF27, /* FULLWIDTH LATIN CAPITAL LETTER G -> LATIN CAPITAL LETTER G */
-	0xFF28, /* FULLWIDTH LATIN CAPITAL LETTER H -> LATIN CAPITAL LETTER H */
-	0xFF29, /* FULLWIDTH LATIN CAPITAL LETTER I -> LATIN CAPITAL LETTER I */
-	0xFF2A, /* FULLWIDTH LATIN CAPITAL LETTER J -> LATIN CAPITAL LETTER J */
-	0xFF2B, /* FULLWIDTH LATIN CAPITAL LETTER K -> LATIN CAPITAL LETTER K */
-	0xFF2C, /* FULLWIDTH LATIN CAPITAL LETTER L -> LATIN CAPITAL LETTER L */
-	0xFF2D, /* FULLWIDTH LATIN CAPITAL LETTER M -> LATIN CAPITAL LETTER M */
-	0xFF2E, /* FULLWIDTH LATIN CAPITAL LETTER N -> LATIN CAPITAL LETTER N */
-	0xFF2F, /* FULLWIDTH LATIN CAPITAL LETTER O -> LATIN CAPITAL LETTER O */
-	0xFF30, /* FULLWIDTH LATIN CAPITAL LETTER P -> LATIN CAPITAL LETTER P */
-	0xFF31, /* FULLWIDTH LATIN CAPITAL LETTER Q -> LATIN CAPITAL LETTER Q */
-	0xFF32, /* FULLWIDTH LATIN CAPITAL LETTER R -> LATIN CAPITAL LETTER R */
-	0xFF33, /* FULLWIDTH LATIN CAPITAL LETTER S -> LATIN CAPITAL LETTER S */
-	0xFF34, /* FULLWIDTH LATIN CAPITAL LETTER T -> LATIN CAPITAL LETTER T */
-	0xFF35, /* FULLWIDTH LATIN CAPITAL LETTER U -> LATIN CAPITAL LETTER U */
-	0xFF36, /* FULLWIDTH LATIN CAPITAL LETTER V -> LATIN CAPITAL LETTER V */
-	0xFF37, /* FULLWIDTH LATIN CAPITAL LETTER W -> LATIN CAPITAL LETTER W */
-	0xFF38, /* FULLWIDTH LATIN CAPITAL LETTER X -> LATIN CAPITAL LETTER X */
-	0xFF39, /* FULLWIDTH LATIN CAPITAL LETTER Y -> LATIN CAPITAL LETTER Y */
-	0xFF3A, /* FULLWIDTH LATIN CAPITAL LETTER Z -> LATIN CAPITAL LETTER Z */
-	0xFF3B, /* FULLWIDTH LEFT SQUARE BRACKET -> LEFT SQUARE BRACKET */
-	0xFF3C, /* FULLWIDTH REVERSE SOLIDUS -> REVERSE SOLIDUS */
-	0xFF3D, /* FULLWIDTH RIGHT SQUARE BRACKET -> RIGHT SQUARE BRACKET */
-	0xFF3E, /* FULLWIDTH CIRCUMFLEX ACCENT -> CIRCUMFLEX ACCENT */
-	0xFF3F, /* FULLWIDTH LOW LINE -> LOW LINE */
-	0xFF40, /* FULLWIDTH GRAVE ACCENT -> GRAVE ACCENT */
-	0xFF41, /* FULLWIDTH LATIN SMALL LETTER A -> LATIN SMALL LETTER A */
-	0xFF42, /* FULLWIDTH LATIN SMALL LETTER B -> LATIN SMALL LETTER B */
-	0xFF43, /* FULLWIDTH LATIN SMALL LETTER C -> LATIN SMALL LETTER C */
-	0xFF44, /* FULLWIDTH LATIN SMALL LETTER D -> LATIN SMALL LETTER D */
-	0xFF45, /* FULLWIDTH LATIN SMALL LETTER E -> LATIN SMALL LETTER E */
-	0xFF46, /* FULLWIDTH LATIN SMALL LETTER F -> LATIN SMALL LETTER F */
-	0xFF47, /* FULLWIDTH LATIN SMALL LETTER G -> LATIN SMALL LETTER G */
-	0xFF48, /* FULLWIDTH LATIN SMALL LETTER H -> LATIN SMALL LETTER H */
-	0xFF49, /* FULLWIDTH LATIN SMALL LETTER I -> LATIN SMALL LETTER I */
-	0xFF4A, /* FULLWIDTH LATIN SMALL LETTER J -> LATIN SMALL LETTER J */
-	0xFF4B, /* FULLWIDTH LATIN SMALL LETTER K -> LATIN SMALL LETTER K */
-	0xFF4C, /* FULLWIDTH LATIN SMALL LETTER L -> LATIN SMALL LETTER L */
-	0xFF4D, /* FULLWIDTH LATIN SMALL LETTER M -> LATIN SMALL LETTER M */
-	0xFF4E, /* FULLWIDTH LATIN SMALL LETTER N -> LATIN SMALL LETTER N */
-	0xFF4F, /* FULLWIDTH LATIN SMALL LETTER O -> LATIN SMALL LETTER O */
-	0xFF50, /* FULLWIDTH LATIN SMALL LETTER P -> LATIN SMALL LETTER P */
-	0xFF51, /* FULLWIDTH LATIN SMALL LETTER Q -> LATIN SMALL LETTER Q */
-	0xFF52, /* FULLWIDTH LATIN SMALL LETTER R -> LATIN SMALL LETTER R */
-	0xFF53, /* FULLWIDTH LATIN SMALL LETTER S -> LATIN SMALL LETTER S */
-	0xFF54, /* FULLWIDTH LATIN SMALL LETTER T -> LATIN SMALL LETTER T */
-	0xFF55, /* FULLWIDTH LATIN SMALL LETTER U -> LATIN SMALL LETTER U */
-	0xFF56, /* FULLWIDTH LATIN SMALL LETTER V -> LATIN SMALL LETTER V */
-	0xFF57, /* FULLWIDTH LATIN SMALL LETTER W -> LATIN SMALL LETTER W */
-	0xFF58, /* FULLWIDTH LATIN SMALL LETTER X -> LATIN SMALL LETTER X */
-	0xFF59, /* FULLWIDTH LATIN SMALL LETTER Y -> LATIN SMALL LETTER Y */
-	0xFF5A, /* FULLWIDTH LATIN SMALL LETTER Z -> LATIN SMALL LETTER Z */
-	0xFF5B, /* FULLWIDTH LEFT CURLY BRACKET -> LEFT CURLY BRACKET */
-	0xFF5C, /* FULLWIDTH VERTICAL LINE -> VERTICAL LINE */
-	0xFF5D, /* FULLWIDTH RIGHT CURLY BRACKET -> RIGHT CURLY BRACKET */
-	0xFF5E, /* FULLWIDTH TILDE -> TILDE */
 };
 
 static const u8 ucs_fallback_singles_subs[] = {
@@ -1589,98 +1495,4 @@ static const u8 ucs_fallback_singles_subs[] = {
 	0x58, /* HEAVY BALLOT X -> LATIN CAPITAL LETTER X */
 	0x3C, /* LONG LEFTWARDS DOUBLE ARROW -> LESS-THAN SIGN */
 	0x3E, /* LONG RIGHTWARDS DOUBLE ARROW -> GREATER-THAN SIGN */
-	0x21, /* FULLWIDTH EXCLAMATION MARK -> EXCLAMATION MARK */
-	0x22, /* FULLWIDTH QUOTATION MARK -> QUOTATION MARK */
-	0x23, /* FULLWIDTH NUMBER SIGN -> NUMBER SIGN */
-	0x24, /* FULLWIDTH DOLLAR SIGN -> DOLLAR SIGN */
-	0x25, /* FULLWIDTH PERCENT SIGN -> PERCENT SIGN */
-	0x26, /* FULLWIDTH AMPERSAND -> AMPERSAND */
-	0x27, /* FULLWIDTH APOSTROPHE -> APOSTROPHE */
-	0x28, /* FULLWIDTH LEFT PARENTHESIS -> LEFT PARENTHESIS */
-	0x29, /* FULLWIDTH RIGHT PARENTHESIS -> RIGHT PARENTHESIS */
-	0x2A, /* FULLWIDTH ASTERISK -> ASTERISK */
-	0x2B, /* FULLWIDTH PLUS SIGN -> PLUS SIGN */
-	0x2C, /* FULLWIDTH COMMA -> COMMA */
-	0x2D, /* FULLWIDTH HYPHEN-MINUS -> HYPHEN-MINUS */
-	0x2E, /* FULLWIDTH FULL STOP -> FULL STOP */
-	0x2F, /* FULLWIDTH SOLIDUS -> SOLIDUS */
-	0x30, /* FULLWIDTH DIGIT ZERO -> DIGIT ZERO */
-	0x31, /* FULLWIDTH DIGIT ONE -> DIGIT ONE */
-	0x32, /* FULLWIDTH DIGIT TWO -> DIGIT TWO */
-	0x33, /* FULLWIDTH DIGIT THREE -> DIGIT THREE */
-	0x34, /* FULLWIDTH DIGIT FOUR -> DIGIT FOUR */
-	0x35, /* FULLWIDTH DIGIT FIVE -> DIGIT FIVE */
-	0x36, /* FULLWIDTH DIGIT SIX -> DIGIT SIX */
-	0x37, /* FULLWIDTH DIGIT SEVEN -> DIGIT SEVEN */
-	0x38, /* FULLWIDTH DIGIT EIGHT -> DIGIT EIGHT */
-	0x39, /* FULLWIDTH DIGIT NINE -> DIGIT NINE */
-	0x3A, /* FULLWIDTH COLON -> COLON */
-	0x3B, /* FULLWIDTH SEMICOLON -> SEMICOLON */
-	0x3C, /* FULLWIDTH LESS-THAN SIGN -> LESS-THAN SIGN */
-	0x3D, /* FULLWIDTH EQUALS SIGN -> EQUALS SIGN */
-	0x3E, /* FULLWIDTH GREATER-THAN SIGN -> GREATER-THAN SIGN */
-	0x3F, /* FULLWIDTH QUESTION MARK -> QUESTION MARK */
-	0x40, /* FULLWIDTH COMMERCIAL AT -> COMMERCIAL AT */
-	0x41, /* FULLWIDTH LATIN CAPITAL LETTER A -> LATIN CAPITAL LETTER A */
-	0x42, /* FULLWIDTH LATIN CAPITAL LETTER B -> LATIN CAPITAL LETTER B */
-	0x43, /* FULLWIDTH LATIN CAPITAL LETTER C -> LATIN CAPITAL LETTER C */
-	0x44, /* FULLWIDTH LATIN CAPITAL LETTER D -> LATIN CAPITAL LETTER D */
-	0x45, /* FULLWIDTH LATIN CAPITAL LETTER E -> LATIN CAPITAL LETTER E */
-	0x46, /* FULLWIDTH LATIN CAPITAL LETTER F -> LATIN CAPITAL LETTER F */
-	0x47, /* FULLWIDTH LATIN CAPITAL LETTER G -> LATIN CAPITAL LETTER G */
-	0x48, /* FULLWIDTH LATIN CAPITAL LETTER H -> LATIN CAPITAL LETTER H */
-	0x49, /* FULLWIDTH LATIN CAPITAL LETTER I -> LATIN CAPITAL LETTER I */
-	0x4A, /* FULLWIDTH LATIN CAPITAL LETTER J -> LATIN CAPITAL LETTER J */
-	0x4B, /* FULLWIDTH LATIN CAPITAL LETTER K -> LATIN CAPITAL LETTER K */
-	0x4C, /* FULLWIDTH LATIN CAPITAL LETTER L -> LATIN CAPITAL LETTER L */
-	0x4D, /* FULLWIDTH LATIN CAPITAL LETTER M -> LATIN CAPITAL LETTER M */
-	0x4E, /* FULLWIDTH LATIN CAPITAL LETTER N -> LATIN CAPITAL LETTER N */
-	0x4F, /* FULLWIDTH LATIN CAPITAL LETTER O -> LATIN CAPITAL LETTER O */
-	0x50, /* FULLWIDTH LATIN CAPITAL LETTER P -> LATIN CAPITAL LETTER P */
-	0x51, /* FULLWIDTH LATIN CAPITAL LETTER Q -> LATIN CAPITAL LETTER Q */
-	0x52, /* FULLWIDTH LATIN CAPITAL LETTER R -> LATIN CAPITAL LETTER R */
-	0x53, /* FULLWIDTH LATIN CAPITAL LETTER S -> LATIN CAPITAL LETTER S */
-	0x54, /* FULLWIDTH LATIN CAPITAL LETTER T -> LATIN CAPITAL LETTER T */
-	0x55, /* FULLWIDTH LATIN CAPITAL LETTER U -> LATIN CAPITAL LETTER U */
-	0x56, /* FULLWIDTH LATIN CAPITAL LETTER V -> LATIN CAPITAL LETTER V */
-	0x57, /* FULLWIDTH LATIN CAPITAL LETTER W -> LATIN CAPITAL LETTER W */
-	0x58, /* FULLWIDTH LATIN CAPITAL LETTER X -> LATIN CAPITAL LETTER X */
-	0x59, /* FULLWIDTH LATIN CAPITAL LETTER Y -> LATIN CAPITAL LETTER Y */
-	0x5A, /* FULLWIDTH LATIN CAPITAL LETTER Z -> LATIN CAPITAL LETTER Z */
-	0x5B, /* FULLWIDTH LEFT SQUARE BRACKET -> LEFT SQUARE BRACKET */
-	0x5C, /* FULLWIDTH REVERSE SOLIDUS -> REVERSE SOLIDUS */
-	0x5D, /* FULLWIDTH RIGHT SQUARE BRACKET -> RIGHT SQUARE BRACKET */
-	0x5E, /* FULLWIDTH CIRCUMFLEX ACCENT -> CIRCUMFLEX ACCENT */
-	0x5F, /* FULLWIDTH LOW LINE -> LOW LINE */
-	0x60, /* FULLWIDTH GRAVE ACCENT -> GRAVE ACCENT */
-	0x61, /* FULLWIDTH LATIN SMALL LETTER A -> LATIN SMALL LETTER A */
-	0x62, /* FULLWIDTH LATIN SMALL LETTER B -> LATIN SMALL LETTER B */
-	0x63, /* FULLWIDTH LATIN SMALL LETTER C -> LATIN SMALL LETTER C */
-	0x64, /* FULLWIDTH LATIN SMALL LETTER D -> LATIN SMALL LETTER D */
-	0x65, /* FULLWIDTH LATIN SMALL LETTER E -> LATIN SMALL LETTER E */
-	0x66, /* FULLWIDTH LATIN SMALL LETTER F -> LATIN SMALL LETTER F */
-	0x67, /* FULLWIDTH LATIN SMALL LETTER G -> LATIN SMALL LETTER G */
-	0x68, /* FULLWIDTH LATIN SMALL LETTER H -> LATIN SMALL LETTER H */
-	0x69, /* FULLWIDTH LATIN SMALL LETTER I -> LATIN SMALL LETTER I */
-	0x6A, /* FULLWIDTH LATIN SMALL LETTER J -> LATIN SMALL LETTER J */
-	0x6B, /* FULLWIDTH LATIN SMALL LETTER K -> LATIN SMALL LETTER K */
-	0x6C, /* FULLWIDTH LATIN SMALL LETTER L -> LATIN SMALL LETTER L */
-	0x6D, /* FULLWIDTH LATIN SMALL LETTER M -> LATIN SMALL LETTER M */
-	0x6E, /* FULLWIDTH LATIN SMALL LETTER N -> LATIN SMALL LETTER N */
-	0x6F, /* FULLWIDTH LATIN SMALL LETTER O -> LATIN SMALL LETTER O */
-	0x70, /* FULLWIDTH LATIN SMALL LETTER P -> LATIN SMALL LETTER P */
-	0x71, /* FULLWIDTH LATIN SMALL LETTER Q -> LATIN SMALL LETTER Q */
-	0x72, /* FULLWIDTH LATIN SMALL LETTER R -> LATIN SMALL LETTER R */
-	0x73, /* FULLWIDTH LATIN SMALL LETTER S -> LATIN SMALL LETTER S */
-	0x74, /* FULLWIDTH LATIN SMALL LETTER T -> LATIN SMALL LETTER T */
-	0x75, /* FULLWIDTH LATIN SMALL LETTER U -> LATIN SMALL LETTER U */
-	0x76, /* FULLWIDTH LATIN SMALL LETTER V -> LATIN SMALL LETTER V */
-	0x77, /* FULLWIDTH LATIN SMALL LETTER W -> LATIN SMALL LETTER W */
-	0x78, /* FULLWIDTH LATIN SMALL LETTER X -> LATIN SMALL LETTER X */
-	0x79, /* FULLWIDTH LATIN SMALL LETTER Y -> LATIN SMALL LETTER Y */
-	0x7A, /* FULLWIDTH LATIN SMALL LETTER Z -> LATIN SMALL LETTER Z */
-	0x7B, /* FULLWIDTH LEFT CURLY BRACKET -> LEFT CURLY BRACKET */
-	0x7C, /* FULLWIDTH VERTICAL LINE -> VERTICAL LINE */
-	0x7D, /* FULLWIDTH RIGHT CURLY BRACKET -> RIGHT CURLY BRACKET */
-	0x7E, /* FULLWIDTH TILDE -> TILDE */
 };
-- 
2.49.0

