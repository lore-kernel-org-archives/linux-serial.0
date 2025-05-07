Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899F28C2A4;
	Wed,  7 May 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627346; cv=none; b=rVdnlGBp+NIPe1kfGDVy0vicM8nrEb7JVjv5pJqP3t92+B6K7aJaVc2mGLPItBLlp7P0aqzqGgGvOek8mMPfKgkMmcY+LK+/+rvPTSwqHc+Y/ZO7BRTamSbrf9t+c3g30UQPQ7ZoJJedAKvevKyAxf/ZTRKaMtXkzKw6gNnksDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627346; c=relaxed/simple;
	bh=S7SXRTnFDCjSU0U05F3Howgrj1G4G/jH6owD5rbtlt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5fEL4nSrvXJdBWr4AeYZZGzfMwdUcItnaqxBzKahxg2UDB8sfqSdJNfnZAY4KFCRHHXqZhqZ5Vv7zRxjR3JZAK2lKV3f+Lk2Aa2JEO09woekYUWQr2F419V8F3h1Huhtb8xOwmBTgBysaCM590g3IFu4mW8ZxC/XsbQeoEpgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=IeRakCSf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vx7hBlSo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="IeRakCSf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vx7hBlSo"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B0F41380198;
	Wed,  7 May 2025 10:15:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 10:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746627343;
	 x=1746713743; bh=+mu/xP/jUk/B+C0pa+jBE0T8JfANG0biKNJEPwnpkI0=; b=
	IeRakCSfWCYSAsjt3bgwO+gXmKvKToYoXDykHE/QXcLILwFI2zQsTw1GSBbjewy0
	S2STjr0Eevbpj8bJi3q6RmWgQjAO51gAhzy0D5YI1uSvKI661m0bvqZj68ONmZIH
	UlHlTmAJAuFzNxUBSu/nJimyJsa37as59SSpNuv2rIhKllCrBDvdmLd8IVu4EYMY
	QH3lhagxTy0MnSNP/+IEeSIh+JnScnZMIC1v/AGxLzo1/uBs8jIBIeuGU7HPDxS7
	v8N1lWD1xZJg+s0TNtsl/f2T7v9KwgrgqmHpy6nZw3nAuL8fFx42oljXHBdeVKQ9
	uw8i5BujOVu31QdBPgn5DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746627343; x=
	1746713743; bh=+mu/xP/jUk/B+C0pa+jBE0T8JfANG0biKNJEPwnpkI0=; b=v
	x7hBlSohzBX+My1kNEzJ2McR9CbEosUwVutwTsz64v5RP4udRz0JR7cucMWRi6W8
	P68Yrse65y1na8GN8vyfwPrMP7lLMBexoaKX7HhUn8qN/o2EKmLSxyttTK5/Ha3A
	uR29JTMXFsde6hABhJk1Dspb/dKTsRW76h4UNVIA82DmUnBzM6BaUY/b+AbW6K4+
	qe6HdtxNdtX4O/O/+te+Ww72y0E1HWEJ5gVIq6E9DFKuJu5KWCJ/B2wV2NwyO7/M
	5uddMPeryzOd0OgMhKqQOgSERuSdKlV0zOP85rHTWtsIB+I3xjIpYUQgUsrVfGfi
	6rGm+4jmTkVkm0gXJK8+Q==
X-ME-Sender: <xms:D2sbaDxbYo76ZiQaLOLGUd-uzFsRweZSJMLUb7Z26Ba20bGgDlC0uw>
    <xme:D2sbaLTcHml4ZUxWDq-GCNJa_z8XyiFP6frwAH-tbD4F7bm2kKEnsOp17M1N5wTsB
    6J5sVluY_yDAJFJ2tE>
X-ME-Received: <xmr:D2sbaNUIvgFP44VqYpR0CSIjsmYeX2fFwrV6ISn8nsAaMweNdNxJ97J9oiLlNZqMxumQquvWUSrhm6QOYDXRC7Zofr5iB0qofKIhFag3RqfvP6aE5A>
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
X-ME-Proxy: <xmx:D2sbaNiMGJkffCQVh5uwysI6Ssggzr3PrewdbFJcjAV1L3fE9PesjA>
    <xmx:D2sbaFDMYaFUkam8QP-ksoeBRppVpDpIW6KmdkyayifIlg7gN6xS9w>
    <xmx:D2sbaGJ62s5NkwxqELH7UXDLRcRQ0HVDVffXcNgkqiUI8TIF2n9OjA>
    <xmx:D2sbaEC5752vCXp3Ngo7dLxOscFEFLlmeeZ4rIkSnmVDaTQFAdjPUw>
    <xmx:D2sbaKz8pVGZsV5E93DY_n39c0Hs4seOVa4gJ7nSyZJAJj-dXuUl2WNf>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 10:15:43 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8B7291189EA9;
	Wed, 07 May 2025 10:15:42 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] vt: make use of ucs_get_fallback() when glyph is unavailable
Date: Wed,  7 May 2025 10:13:22 -0400
Message-ID: <20250507141535.40655-8-nico@fluxnic.net>
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
index 556af82a9231..efb761454166 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3007,6 +3007,19 @@ static int vc_get_glyph(struct vc_data *vc, int tc)
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

