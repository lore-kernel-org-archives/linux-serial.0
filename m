Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AE2566FE;
	Thu, 17 Apr 2025 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915754; cv=none; b=ZUv1PLDw9nWIFCKx1ByDbM3GngSGWzC1HEq4sePHCqychlACqCe45Mw9quCLqx9SovM4+W1hj5uvT8Jy5E67pmG7sIhWagRBtfLRdR2kR5KtpK5pS827NsieoGKGxyHtvE0Jtu598X0MESR87Tufduixe5xoh382tKs20LJ3bY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915754; c=relaxed/simple;
	bh=azSeZh6pGjwVNUQ0XFxqbK4BRPqes2S8OJZmPp5wogo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4/0Gqi8KxbmKGbwJmZk/Gnypo/Z1C7HaWpjsIVk+dsPTK7ObBosUb3wTVsKRQ4f0A6JJ+yFU3iGPmWrE2OgbFHi9s9wVS0l4dl6FFEMHcGFvjEX8O51I14WrEBwvFrgM9Rk14vqe5dyFnhtRlJqzcFKIXLJBUbo3HtdxI20a7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=bQvl0Kfk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NXUb2F/U; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="bQvl0Kfk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NXUb2F/U"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F88B254015A;
	Thu, 17 Apr 2025 14:49:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 17 Apr 2025 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915748; x=
	1745002148; bh=99nVY6bnkGnbESwgNeAFXn5H5Vcb38/1+1jeQ+ArvBQ=; b=b
	Qvl0KfkbVH92hvrnwMr9hzDYp9VUOlFpcDna0Nsd1H4zisc3ZOggG/YjUv0wNspK
	FchtEjg3ScsUOFfnf1LNufBAo0MgZH+wvbXB9nAnm320LjxJFt54HSWhlFr/VKTu
	ylnQKJwASypmOQRZk4Fnh3bG6swSUxpSbjGB8FU6HLL8oFTVbG0yf2sQOMMo8Ygo
	Mk4QYcInk+MLqyvoGqLtm51vwg+vE7gqjRf9R35uVg2BPDBuDorrc+qGKrrcqxfL
	onw/XmBsYELm4yQGsRLm7lN1sl3O99QZaqZB4eb6yUAhwEduXCFwx+TJJXkMietg
	GdoreKRstwTOA7GEe0KYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915748; x=1745002148; bh=9
	9nVY6bnkGnbESwgNeAFXn5H5Vcb38/1+1jeQ+ArvBQ=; b=NXUb2F/UjMf+DPU5b
	dueMjkdHa6wNtaRSBYfl2ks3CpDR491micV/Vx9K0S5VypEgD3qbB4oaRJbkCdNd
	aVpF6dTPjaozOc32BRFV7P6rgQzk8qy/McmIjZQBL94hxAhHxmuKtJ46RbRZbyB7
	9TUn9PEjRBNr28kajHAYJXkgaanDVzqx8aMl4FDFwy5WhQP2iCeLw0nGqPA7o7um
	7wPLUhFrFxEmvY/HnxuV5Gv7D6GtrJ2TUj8S4RHzLYUod8ReXDW8f8hokYXKa8Bs
	whVJB7QgnZqhyysVHJ50DTMVu5akAj89jCcOcYukVyW/ccwgGa7cglLbMBxgdNAX
	W6u2g==
X-ME-Sender: <xms:JE0BaFaDhUsarI1oF-yRYzl-bL59CVXSHV_NYHSc5kb-TwUfQlsnGg>
    <xme:JE0BaMZLFgs4zX7y0Lzg4ZdrPQzvRP6DYCinemor08ALRJuuz0SkYM2rdskgVMy37
    Cr8SEMebq6uc7LsZwQ>
X-ME-Received: <xmr:JE0BaH9_ekZzkqz8HtQjN37SOEWYx9ir2AaMLlG6S49AAFoq1AigrnVVaPonS4OTrlSnw4dAQBgJaZbGvh0PjZ00U3GIEiciuMMyA-WGImpXync4wg>
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
X-ME-Proxy: <xmx:JE0BaDrPqwCuDsuC3tdIPxQISgkzdR5IrBB6nc7tK5qLCCJAZuP4Kg>
    <xmx:JE0BaAocETdIRrvH_zTylia1DzRie85Vf2rCgLpOUdiwrPLV7osCrQ>
    <xmx:JE0BaJSImNcB8w7AsnBPo6Z6oysw6M6z_1E1NY73dFdZhgkVS1Qp0w>
    <xmx:JE0BaIqwtImqHTVQ-3hwWW3TD2G5hKJaB5hTIoSZc3rt2_RzDjXEAQ>
    <xmx:JE0BaN6NqKaW6t-pQMVUi1O01ubwbGTCUJeV0tu8SjYMMrB8wa_IvYma>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id F0F7511443D5;
	Thu, 17 Apr 2025 14:49:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/14] vt: pad double-width code points with a zero-width space
Date: Thu, 17 Apr 2025 14:45:12 -0400
Message-ID: <20250417184849.475581-11-nico@fluxnic.net>
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

In the Unicode screen buffer, we follow double-width code points with a
space to maintain proper column alignment. This, however, creates
semantic problems when e.g. using cut and paste.

Let's use a better code point for the column padding's purpose i.e. a
zero-width space rather than a full space. This way the combination
retains a width of 2.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 76554c2040..1bd1878094 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2923,6 +2923,7 @@ static void vc_con_rewind(struct vc_data *vc)
 	vc->vc_need_wrap = 0;
 }
 
+#define UCS_ZWS		0x200b	/* Zero Width Space */
 #define UCS_VS16	0xfe0f	/* Variation Selector 16 */
 
 static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
@@ -2941,8 +2942,8 @@ static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 		/*
 		 * Let's merge this zero-width code point with the preceding
 		 * double-width code point by replacing the existing
-		 * whitespace padding. To do so we rewind one column and
-		 * pretend this has a width of 1.
+		 * zero-width space padding. To do so we rewind one column
+		 * and pretend this has a width of 1.
 		 * We give the legacy display the same initial space padding.
 		 */
 		vc_con_rewind(vc);
@@ -3065,7 +3066,11 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		tc = conv_uni_to_pc(vc, ' ');
 		if (tc < 0)
 			tc = ' ';
-		next_c = ' ';
+		/*
+		 * Store a zero-width space in the Unicode screen given that
+		 * the previous code point is semantically double width.
+		 */
+		next_c = UCS_ZWS;
 	}
 
 out:
-- 
2.49.0

