Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7476F23AE62;
	Fri, 11 Apr 2025 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393444; cv=none; b=lb6y9DhyaSL3rtX/hcP5oAWDwq/coltVIzr4sc/sShgcELIlA/f09pofyORxnU15ombimWOHbjrLjh1UNezW9DJgl/9n0cXkOndIZz56OpUjbQsknjepecT9SYPLjrv/Lmwn3iBhabLRFD4uC0JBfUQJoGS5kh1Tt4LtMFkcev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393444; c=relaxed/simple;
	bh=xAo68r/zLZKopFFxEIk6BtCwwpIOjTADTc6B2aF6X4k=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=nVtC2H+12uGU8o51uD2t/S6+qppzDKuqw5mY8zZYEHBhFPe+7MxydTyzegrwPKwbAw+SQQRsimkCcBlkdq7ZJ1MiZAZ63d6lQ34YBKRd89xd7J+yhkxl15qsYnvedT2Fbdua43q5JKw74Il/aZA2HvMYpjn+kcgTap9hjt+f20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=U8qBk3Vx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OV+kP/rp; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="U8qBk3Vx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OV+kP/rp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 32114114015E;
	Fri, 11 Apr 2025 13:44:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 11 Apr 2025 13:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1744393440; x=1744479840; bh=prpraNBeUM3zXDzIoi1D0Ms8tSWXePNg
	ZwUoM8XhD2I=; b=U8qBk3Vx8Y0mRmVqcLqPk6RJ+A2yQz3LmRPOQo0cJuf6sKjP
	lEvqglguqa5UjiNgTDj4Yv9jgJUFbFiLXUJthtv35N3YODm7mqQDXZcgRZ1O8KG9
	MNxUMtcQvmKdSk+kJsVq12Gsaq1YRdRZS28VOanzXOwtgVkCJWoWP83p+vBgJ+CN
	kYzk6CB19Y8BJ+25OUqN93/+X2wG7JxSl1c4MTtuWsJX+RpQo1xE4bc3tdovR+1g
	AyxivLeZGYYEdfD9DeSQ0qkU0M5cpJ3IH/uUP2IKmh+G4aTZB1kCbhoZi5W9mhI0
	mH0MHUxoVUkSgl24x4K5XCe7K66gy5PHFWpMIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744393440; x=
	1744479840; bh=prpraNBeUM3zXDzIoi1D0Ms8tSWXePNgZwUoM8XhD2I=; b=O
	V+kP/rpUX0J+XZIxN3j2ZT8zZFMOfDC8ub7QpuKTXDXVKp7upbpKNJkrA97mwWCX
	ob96/7+gwlp0JQLLLM8QPEc48BCQb0aUt2csUVmblfJ/Ok6is4SzsfCnDkGx2dTA
	3KtzyPjIeooNX5ZIg9NtQOVAXkE0Pv08oj6zf6EMlulmTHAvCGxUWlynvZn0hz/B
	nVFbaRQxPSf/eopKJWqYYrTJNuK80cSAoRXtCY0iTiTTcyL4nq0jdFBFx8DJYb9L
	oq3+xO53zQiCl1+fijyctrkqUZqrTdB9ZsHOi0lOFv1VJQ7sVZXL1lALqFlpGfZh
	ZqGhKeWUwkDSjBFzkf3Ig==
X-ME-Sender: <xms:31T5Z2EmFc02pCLo63WO68g04-EKY__5AjrEWo1y-K8hoSGbVbqUfQ>
    <xme:31T5Z3WZ3hl0btOWQQt42mTiyLhDkJhNhLbeMF9LoirxZ_vP3jj7HN_EoQ6NMq0ce
    GMhOUWaxvUUPy9qHtM>
X-ME-Received: <xmr:31T5ZwLN4uadnQ124gI9UAbeV7FDGxMTdBv5aDpoW1VZYbW7VjyyZDlJBTRR7xQCUVuv_EczTvLDCkW0SfGQwry9WHS627mNXXGJ-XWbEuZKjb-UIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkgggtsehttdertddttddvnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeeigfeiteevgefgtdehhfegvedvvdfhtedugeettdek
    veegteeifefgveeigeetvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehflhhu
    gihnihgtrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhi
    rhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlih
    hnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhgvsehmihgvlhhk
    vgdrtggtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:31T5ZwGCfBEmUmB0hVMHBcCdtfU3TL7UD5XfqzQ5Y-YOaOjL-7IMnA>
    <xmx:31T5Z8UEAEK4gg0jXB6gCZcdqlrxOxEUuGojwgeVJx20p3gq3JMlDQ>
    <xmx:31T5ZzOizdrtch5CmSMF3R1yLq38sqgKvTrR1OB8zfaR7NotEXmdfg>
    <xmx:31T5Zz1z6RxrmU6m5S13qBtXoh3tOmEG8YqfwBAEs5zGFR2Mg-BqwA>
    <xmx:4FT5Z50ntE4Td1IkSAmuHOROfjoViyiOD5xf0rTDjuMqGABhZVqRaLV1>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 13:43:59 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id A675F10DDA13;
	Fri, 11 Apr 2025 13:43:58 -0400 (EDT)
Date: Fri, 11 Apr 2025 13:43:58 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, Dave Mielke <Dave@mielke.cc>, 
    Nicolas Pitre <npitre@baylibre.com>, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH] vt: fix comment vs definition mismatch
Message-ID: <o4974349-pp4p-4374-80q9-2oppqqr94r60@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From: Nicolas Pitre <npitre@baylibre.com>

Fixes for:

  ucs_is_zero_width()
  ucs_is_double_width()
  ucs_recompose()

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504111036.YH1iEqBR-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202504111359.urXWyzvQ-lkp@intel.com/
---

On Fri, 11 Apr 2025, Greg Kroah-Hartman wrote:

> Wow, very nice work, thanks for doing all of this.  I'll go queue it up
> now, the kernel test robot warnings for comments can be fixed up later
> if you want to.

Oops. Here it is.

diff --git a/drivers/tty/vt/gen_ucs_recompose.py b/drivers/tty/vt/gen_ucs_recompose.py
index 64418803e4..dc176d32e2 100755
--- a/drivers/tty/vt/gen_ucs_recompose.py
+++ b/drivers/tty/vt/gen_ucs_recompose.py
@@ -289,8 +289,8 @@ static int recomposition_compare(const void *key, const void *element)
 /**
  * Attempt to recompose two Unicode characters into a single character.
  *
- * @param previous: Previous Unicode code point (UCS-4)
- * @param current: Current Unicode code point (UCS-4)
+ * @param base: Base Unicode code point (UCS-4)
+ * @param combining: Combining mark Unicode code point (UCS-4)
  * Return: Recomposed Unicode code point, or 0 if no recomposition is possible
  */
 uint32_t ucs_recompose(uint32_t base, uint32_t combining)
@@ -301,7 +301,6 @@ uint32_t ucs_recompose(uint32_t base, uint32_t combining)
 		return 0;
 
 	struct compare_key key = {{ base, combining }};
-
 	struct recomposition *result =
 		__inline_bsearch(&key, recomposition_table,
 				 ARRAY_SIZE(recomposition_table),
diff --git a/drivers/tty/vt/gen_ucs_width.py b/drivers/tty/vt/gen_ucs_width.py
index c6cbc93e83..e65f43e208 100755
--- a/drivers/tty/vt/gen_ucs_width.py
+++ b/drivers/tty/vt/gen_ucs_width.py
@@ -292,7 +292,7 @@ static bool is_in_interval32(uint32_t cp, const struct interval32 *intervals, si
 /**
  * Determine if a Unicode code point is zero-width.
  *
- * @param ucs: Unicode code point (UCS-4)
+ * @param cp: Unicode code point (UCS-4)
  * Return: true if the character is zero-width, false otherwise
  */
 bool ucs_is_zero_width(uint32_t cp)
@@ -305,7 +305,7 @@ bool ucs_is_zero_width(uint32_t cp)
 /**
  * Determine if a Unicode code point is double-width.
  *
- * @param ucs: Unicode code point (UCS-4)
+ * @param cp: Unicode code point (UCS-4)
  * Return: true if the character is double-width, false otherwise
  */
 bool ucs_is_double_width(uint32_t cp)
diff --git a/drivers/tty/vt/ucs_recompose.c b/drivers/tty/vt/ucs_recompose.c
index 5c30c989de..52cde1517f 100644
--- a/drivers/tty/vt/ucs_recompose.c
+++ b/drivers/tty/vt/ucs_recompose.c
@@ -147,8 +147,8 @@ static int recomposition_compare(const void *key, const void *element)
 /**
  * Attempt to recompose two Unicode characters into a single character.
  *
- * @param previous: Previous Unicode code point (UCS-4)
- * @param current: Current Unicode code point (UCS-4)
+ * @param base: Base Unicode code point (UCS-4)
+ * @param combining: Combining mark Unicode code point (UCS-4)
  * Return: Recomposed Unicode code point, or 0 if no recomposition is possible
  */
 uint32_t ucs_recompose(uint32_t base, uint32_t combining)
@@ -159,7 +159,6 @@ uint32_t ucs_recompose(uint32_t base, uint32_t combining)
 		return 0;
 
 	struct compare_key key = { base, combining };
-
 	struct recomposition *result =
 		__inline_bsearch(&key, recomposition_table,
 				 ARRAY_SIZE(recomposition_table),
diff --git a/drivers/tty/vt/ucs_width.c b/drivers/tty/vt/ucs_width.c
index 060aa8ae7f..4d5a0021e3 100644
--- a/drivers/tty/vt/ucs_width.c
+++ b/drivers/tty/vt/ucs_width.c
@@ -512,7 +512,7 @@ static bool is_in_interval32(uint32_t cp, const struct interval32 *intervals, si
 /**
  * Determine if a Unicode code point is zero-width.
  *
- * @param ucs: Unicode code point (UCS-4)
+ * @param cp: Unicode code point (UCS-4)
  * Return: true if the character is zero-width, false otherwise
  */
 bool ucs_is_zero_width(uint32_t cp)
@@ -525,7 +525,7 @@ bool ucs_is_zero_width(uint32_t cp)
 /**
  * Determine if a Unicode code point is double-width.
  *
- * @param ucs: Unicode code point (UCS-4)
+ * @param cp: Unicode code point (UCS-4)
  * Return: true if the character is double-width, false otherwise
  */
 bool ucs_is_double_width(uint32_t cp)
