Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037B3DCD9D;
	Wed, 20 May 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287713; cv=none; b=o2gdcfhI+bxUFo22cFPJR5S/bxyvf2Z+qJGffK3RLH9DPdpsiy6LXFoP2697loFBo/z8qHmUUpqz9WJ/jo3TBMVsIOoi0HFT/CP2Za9imCdOUn2zltCJfobQsBmTc7nqstHS+LTtDCrjPXzflV9uPEt4YrYTt8Y0mfnajlq1avI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287713; c=relaxed/simple;
	bh=63v6cpuRQwUFXBs/cUocRj34eOhxpQqUuXS9mMmcMXQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KOTaSQRO4nKNIa4qNmEOcFgtn3hXkAqaf74/04i03ltKPpp1wqhYHBeCEToweVtqN4+wuXou1AgGKW1zJSYYXEZWY/ytilhFxjZIWXb27Z/JdW9aJjXDYAji/rKsS0Q+kPh90uhvtiEtGo3jQF/UVtYSSKElkMlxnrWDIpy6HUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SzbSQyWb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fsDhG+tg; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SzbSQyWb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fsDhG+tg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F1951D00091;
	Wed, 20 May 2026 10:35:10 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 20 May 2026 10:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779287710;
	 x=1779374110; bh=LnpAmZ6bMYRdyEj0MOag9MwLoPP/jDce+rJApqJ/WLc=; b=
	SzbSQyWbAn6o0pgDfwy6Pr8TggkssLaB+RUOJPzy7HEkwNNlHr8jEOZn5TgdKyhf
	CjzSHtR7pwI2aoYNBC0CVlEX0eYxLmRZGaIpNVHlssgbFF+pbFpl1juk/fOdHr7D
	h899KP6wtzvC6GZEBWxvsTjgybqhHOq7oepaGhQStsI/H2Mr8li5z8DD2+zwX6Ue
	npY6RlkanLcZuf40O55M32itGnP/53a6lKbQsWO42bTvjNAuor5u+tOYeM3pbMXC
	c6bK7hQq9zc518KuS4O0zgI0TQCEgeHndiE3saH7sNe1N3IM3fEpn7bUDNUnr1Ef
	OUniPC4cv24svHhOCKjg0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779287710; x=
	1779374110; bh=LnpAmZ6bMYRdyEj0MOag9MwLoPP/jDce+rJApqJ/WLc=; b=f
	sDhG+tgp5A/tDIbRpbkbi2OFXOLcPg4gLX5G68OlsPWPo8OazOV/NncCvyqIkUFo
	oRoV66L4eg+qjaokHX+apeckXI63yiNwHxTzacQR5LKNvTHBAD2jS6HMyovKxDl/
	6q8jsaVAVRc1qvjQrlMzs7ZcqlL7rZoBPSjjdOK7k0YUADQRdDFuWX/pANnPNsfx
	cEz0PRYUF2wv4Vz0zaG2em7t8SfcbbpCo9KiA4Y70lwDei1ZLGWk/x/WAPCt9FES
	nSO2jmI7cVW3jd9GN9dAwvgTZlWEhXzeddBynSwh8uYze1VDwzvB/PzPcjclhV04
	eGG/v0sAvLoTIzUiE4Eog==
X-ME-Sender: <xms:ncYNaisWPQh2SBukckYvTBT2W_rnAMOx7HM0gw5k1sWUUlFiqMhSbQ>
    <xme:ncYNaiTmH_kKTFJQIjU8FGarxbFquwQkDBTj8rUasHFXOOGoiyGubPYUwM7ZVirux
    Dr2Q8HZ3R1gTSNOeKsDZJDGGg6B5gI5LYPIVevCi9vhPt0PftDskS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohephhhvihhllhgvnhgvuhhvvgesughimhhonhhofhhfrdgtohhmpdhrtg
    hpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthho
    pehhuhhgoheshhhughhovhhilhdrtghomhdprhgtphhtthhopehrughunhhlrghpsehinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ncYNao-zk8GYKzR-gxGR6_XhMRJFgA-SG3AZhRNUVUYP0GNht2IQ7g>
    <xmx:ncYNahKkq7oJKVqmT-OiefqJkY6H2WLUXKDohP5DWToM1J4kV77jkA>
    <xmx:ncYNausDHFZsYpQH7-zWz8hyMgJjvF-8UnrM7S2WZf6IJ5SnIDhsNw>
    <xmx:ncYNagC04rODsfpoGT11wWh9dsCG9HBUqcHs3RoCuEjAXV-v2YBQog>
    <xmx:nsYNarmqdKGBXdi7LO7O5KzKH2Pg0tKs8YbEsA8DnsM7AKSTdVkvOhnw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BA6481820082; Wed, 20 May 2026 10:35:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5CWzjrYWKeN
Date: Wed, 20 May 2026 16:34:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hugo Villeneuve" <hugo@hugovil.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Message-Id: <8f164a0b-9366-44a9-80ee-bfb6c91807b0@app.fastmail.com>
In-Reply-To: <20260520100457.0df23fe2d1c16fbb848a3de1@hugovil.com>
References: <20260519203506.1341241-1-arnd@kernel.org>
 <20260519171437.ff11a24d84c9ac8092348baf@hugovil.com>
 <8478838f-3821-44ea-b281-c890441b9a12@app.fastmail.com>
 <20260520100457.0df23fe2d1c16fbb848a3de1@hugovil.com>
Subject: Re: [PATCH] serial: max310x: fix I2C-only build
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, May 20, 2026, at 16:04, Hugo Villeneuve wrote:
> On Wed, 20 May 2026 08:47:05 +0200
> "Arnd Bergmann" <arnd@arndb.de> wrote:
>> >> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> >> index 811250bbbd39..b9b40e80ea81 100644
>> >> --- a/drivers/tty/serial/Kconfig
>> >> +++ b/drivers/tty/serial/Kconfig
>> >> @@ -323,6 +323,7 @@ config SERIAL_MAX3100
>> >>  config SERIAL_MAX310X
>> >>      tristate "MAX310X support"
>> >>      depends on SPI_MASTER || I2C
>> >> +    depends on I2C || !I2C
>> >>      select SERIAL_CORE
>> >>      select REGMAP_SPI if SPI_MASTER
>> >>      select REGMAP_I2C if I2C
>> 
>> This is still required to avoid a link failure with
>> SERIAL_MAX310X=y and I2C=m. Do you want to include this in
>> a v3 of your patch, or should I send this separately?
>
> If I2C=m, i cannot select SERIAL_MAX310X=y, it is automatically set (or
> reset) to "m", even if I manually force it to "y", do you have the same
> behavior?

The problem happens only when SPI_MASTER=y, in which case the
current logic does allow SERIAL_MAX310X=y. When SPI_MASTER is
disabled, it works correctly as you describe.

> Before i converted the sc16is7xx driver to split i2c/spi, it was done
> like this:
>
>   depends on (SPI_MASTER && !I2C) || I2C
>
> Based on what we agree on, I will include it in V3...

Right, the '(SPI_MASTER && !I2C) || I2C' expression is equivalent
to what I suggested. I picked the syntax that I find easier to
understand, but I'm fine with that as well.

       Arnd
