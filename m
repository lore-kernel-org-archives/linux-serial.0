Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC51E5206;
	Thu, 10 Apr 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313899; cv=none; b=nb/4d3I/Z8nLFGtXVhof6VbJNTvn36jjeudimv+wLX3JFDFFxC4/Low+H9lO5Fu5MSCHn4+HGeulwlSg17n1xeKBjn+Go4ocTpUbWZoNPD0t6jDesRMv6oWHmZAmq0MH5K9eG8ML+RWRLnqrfCvcRfxJwNwseGOg87udYRg8QBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313899; c=relaxed/simple;
	bh=GvnGRvIkZRasWUD1RFkAElt1RcGj5qgfsOegZr2uSmE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kVultGfpqtp2UBF2i/nUNeUTumyR59LfF4ZaNaGat9PJEnGjXtMoZaObJRW6qYSoNBu6bJ+GzK5u63oKJo+cibhfw1nDfa+DmaT0zRjueGzokni9vdRTh9g8Z7TJYRgZ536HTOhJozhZ4LuaSsAeRT6STRjAVQ4X3dT4kENx9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=bBg0dh1Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xc1heRjr; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="bBg0dh1Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xc1heRjr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 762E911400D8;
	Thu, 10 Apr 2025 15:38:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 10 Apr 2025 15:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744313895; x=1744400295; bh=Br48fJmS9v
	Auob4t1uWv3/F/2XSGgECcK3NoQZM6ImA=; b=bBg0dh1QZdlPax9wets0Nv20AQ
	wIr+4gX9T2awVw7/GjO6lPyjMB5Spn9TB6Yl255iagrYWFIEPHGgjUj415OzBabK
	+Op2f73YeL1TEbZ8RGiTa8NtTRB4usR0G/S+3Q6ZrITPXMN1DrihGPzxuC1itu+N
	PZKiaVGsnucSIiShX9s3hJFIAmqd+x8BkqmSSCc06fr3LW4dMclUfi8SMNTpwBkX
	f8E0xNYXm0ITmaWdhV4v3HLKr6MxGxYExoXzHUgVN5j4SUAHXiVgBgHAONiPD8WE
	9IwwVFyJXrrr/lG+0E5q5NV/YMESNl+dFZNLIeASdUM9VFTR7mYGWbYUWtsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744313895; x=1744400295; bh=Br48fJmS9vAuob4t1uWv3/F/2XSGgECcK3N
	oQZM6ImA=; b=Xc1heRjrg61lw53vEb2ZF7MNVXcb5WZ8aXNXJbJx4LITtomEGxm
	5PlrKaQddo1tKcUIRrklaM4j3t0sfydfeSHXoBD+gg2yEwQ0uPAVf5R0bYf2+w6S
	Ww5zmoTiMbEfaYnLvMJTARhPfzRUg6kHDpUthbyUJsbXKark+kQa0YPzD4k45j5I
	MaaDEpTCJr3Br9zxaJa4lzyM/rMupzBbo5zg27Rcye2WK8L32DX6nEAbB7EIuYcx
	zKd+8YMu4u84hwb7D1pU076J7UmHRl8yLIgIHZncrgd8jrugwm1QuvYhb06TR7Iz
	7luz+WlLh47JU1fmuI3dO6pEFy2dIFAVFhg==
X-ME-Sender: <xms:Jh74Z653nbzDDwibUw348Sg2TGOHxQqXOlmoAoLPwbJyv8TJffkG8w>
    <xme:Jh74Zz5l8Ehg6uRgmLuqjqD5T6HIddkKyfZZva1SAph6mgSHMoGxUKzei7iZL6r09
    s7Ut8rYJryXokuTFr8>
X-ME-Received: <xmr:Jh74Z5cn2Rn3PuJSu4TzfWYme9YQbILfA9fs4A4e5h_PrNt1Mb06Zr_jD_k7uUVPW5WJFn-yr2Jen0gB_qyPgLMihCNC-muehaKh72M4mxfN5iz9xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrd
    hnvghtqeenucggtffrrghtthgvrhhnpefgvedvhfefueejgefggfefhfelffeiieduvdeh
    ffduheduffekkefhgeffhfefveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthht
    ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhpihhtrhgvsegsrgihlh
    hisghrvgdrtghomhdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopegurghvvgesmhhivghlkhgvrdgttgdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Jh74Z3LxHtErxjms7fTK7ZWR_k8SBt6Ja5Dsj8mEtevYXNhKBaDHtw>
    <xmx:Jh74Z-L9dISpwmtUmq8bm9HiKyJdx9ICHqaQzFVofboJFCkaTqGlEA>
    <xmx:Jh74Z4zBJwswIU97Pnd6o0mmNos6LgXFm5v5amop0dibWRK7S8UmSA>
    <xmx:Jh74ZyLCfr-0Pr1d0J-Bw1BLTUb15yrfecsTPE7r1bK6VlaebU5P2g>
    <xmx:Jx74Z_K8dRNkL9yCmrWLUVqUxqD8-_4vGg3vf8KbQ_bm495BexQGBiQA>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 15:38:14 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 0B62D10DB8BC;
	Thu, 10 Apr 2025 15:38:14 -0400 (EDT)
Date: Thu, 10 Apr 2025 15:38:13 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: Nicolas Pitre <npitre@baylibre.com>, Dave Mielke <Dave@mielke.cc>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/11] vt: remove zero-white-space handling from
 conv_uni_to_pc()
In-Reply-To: <20250410011839.64418-1-nico@fluxnic.net>
Message-ID: <6o2ss437-6nps-s943-1n38-54np5587r08s@syhkavp.arg>
References: <20250410011839.64418-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From: Nicolas Pitre <npitre@baylibre.com>

This is now taken care of by ucs_is_zero_width(). And in the case where
we do want a padding from some zero-width code point then we should also
give the legacy displays a space character to work with.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---

This is a fix for a small issue discovered during everyday usage.
I didn't think it is worth resending the whole series for this but
if you prefer otherwise please let me know.

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 82d70083fe..bb4bb272eb 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -870,8 +870,6 @@ int conv_uni_to_pc(struct vc_data *conp, long ucs)
 		return -4;		/* Not found */
 	else if (ucs < 0x20)
 		return -1;		/* Not a printable character */
-	else if (ucs == 0xfeff || (ucs >= 0x200b && ucs <= 0x200f))
-		return -2;			/* Zero-width space */
 	/*
 	 * UNI_DIRECT_BASE indicates the start of the region in the User Zone
 	 * which always has a 1:1 mapping to the currently loaded font.  The
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index dc84f9c6b7..0d1d663c78 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2964,13 +2964,15 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 					goto out;
 				}
 			}
+			/* padding for the legacy display like done below */
+			tc = ' ';
 		}
 	}
 
 	/* Now try to find out how to display it */
 	tc = conv_uni_to_pc(vc, tc);
 	if (tc & ~charmask) {
-		if (tc == -1 || tc == -2)
+		if (tc == -1)
 			return -1; /* nothing to display */
 
 		/* Glyph not found */
