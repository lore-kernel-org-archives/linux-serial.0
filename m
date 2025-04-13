Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D21A0711
	for <linux-serial@vger.kernel.org>; Sun, 13 Apr 2025 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570115; cv=none; b=EL1e/hrQ0jbN8q/JtYn50H4Sev8pgTKj9vp4itvEHlMryBKfAyfRrObQg41qb+tIiojrpaDE5K85gdDffcreePPpE/MkaL+fT2GOF9NEjC4iLW6jUzaBTvfmCPRDLI9whK/CZQVsWPsLjazdAzEPT9HM6gopQqD7eO/vPmtOLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570115; c=relaxed/simple;
	bh=gbUpL5LQejUxLQNogqtMR01HE9nI8CCKKq9VOy+Jhpc=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=mke/1bevRP+ba8xoCoL0xbvNcyuTE0+Q6ZN4/QSSleEF193Y5PIGoU5yo0+G9c/ez3jyLKpr7V9INGbFpfg3EMbUDqq+7kge3eBWD6EESpnF6ilAlWMU//bUhEv0KxdGsDVZhGmB2Ey3VPr1WNmYZIIK53PRJRVhdrRLMSH9SX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=gVQBrjCP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFgqRV9b; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="gVQBrjCP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFgqRV9b"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47C9511400F8;
	Sun, 13 Apr 2025 14:48:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 13 Apr 2025 14:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1744570111; x=1744656511; bh=VbAQ7wTUpSTdKJ2sAD3f0SuDsnMxj5Fn
	U03kshSrTWw=; b=gVQBrjCPyT3Rx2PgjZxPPOUQ3QA5DekUp6PFiP1U/ToYQTeb
	Vho/BR/dlZpcKvkRQcEUCn+8z1AQApnU0+mfklA3a+sp4cDnfpAzF2rIaSmhF+1r
	HmcNO0b3ybibtyn3wlUkdKMnhyWyKkQiMrhrztnhrOOM0kiK/4RpMANaeISLlj4y
	SyCaqKSdZP33XbLJgHjnnIw9ML7TMP4FUIGLGaoUst1fCfxjP53HmCg54hkaJQ2T
	ioAx4S2BQAHAmiHQ9Q/0dASu6JsFM3bQ2XwjuMKuIc8jFKmnQ3x+9uFepRiBJoah
	fRJ0RmwGHyD9SoTxderrYa0T8A8S8RQXtlDFUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744570111; x=
	1744656511; bh=VbAQ7wTUpSTdKJ2sAD3f0SuDsnMxj5FnU03kshSrTWw=; b=X
	FgqRV9bFHOD6DOJUfMFYlLxo51Ke//DDDG33oAy8ao/OSuWnGMrV/nCrUBVtYz85
	NaxwMl84tvGO1HJ/bL+NY7+aKGRaMSurjPANJ0ziQf9UNX3LvsCjEgpf5WWo5i4V
	bQDGZWZrQYv7H9DuvhyTzyjBrWaDde9mmrcBTdO/hUPhUi1sKa6WbI+rV6F2oZJe
	CgEcxTYkS7TZSUiLtzRGr0jPcNZweR6LlTRwh/NdmYduGyQxji+EgVZ8DIzzcuoz
	l1TTwgKBoXWaPenNpL/E+KEdwJTYvFINQAAvErRKmF1N9pH1AMOKNVPQRwtl9JjZ
	ztNEWp96FalaQlGzuoNwA==
X-ME-Sender: <xms:_gb8Z0989JMK0yWya6vBFyYJNfNIZRh8wMZJ7JcWIpuBsIfebh9DgQ>
    <xme:_gb8Z8sDkgltGYWxICE_UDalRpatunit_bxURdkDmUCrUoupUnNfwf4sL9o1klx2s
    9YYit2XTbNyuGOCniw>
X-ME-Received: <xmr:_gb8Z6BXGMN7XdC2pUkikF4wL3WzJtWAw3tZb6SBI_IsV63yEh9JEKH7-4OOzwwLx1P-12K0eH8mjUcSGN-mem46ms9rqDY7ylertDPT2wowY7Yz1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkgggtsehttdertddttddvnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeeigfeiteevgefgtdehhfegvedvvdfhtedugeettdek
    veegteeifefgveeigeetvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehflhhu
    gihnihgtrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepghhr
    vghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_gb8Z0d7erw_BVdI6El9d-EjggoO48xnczT2cVb4MgLOTG0tzSoVSQ>
    <xmx:_gb8Z5MLoL6sTAVoUZPfKO0pF4cF_zY9Dm3y2GX0SNCaOykMez0DXg>
    <xmx:_gb8Z-mb9ZpyOH7Lc0Ol3MpiV3Xjur5Md88rtKdjgapPPToGMCozEA>
    <xmx:_gb8Z7tJEOB2rVocTpzQjRiWOxe1cW_AHbJ-MLJTb80HusvcDODu-g>
    <xmx:_wb8Z0b78FdPAoAnCyaTdlNV2voCF5m6cN1q49xQpRxiwBFmvOzJ8unX>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Apr 2025 14:48:30 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 3B328110F792;
	Sun, 13 Apr 2025 14:48:30 -0400 (EDT)
Date: Sun, 13 Apr 2025 14:48:30 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Nicolas Pitre <npitre@baylibre.com>, linux-serial@vger.kernel.org
Subject: [PATCH] vt: fix comment vs definition mismatch
Message-ID: <r1n0s058-o512-s6r2-np91-047p5081r367@syhkavp.arg>
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
