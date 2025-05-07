Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D8289E16;
	Wed,  7 May 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627072; cv=none; b=MNf+TcYj8PdN2FivYbmYv7QkptPVC4pPhtMBGr/cxu65N/bzOVV3vS/fweKr0JtLNy3a1iKSSQuI2MVcEeRlAe9X7vZwoVqUi6xb5iR1o3h7v0ANBPnN8cflITqXjDLklcBc8UR9JXNwurf7uldQljjQL3lCdN7UAHs564YplVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627072; c=relaxed/simple;
	bh=z11Mdp9N+HQThG5kGtS7Ut5YZtwW6lqCgnekzmFLTSE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jW8wDN3IV9K9uN/4PG1rLOHp/krFgJ4tvccAqBQb5FzaZiESCmvg/ZQcbge5aG5nVTdF61CWJSbin8XGMz/xwxC1nkDx6liBekEpFP3cGiOrXoovzRILt1DyjR9hMz8lKLP2e2UdOO6Zbwi7jXw2dGKgMjAOdrFu0x/YGCkqLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=U45JcO5d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HSlVKmCf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="U45JcO5d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HSlVKmCf"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 090ED13801FA;
	Wed,  7 May 2025 10:11:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 07 May 2025 10:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746627070; x=1746713470; bh=ooJTaPOwar
	NV0/nPDHqrPx4hBeb38NYA1+SgywieEj0=; b=U45JcO5dy3z2Yst0ZaRYBWAWlr
	7iznkB8iAZn0YJuJA0L6Hhdu03/0FWgAMraHrO0OIjeDiKZEK/V+0FojUyEOKA+8
	lnA7P2aADBwHPsZDbt9heY0zLRnHy0rqJV05sVGMQnkSO9pLvrI4ebffOOpMztyG
	qYVS+rgioPRrWvX8CRw/2ez6fvDsTHGe1Bz0+d5lkq4CLpEhfUM8SJPACpzK9Cj4
	YZMvmXjig0e6ahHjSlXT3+4ZAA/VoV75pkt0B0mpOLI1bIEKVqzt0f5JgLf5hKtZ
	c0JKVkIEMS0iIZMagg1XxY09xPW+hCdVIHTJjguy78VXeZdmcecLvRb6PUvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746627070; x=1746713470; bh=ooJTaPOwarNV0/nPDHqrPx4hBeb38NYA1+S
	gywieEj0=; b=HSlVKmCfXv3+lfNSrxh/cHpa96ILdERPOetEVpeueS0xfTXjJ2V
	pxzCjkskNZP28TWmetZ3Si/sDvruH9v6f36NPCYlYbMBxSdQAhfcvkaCB2/+zCHp
	mzlEVvUskSSXyHJ7PN2BwNVCpi6Kjrb/Ckrgh+wK1r3BRZWGgEyrXXs1Fs9P9Pv8
	VNg17eoUdgSEBc2p+sneZjkPdEIoq+mlNkZhZuNioa2ZyHm02HTkNJfDLXb4KW27
	EeVTtV150vk14PVPc1AOUmEpv9E7+a2q7tY8PCP20FUZn46h3XkyF5kgivleVv4V
	CaFXE063SvIkih7yEqQJJTv8OeCBs65D32g==
X-ME-Sender: <xms:_WkbaIMEVoq45981r18kVUjfHUkIHVbyQbl8l40Xne6tObhKTA7AGQ>
    <xme:_WkbaO-5ZzkWkuaJhAr2mTsQJy-Lq0-QctXgGbQ22rQ67qnncVWYbO4dMh9st6UDD
    8irLGRzSB2fIT9zjmY>
X-ME-Received: <xmr:_WkbaPQ860MEJZ0YBCCnu_so-YpBS6t-9qcbORuMJ8SujYTcwC8LL9QXeM2Lv8YfbbvaCAs1OJgxXzB0EeWRfylcOXI1d6g8tbg3GD_FHWQTFdyJVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdej
    necuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrd
    hnvghtqeenucggtffrrghtthgvrhhnpeekveeftdfgkeejhfejleeigeffueehieetvdei
    fedvhfeluedtkedvgeeuieejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirhhishhlrggshieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_WkbaAuYv1FiXpH3eegdoFgkzZ1YLymt_aIljCpBDDG7F5cIgvYODA>
    <xmx:_WkbaAdjleGyXdt_jyVfWzdEtbfKJUNwjObt1Z6R2Eihh_mKGY9cQA>
    <xmx:_WkbaE0Q7iBm8GYvydInn156eEDDumySuvDspbRo5f1S65CkNYlLzw>
    <xmx:_WkbaE-wmyfO3IV65pHmBToIlrk54Cw8HEtevyJVf6Ok-1sbtSys4A>
    <xmx:_WkbaKwmqsOnzwOxBXqFlpSF2dtT53z60f2FDtBhlajBCs9JAGyorzui>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 10:11:09 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 004451189E7B;
	Wed, 07 May 2025 10:11:08 -0400 (EDT)
Date: Wed, 7 May 2025 10:11:08 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] vt: introduce gen_ucs_fallback_table.py to create
 ucs_fallback_table.h
In-Reply-To: <1a91b1b3-a8b8-4040-add6-857c8207b97c@kernel.org>
Message-ID: <pp270717-111q-8746-4r1o-2srp04r4roo7@syhkavp.arg>
References: <20250505170021.29944-1-nico@fluxnic.net> <20250505170021.29944-5-nico@fluxnic.net> <1a91b1b3-a8b8-4040-add6-857c8207b97c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-402983484-1746627069=:8235"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-402983484-1746627069=:8235
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 6 May 2025, Jiri Slaby wrote:

> On 05. 05. 25, 18:55, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > The generated table maps complex characters to their simpler fallback
> > forms for a terminal display when corresponding glyphs are unavailable.
> > This includes diacritics, symbols as well as many drawing characters.
> > Fallback characters aren't perfect replacements, obviously. But they are
> > still far more useful than a bunch of squared question marks.
> > 
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > ---
> >   drivers/tty/vt/gen_ucs_fallback_table.py | 882 +++++++++++++++++++++++
> >   1 file changed, 882 insertions(+)
> >   create mode 100755 drivers/tty/vt/gen_ucs_fallback_table.py
> > 
> > diff --git a/drivers/tty/vt/gen_ucs_fallback_table.py
> > b/drivers/tty/vt/gen_ucs_fallback_table.py
> > new file mode 100755
> > index 000000000000..cb4e75b454fe
> > --- /dev/null
> > +++ b/drivers/tty/vt/gen_ucs_fallback_table.py
> > @@ -0,0 +1,882 @@
> > +    fallback_map[0x00D9] = ord('U')  # Ù LATIN CAPITAL LETTER U WITH GRAVE
> > +    fallback_map[0x00DA] = ord('U')  # Ú LATIN CAPITAL LETTER U WITH ACUTE
> > +    fallback_map[0x00DB] = ord('U')  # Û LATIN CAPITAL LETTER U WITH CIRCUMFLEX
> > +    fallback_map[0x00DC] = ord('U')  # Ü LATIN CAPITAL LETTER U WITH DIAERESIS
> > +    fallback_map[0x00DD] = ord('Y')  # Ý LATIN CAPITAL LETTER Y WITH ACUTE
> 
> 
> So you are in fact doing iconv's utf-8 -> ascii//translit conversion. Does
> python not have an iconv lib?
> 
> > perl -e 'use Text::Iconv; print Text::Iconv->new("UTF8", 
> "ASCII//TRANSLIT")->convert("áąà"), "\n";'
> aaa
> 
> /me digging
> 
> Ah, unidecode:
> > python3 -c 'from unidecode import unidecode; print(unidecode("áąà"))'
> aaa
> 
> Perhaps use that instead of manual table?

Good idea! Go figure why I didn't think of that.

Some overrides are still needed but the script is much smaller now (and 
the table somewhat bigger though). 


Nicolas
---1463781375-402983484-1746627069=:8235--
