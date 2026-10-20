Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459698;
	b=o1qsoTBo9GnPH8eWBR+GCI2Qf9i9lV9g7VxD5fN5pT27bK1NyNbJBTYDxfDOgvyfoOhw
	 pipdL7hN4KsXcYt1QvGHVjQhAABB1HhMaRsNtS0pGVRjv8dyijteEiOZtEX5gmkS1bIjS
	 Jvbw0AkuqY17PCPuXd46rv7M6Tpi1oY7cunpYfofjHUkBzGNdBsWh8vY+tWqNQ+/4ECpR
	 rJyyNmCNAhGIkUtojxusv1iZSBpqf8t9iDULRDflX+BHZOeESvkRxl2rt7jQBCcfhPD1b
	 aIoaezpF/p6+IkzbIqU9HWcaugxXurwZHshemcwPjQb5p+K6KSa/Po1dh82eDtQf8VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459698;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5qUgLs+CjpBbZipOhT6HHA1szcA4CGwnixmqJCQRTuQ=;
	b=cIlgJ5osXNshyLCuFFRRF7Pq9x7z0UOteDRTd+YbeucmW7JCXkEIeI+HYZW6oH5VPh6u
	 niiD8Hrz7dp4fziSKMimkyEgIohD/u9sLN/vFIfWiIPBrT82QHPCaWoQq+H37kKz9js0Q
	 0Az5LIhRcCZ2aaS7AGHLPsnpp3D2BUgslzV3IBY8f9+UYOiNdoQMN2W/UjH0uSIJsPfJc
	 C+euDT+Dul6NjtJYpfTwvqfCIGDda+wAbbQAQJ/c3c0ifHLxebPtNZ8WyIidw8gwkzm5j
	 mZzOFiU727GxQkM7tFNT+N6R6OLgcOYSF/HgfzvsS9oc1yX5NLdW7rppmRslT4RDbfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nr5uW3Qt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE0D606A319;
	Tue, 20 Oct 2026 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nr5uW3Qt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3A01F000C5;
	Tue, 20 Oct 2026 01:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459698;
	bh=5qUgLs+CjpBbZipOhT6HHA1szcA4CGwnixmqJCQRTuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nr5uW3QtlmxoP4tox6wXnKraKe2Y/uT2upIvGqeVqRQNQurkI65qu2/74qwIj2tmm
	 FC6ADKO5hnjDmn9Exb23lD9oAJpVTaq2ahFErEs+UD+/yp7375unDeYqydoPlts/Cx
	 E+1wIPk/+SBcNYuCycNiLcKxDIMH9o1FjFjvOZ9hXb8APeuLO+JgmUir8FA8UsA7TX
	 Mhe+E96RWfYOoxFNLiBPHr3S3lcSz4pDRwoptJPdKG6v+oJNurZWikAWd6ju98SX7d
	 QIddXUrKr85C0TUkEnu/Z73Qbwcd2lRfqI74dpW5PZN6Yfzavn0d/p4y9vPfhZHd+/
	 yUMRCBoYlhWwg==
Date: Tue, 20 Oct 2026 09:08:08 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/20] dt-bindings: i3c: dw: support up to two reset lines
Message-ID: <ata--JFFUzSoMock@xhacker>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-5-jszhang@kernel.org>
 <80b084d130b7dc7406ae23e54a77706a4f42b606.camel@pengutronix.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80b084d130b7dc7406ae23e54a77706a4f42b606.camel@pengutronix.de>

On Mon, Oct 19, 2026 at 02:55:14PM +0200, Philipp Zabel wrote:
> On Di, 2026-09-29 at 14:14 +0800, Jisheng Zhang wrote:
> > The Synopsys DesignWare I3C master controller can have multiple reset
> > lines, such as core reset, apb reset, and dma reset.
> > 
> > Update the DT binding documentation to increase maxItems for the resets
> > property to 2.
> 
> The last sentence just listed three reset lines. Why increase to 2?

Per the doc, the last one is dma reset, currently dw I3C driver doesn't support dma.
And increasing it to 3 is still dt compatible. Maybe I misunderstood
something. what's more, I don't have platforms with all 3 resets to test and verify.

If dt maintainers prefer 3 in one step, I will sent out a follow-up patch.
