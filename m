Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE028C5CB;
	Wed,  7 May 2025 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627348; cv=none; b=OynGhBVM45hXMdoGxnOYjm/Qn0iqkFgCg29bUO4pBYN+nPzlePOoUYW8pnpiLGy6n1qoKLAlOp5dQ2r9EFS7R+guPKP1wlm3g2Sb7ODbHLH2JBhrxZRZWDDRlK7kG2x9lZsl0zmvNiWE72GHLoYVvW8D7drPUlXXr+oI7N9gE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627348; c=relaxed/simple;
	bh=CFMSo8fFi8h4sxS0Jy++gqAt1TaJvChkaWTHteXNxu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlnnVnhOIDnnwOZ6ueqNsRUxoW2C9+333sbKJBO2AG8NhXnSjLHqgc1rUjYcYjcgOCdXJSE/T3HD6a3zylPiDE9v7GBUpnwyL8ipJH2CZemsFwVP56WBbiL1VOqjwkdxFzIr5uHVNznOKRz6PAGJHaRTwKPDG1Nqq82K+cDtdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=b4MhVvlU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z3C8uOaf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="b4MhVvlU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z3C8uOaf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BDA04114014E;
	Wed,  7 May 2025 10:15:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 07 May 2025 10:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746627343;
	 x=1746713743; bh=lobH8vUSiJ5yxjFwSsceR9+MPZ6tQ3OZZfMY+aWJhpg=; b=
	b4MhVvlUBkMIegsy0H60VjOpS2LduPWUWZ82ayQnnRSz4Fx9tRxRyl5IV7c+Wo+X
	KHL+cncAsxOboufqfAkBLUFE4ewQh6tgUbbcfTULOtzAhDmDR/ooXf64QAj+OlFP
	N/g7jofRxXBfM5lcuv1ndZUJU0jD/q16MEYUkaHXjuSPckn7gPiKD3H1D602JxY9
	8xpOAznvDWlqzb+OM4fDSqYBqzeth+q8nhOO87brX3BPumJsGasj5KS70H6H82jA
	h15cOwRn8UMBTsgavw47s7k+ilM+++a+1mYFinC889YLDzxLSdc38oFFVY4NTjen
	mXC8xYug/v/YR/nP1+k1ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746627343; x=
	1746713743; bh=lobH8vUSiJ5yxjFwSsceR9+MPZ6tQ3OZZfMY+aWJhpg=; b=Z
	3C8uOaf61vknaIaVm/ctkjTBbQNWEouECdTVZRvIcSePQKussQrXfu8lXPF0t/Tw
	koKwlup928RP9+3PTIILto5PmmqMIlwCr27oUHXJ2yUIiOtZw9dZBG0X6MAVBvvZ
	3nrdOetuQjFyvdQMYVoyV1eHPWbwcLUAPd8SOGvUjpLF9q4J5HFkVSxOUk/fjPkK
	oskWxSHEBeslgB5TRyis2VULCVr8xXHQdD1zpielSphFmEHcoXHzn5JbTyWf7ftt
	FKn91rhanP47O4HPMBD2VRx3krXcZVBe2kZgR2LY1H2kOFAo54BlsmHPHSZe7os2
	Sj2HX/TOSVsAa/+I+IczA==
X-ME-Sender: <xms:D2sbaEp3wkEp6K6gxGVRtnC4BhQc8ez2vyKfz3X0nXuueJ6WOJpy-A>
    <xme:D2sbaKpiJyOsvytQ7DLSWlr-u1EWaAifanztKx10Wc24rNNk_1pEarB4kgYQsHiOA
    0UZyPTK2vn7HVjOqRU>
X-ME-Received: <xmr:D2sbaJMWgrKYrdUPS-UPJRqXW4iqRVjEyDF1uNqkgrdxxI7wm3WadI_owsyC1vMtpU5q914J2WVIZpwurJFTzFTKuQiYpwITfGznW5nE0f3c6Ys0fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejtdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:D2sbaL4aE3BrMXJ3RJAsE6c3AA4B6NHxmRUK8TJRVaLqVvj2GFjBMg>
    <xmx:D2sbaD7blIkFza5gtW3OzEPnltAjkHr58rJGaZggnErKLJ4e4JgK1g>
    <xmx:D2sbaLipabORwDTilPciiTB5w6rm03HDmxwyQrrSm-eSOEQqhJbZXw>
    <xmx:D2sbaN4ktsrmgpMNcQQLE35puyoMgzn7CZSDPh3kRqUQg3audTHaTg>
    <xmx:D2sbaALVdnWWH8IJSx7wsG2JtaOdhj6ViPFGlSx9tl3nB_PUtKmEYBAN>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 10:15:43 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id B41061189EAC;
	Wed, 07 May 2025 10:15:42 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] vt: process the full-width ASCII fallback range programmatically
Date: Wed,  7 May 2025 10:13:23 -0400
Message-ID: <20250507141535.40655-9-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507141535.40655-1-nico@fluxnic.net>
References: <20250507141535.40655-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

This shaves about 170 bytes from ucs.o.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/gen_ucs_fallback_table.py    |  8 ++
 drivers/tty/vt/ucs.c                        |  8 ++
 drivers/tty/vt/ucs_fallback_table.h_shipped | 96 +--------------------
 3 files changed, 17 insertions(+), 95 deletions(-)

diff --git a/drivers/tty/vt/gen_ucs_fallback_table.py b/drivers/tty/vt/gen_ucs_fallback_table.py
index 80257c6df440..6e09c1cb6d4b 100755
--- a/drivers/tty/vt/gen_ucs_fallback_table.py
+++ b/drivers/tty/vt/gen_ucs_fallback_table.py
@@ -197,6 +197,14 @@ def get_special_overrides():
     # Exclude U+2028 (LINE SEPARATOR)
     overrides[0x2028] = 0  # LINE SEPARATOR (unidecode: '\n')
 
+    # Full-width to ASCII mapping (covering all printable ASCII 33-126)
+    # 0xFF01 (！) to 0xFF5E (～) -> ASCII 33 (!) to 126 (~)
+    # Those are excluded here to reduce the table size.
+    # It is more efficient to process them programmatically in
+    # ucs.c:ucs_get_fallback().
+    for cp in range(0xFF01, 0xFF5E + 1):
+        overrides[cp] = 0  # Double-width ASCII characters
+
     return overrides
 
 def organize_by_pages(fallback_map):
diff --git a/drivers/tty/vt/ucs.c b/drivers/tty/vt/ucs.c
index 6c15c5deda5b..6ead622b7713 100644
--- a/drivers/tty/vt/ucs.c
+++ b/drivers/tty/vt/ucs.c
@@ -224,6 +224,14 @@ u32 ucs_get_fallback(u32 cp)
 	if (!UCS_IS_BMP(cp))
 		return 0;
 
+	/*
+	 * Full-width to ASCII mapping (covering all printable ASCII 33-126)
+	 * 0xFF01 (！) to 0xFF5E (～) -> ASCII 33 (!) to 126 (~)
+	 * We process them programmatically to reduce the table size.
+	 */
+	if (cp >= 0xFF01 && cp <= 0xFF5E)
+		return cp - 0xFF01 + 33;
+
 	page = __inline_bsearch(&page_idx, ucs_fallback_pages,
 				ARRAY_SIZE(ucs_fallback_pages),
 				sizeof(*ucs_fallback_pages),
diff --git a/drivers/tty/vt/ucs_fallback_table.h_shipped b/drivers/tty/vt/ucs_fallback_table.h_shipped
index 7fa803511eb5..2da5a8fe1cf1 100644
--- a/drivers/tty/vt/ucs_fallback_table.h_shipped
+++ b/drivers/tty/vt/ucs_fallback_table.h_shipped
@@ -60,7 +60,7 @@ static const struct ucs_page_desc ucs_fallback_pages[] = {
 	{ 0xC7, 1, 3105 },
 	{ 0xFB, 35, 3106 },
 	{ 0xFE, 37, 3141 },
-	{ 0xFF, 144, 3178 },
+	{ 0xFF, 50, 3178 },
 };
 
 /* Page entries array (referenced by page descriptors) */
@@ -3291,100 +3291,6 @@ static const struct ucs_page_entry ucs_fallback_entries[] = {
 	{ 0x6A, 0x25 }, /* SMALL PERCENT SIGN -> '%' */
 	{ 0x6B, 0x40 }, /* SMALL COMMERCIAL AT -> '@' */
 	/* Entries for page 0xFF */
-	{ 0x01, 0x21 }, /* FULLWIDTH EXCLAMATION MARK -> '!' */
-	{ 0x02, 0x22 }, /* FULLWIDTH QUOTATION MARK -> '"' */
-	{ 0x03, 0x23 }, /* FULLWIDTH NUMBER SIGN -> '#' */
-	{ 0x04, 0x24 }, /* FULLWIDTH DOLLAR SIGN -> '$' */
-	{ 0x05, 0x25 }, /* FULLWIDTH PERCENT SIGN -> '%' */
-	{ 0x06, 0x26 }, /* FULLWIDTH AMPERSAND -> '&' */
-	{ 0x07, 0x27 }, /* FULLWIDTH APOSTROPHE -> ''' */
-	{ 0x08, 0x28 }, /* FULLWIDTH LEFT PARENTHESIS -> '(' */
-	{ 0x09, 0x29 }, /* FULLWIDTH RIGHT PARENTHESIS -> ')' */
-	{ 0x0A, 0x2A }, /* FULLWIDTH ASTERISK -> '*' */
-	{ 0x0B, 0x2B }, /* FULLWIDTH PLUS SIGN -> '+' */
-	{ 0x0C, 0x2C }, /* FULLWIDTH COMMA -> ',' */
-	{ 0x0D, 0x2D }, /* FULLWIDTH HYPHEN-MINUS -> '-' */
-	{ 0x0E, 0x2E }, /* FULLWIDTH FULL STOP -> '.' */
-	{ 0x0F, 0x2F }, /* FULLWIDTH SOLIDUS -> '/' */
-	{ 0x10, 0x30 }, /* FULLWIDTH DIGIT ZERO -> '0' */
-	{ 0x11, 0x31 }, /* FULLWIDTH DIGIT ONE -> '1' */
-	{ 0x12, 0x32 }, /* FULLWIDTH DIGIT TWO -> '2' */
-	{ 0x13, 0x33 }, /* FULLWIDTH DIGIT THREE -> '3' */
-	{ 0x14, 0x34 }, /* FULLWIDTH DIGIT FOUR -> '4' */
-	{ 0x15, 0x35 }, /* FULLWIDTH DIGIT FIVE -> '5' */
-	{ 0x16, 0x36 }, /* FULLWIDTH DIGIT SIX -> '6' */
-	{ 0x17, 0x37 }, /* FULLWIDTH DIGIT SEVEN -> '7' */
-	{ 0x18, 0x38 }, /* FULLWIDTH DIGIT EIGHT -> '8' */
-	{ 0x19, 0x39 }, /* FULLWIDTH DIGIT NINE -> '9' */
-	{ 0x1A, 0x3A }, /* FULLWIDTH COLON -> ':' */
-	{ 0x1B, 0x3B }, /* FULLWIDTH SEMICOLON -> ';' */
-	{ 0x1C, 0x3C }, /* FULLWIDTH LESS-THAN SIGN -> '<' */
-	{ 0x1D, 0x3D }, /* FULLWIDTH EQUALS SIGN -> '=' */
-	{ 0x1E, 0x3E }, /* FULLWIDTH GREATER-THAN SIGN -> '>' */
-	{ 0x1F, 0x3F }, /* FULLWIDTH QUESTION MARK -> '?' */
-	{ 0x20, 0x40 }, /* FULLWIDTH COMMERCIAL AT -> '@' */
-	{ 0x21, 0x41 }, /* FULLWIDTH LATIN CAPITAL LETTER A -> 'A' */
-	{ 0x22, 0x42 }, /* FULLWIDTH LATIN CAPITAL LETTER B -> 'B' */
-	{ 0x23, 0x43 }, /* FULLWIDTH LATIN CAPITAL LETTER C -> 'C' */
-	{ 0x24, 0x44 }, /* FULLWIDTH LATIN CAPITAL LETTER D -> 'D' */
-	{ 0x25, 0x45 }, /* FULLWIDTH LATIN CAPITAL LETTER E -> 'E' */
-	{ 0x26, 0x46 }, /* FULLWIDTH LATIN CAPITAL LETTER F -> 'F' */
-	{ 0x27, 0x47 }, /* FULLWIDTH LATIN CAPITAL LETTER G -> 'G' */
-	{ 0x28, 0x48 }, /* FULLWIDTH LATIN CAPITAL LETTER H -> 'H' */
-	{ 0x29, 0x49 }, /* FULLWIDTH LATIN CAPITAL LETTER I -> 'I' */
-	{ 0x2A, 0x4A }, /* FULLWIDTH LATIN CAPITAL LETTER J -> 'J' */
-	{ 0x2B, 0x4B }, /* FULLWIDTH LATIN CAPITAL LETTER K -> 'K' */
-	{ 0x2C, 0x4C }, /* FULLWIDTH LATIN CAPITAL LETTER L -> 'L' */
-	{ 0x2D, 0x4D }, /* FULLWIDTH LATIN CAPITAL LETTER M -> 'M' */
-	{ 0x2E, 0x4E }, /* FULLWIDTH LATIN CAPITAL LETTER N -> 'N' */
-	{ 0x2F, 0x4F }, /* FULLWIDTH LATIN CAPITAL LETTER O -> 'O' */
-	{ 0x30, 0x50 }, /* FULLWIDTH LATIN CAPITAL LETTER P -> 'P' */
-	{ 0x31, 0x51 }, /* FULLWIDTH LATIN CAPITAL LETTER Q -> 'Q' */
-	{ 0x32, 0x52 }, /* FULLWIDTH LATIN CAPITAL LETTER R -> 'R' */
-	{ 0x33, 0x53 }, /* FULLWIDTH LATIN CAPITAL LETTER S -> 'S' */
-	{ 0x34, 0x54 }, /* FULLWIDTH LATIN CAPITAL LETTER T -> 'T' */
-	{ 0x35, 0x55 }, /* FULLWIDTH LATIN CAPITAL LETTER U -> 'U' */
-	{ 0x36, 0x56 }, /* FULLWIDTH LATIN CAPITAL LETTER V -> 'V' */
-	{ 0x37, 0x57 }, /* FULLWIDTH LATIN CAPITAL LETTER W -> 'W' */
-	{ 0x38, 0x58 }, /* FULLWIDTH LATIN CAPITAL LETTER X -> 'X' */
-	{ 0x39, 0x59 }, /* FULLWIDTH LATIN CAPITAL LETTER Y -> 'Y' */
-	{ 0x3A, 0x5A }, /* FULLWIDTH LATIN CAPITAL LETTER Z -> 'Z' */
-	{ 0x3B, 0x5B }, /* FULLWIDTH LEFT SQUARE BRACKET -> '[' */
-	{ 0x3C, 0x5C }, /* FULLWIDTH REVERSE SOLIDUS -> '\' */
-	{ 0x3D, 0x5D }, /* FULLWIDTH RIGHT SQUARE BRACKET -> ']' */
-	{ 0x3E, 0x5E }, /* FULLWIDTH CIRCUMFLEX ACCENT -> '^' */
-	{ 0x3F, 0x5F }, /* FULLWIDTH LOW LINE -> '_' */
-	{ 0x40, 0x60 }, /* FULLWIDTH GRAVE ACCENT -> '`' */
-	{ 0x41, 0x61 }, /* FULLWIDTH LATIN SMALL LETTER A -> 'a' */
-	{ 0x42, 0x62 }, /* FULLWIDTH LATIN SMALL LETTER B -> 'b' */
-	{ 0x43, 0x63 }, /* FULLWIDTH LATIN SMALL LETTER C -> 'c' */
-	{ 0x44, 0x64 }, /* FULLWIDTH LATIN SMALL LETTER D -> 'd' */
-	{ 0x45, 0x65 }, /* FULLWIDTH LATIN SMALL LETTER E -> 'e' */
-	{ 0x46, 0x66 }, /* FULLWIDTH LATIN SMALL LETTER F -> 'f' */
-	{ 0x47, 0x67 }, /* FULLWIDTH LATIN SMALL LETTER G -> 'g' */
-	{ 0x48, 0x68 }, /* FULLWIDTH LATIN SMALL LETTER H -> 'h' */
-	{ 0x49, 0x69 }, /* FULLWIDTH LATIN SMALL LETTER I -> 'i' */
-	{ 0x4A, 0x6A }, /* FULLWIDTH LATIN SMALL LETTER J -> 'j' */
-	{ 0x4B, 0x6B }, /* FULLWIDTH LATIN SMALL LETTER K -> 'k' */
-	{ 0x4C, 0x6C }, /* FULLWIDTH LATIN SMALL LETTER L -> 'l' */
-	{ 0x4D, 0x6D }, /* FULLWIDTH LATIN SMALL LETTER M -> 'm' */
-	{ 0x4E, 0x6E }, /* FULLWIDTH LATIN SMALL LETTER N -> 'n' */
-	{ 0x4F, 0x6F }, /* FULLWIDTH LATIN SMALL LETTER O -> 'o' */
-	{ 0x50, 0x70 }, /* FULLWIDTH LATIN SMALL LETTER P -> 'p' */
-	{ 0x51, 0x71 }, /* FULLWIDTH LATIN SMALL LETTER Q -> 'q' */
-	{ 0x52, 0x72 }, /* FULLWIDTH LATIN SMALL LETTER R -> 'r' */
-	{ 0x53, 0x73 }, /* FULLWIDTH LATIN SMALL LETTER S -> 's' */
-	{ 0x54, 0x74 }, /* FULLWIDTH LATIN SMALL LETTER T -> 't' */
-	{ 0x55, 0x75 }, /* FULLWIDTH LATIN SMALL LETTER U -> 'u' */
-	{ 0x56, 0x76 }, /* FULLWIDTH LATIN SMALL LETTER V -> 'v' */
-	{ 0x57, 0x77 }, /* FULLWIDTH LATIN SMALL LETTER W -> 'w' */
-	{ 0x58, 0x78 }, /* FULLWIDTH LATIN SMALL LETTER X -> 'x' */
-	{ 0x59, 0x79 }, /* FULLWIDTH LATIN SMALL LETTER Y -> 'y' */
-	{ 0x5A, 0x7A }, /* FULLWIDTH LATIN SMALL LETTER Z -> 'z' */
-	{ 0x5B, 0x7B }, /* FULLWIDTH LEFT CURLY BRACKET -> '{' */
-	{ 0x5C, 0x7C }, /* FULLWIDTH VERTICAL LINE -> '|' */
-	{ 0x5D, 0x7D }, /* FULLWIDTH RIGHT CURLY BRACKET -> '}' */
-	{ 0x5E, 0x7E }, /* FULLWIDTH TILDE -> '~' */
 	{ 0x61, 0x2E }, /* HALFWIDTH IDEOGRAPHIC FULL STOP -> '.' */
 	{ 0x62, 0x5B }, /* HALFWIDTH LEFT CORNER BRACKET -> '[' */
 	{ 0x63, 0x5D }, /* HALFWIDTH RIGHT CORNER BRACKET -> ']' */
-- 
2.49.0

