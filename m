Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5F25C807;
	Mon,  5 May 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464472; cv=none; b=c6agB0mXkGvtThZUL+9JJnXMhiHF7chneeC1n/Yt6k3zlwiEYO707MMKkzrZPY4VQnTsYGsbPsZR7OHqpqOcEZrkv+cwQhjxhSymwJHzu+M9iC1dVM+Obw1zf8sEiIx92QJFynxN/KnKZQLrSoo5dqJIL6w1K82XE81er+LbWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464472; c=relaxed/simple;
	bh=p9nY1NAFGtHgUpIZVBZajYP8aShmdwshXSYnOJp9EWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMy/eyMHN7d31LW+FcsoZrM0WdPy5iOpxQsAsNJPd/ac++d0a/OYwXnatM8amLVA6K3QxTpb2or4SeroqZrIk1dLzCWoCGVOeg+sOKTft/Xi/Qk/4KS6ZYNOjQLTMegkT3pjVC/usna53ILFj0MOCrycbf6JAK20+diAcLBl9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=arUgfUTY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLLuHXvp; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="arUgfUTY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLLuHXvp"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C48D0254029D;
	Mon,  5 May 2025 13:01:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 05 May 2025 13:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746464469;
	 x=1746550869; bh=TGWIYC33gmFduO8qrWFHsccAtU9c5cr+Hb5yF9c5+7k=; b=
	arUgfUTYYR9PxFhKZXN0WEeIbQ6PosCATULRkv3lj7RhGTAvCPpD7CxNtYlea1jT
	Sc0NosKi4NucjVgpLlci+I4WZAVc5ZDeQ/5ixSYn39mgGSaTH3KkRTuqUKI/LUxr
	ZE+MEW+lgcTWUS7EQpf2VIwt+3RzGz3kaKkQ89thsZN/ppyuSQqeuWeUvEm4LXqi
	pK6EquEPN4WvtO91HgjVsjLXHzP1i384LvkqBrORn4m+iqsY8QkcezJVPshJ6zZN
	8Ox50hfi8leBFbnYeaIHPSGAR//QwMlCZAOey4Iqw6//0ABNLvS7qOvJ3vmSr2nX
	iRdEQo2ZZqdlzsf7K97Ldg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746464469; x=
	1746550869; bh=TGWIYC33gmFduO8qrWFHsccAtU9c5cr+Hb5yF9c5+7k=; b=f
	LLuHXvpZpj7X+aDHpkco5lyNdAmROMf9Pvmrp0S1PY6BuUk/HZYvdFyKx8nyLG/5
	ANyOE5QjwRgQVrAXkp6nPtfO9Y5da/BrLm4eH+NdlynDoAcqN21h2FenpKTxbk8I
	ycanGHOwn+4Q0ic8yFLb+iWzIQepv4kLkWosfDnpcDOYDATk4JI+w3XYd1PigKp/
	BK9YhB4TKmYsa3VXsFqYXSwX9FsxEQXGGk6yoT1VEddmUdZ0W5yh2f8Mh5ElZ8Nx
	gUHtAhNokxtcoifCrbIGyKT7840p16ikkGp/7IUNvRg2Id7Op/h37M+3iyka8rUf
	V0SH0/Cqm1fsIxykCoQ6A==
X-ME-Sender: <xms:1e4YaCPOaj5aCSQ46-rGPuRJscxe0yUkd4oUR_4lGhpsM_98p8LPAQ>
    <xme:1e4YaA9T5zLTrccpRqmhUjBXUtUan75SivZ4mEbNDO1uJvSwEH6N5o8XD74Zh4Gax
    tDfAwGf4WnhitkK3CY>
X-ME-Received: <xmr:1e4YaJQvUgyeqpYyUdfZ_KLIP3bIqHJ0T7fHJUU9h80Saq6CqGAL7u05_9GUSv4E3B1MakaGOnnqP3ud07tm8GhCHgUoADE2L3Vr3d3HNdplozgImw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduieehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1e4YaCumEI9a3dgAhIasSD1cD5axysg1rB5xoH-2it-kRBkRE6eLFw>
    <xmx:1e4YaKcmSZUz0KkBKiXizvkd6ZH2Mx_taQtGYni56hSIUe2cA7Itdw>
    <xmx:1e4YaG0buj3NoLHj4Y_oQKCJFr6TRquMVLDQ5XmuzR4-siIYLnJD5w>
    <xmx:1e4YaO8s-73Z2IsIHdYU5ndRXV2a_TqK-CFJngGaHrip6dhsPCdzFg>
    <xmx:1e4YaDcCj0fuKCEU6PIHdDDQ1mMNX7BZL2wCRHdFg5eVqljQ_XVIS3dN>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 13:01:09 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 43D851185462;
	Mon, 05 May 2025 13:01:08 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] vt: make use of ucs_get_fallback() when glyph is unavailable
Date: Mon,  5 May 2025 12:55:30 -0400
Message-ID: <20250505170021.29944-8-nico@fluxnic.net>
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

Attempt to display a fallback character when given character doesn't
have an available glyph. The substitution may not be as good as the
original character but still way more helpful than a squared question
mark.

Example substitutions: À -> A, ç -> c, ø -> o, ─ -> -, © -> C, etc.

See gen_ucs_fallback_table.py for a comprehensive list.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4e80384a419b..479a03647aab 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3009,6 +3009,19 @@ static int vc_get_glyph(struct vc_data *vc, int tc)
 		return tc;
 	}
 
+	/*
+	 * The Unicode screen memory is allocated only when required.
+	 * This is one such case: we're about to "cheat" with the displayed
+	 * character meaning the simple screen buffer won't hold the original
+	 * information, whereas the Unicode screen buffer always does.
+	 */
+	vc_uniscr_check(vc);
+
+	/* Try getting a simpler fallback character. */
+	tc = ucs_get_fallback(tc);
+	if (tc)
+		return vc_get_glyph(vc, tc);
+
 	/* Display U+FFFD (Unicode Replacement Character). */
 	return conv_uni_to_pc(vc, UCS_REPLACEMENT);
 }
-- 
2.49.0

