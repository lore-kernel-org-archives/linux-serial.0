Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051446;
	b=uJy74Jq2/2sX1cGFaUyMt01hXf0ahlfHbZbGVU2PlVgQVBygpyQJmJsd1uAVx7fncESg
	 uyLUXmWTP1r2ot3rbuWY4j1GeHJIaKKxTj95Pwp6WkqjS2bbDjueFKIVqF16TgLMZHYYB
	 d27v5MB8FzK50FM4edWcl4WW23thVF8yqkIs7aAMs7b8Q+BSapi8Y33MYL8Nz58rR+WrU
	 RnxGlOvJe+T8R/emzw+y+1Lp+YJHKVGMOakWynDG54ruNEGExpu2ymLFFR6IjO+7PLt0t
	 Apgtx8ifoM+EZhG7tN/LguQBtrQpwcs8nJgpCywM6LR+Mjb8RweQckOGm1dlu+ZuARg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051446;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AXVCbgunRdxiEzfKOtZOu4w7+1IOuyahlSkNVvnhSu0=;
	b=GBEhHXeE7iw3vcEjgRWFbAkdH801NTwgHchj9DaFVHtYDbgyPar4ginMBFmAjuZTjeqI
	 Rs/dp6c6HFnrojqKJrlpkSwXTOJtyB5HGiylqO02u3Ggr7MtCQ+F2fqNfJEaEikGop1iv
	 6Ei5qqhWWxshC2fOcEGZqfL3SEgVa/T+ArVegbiYZ/7SAupFvFVHtmKj/5lmsTzxHriQI
	 73wMyXSvsi4gB9x5g6jJbmEdJt08J/7lVv3wnQ4awPZTN6rLH+EkmeTXB4oaRC/u3XvLX
	 xdF44wxmSZoAMdYktwsHh/WFazKEm1FctiyNfQHv4+Iob1cFK9PEQ94mv2xsB5CSvZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuMJQh8j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF347606A31A;
	Mon, 26 Oct 2026 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuMJQh8j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BB21F01829;
	Mon, 26 Oct 2026 21:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793051445;
	bh=AXVCbgunRdxiEzfKOtZOu4w7+1IOuyahlSkNVvnhSu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EuMJQh8jrNFztkuD9QGjD9IOj3BqpOWIn4ZLfMqp0axPNgGHyX6ygQBg11SPqk2IN
	 HPpQpYKB9+oaLHcz/oXyjCaNY/7hG0ZrJ7RhnLWY1M3m7uF/wvlXeTTOa+nz/Lb/68
	 EqHJRl1eKye9fjZVphj+G2J1xF/2dnWT4BTuM1rwaxZ75GvqRZZtn7HXLGL38zXl/d
	 eRARHpowxT6oVh+EW6FqS6FtOIxH+Qq82wApQZSpsyGER4BTVjuMClPmJ3TRjB9H2a
	 QwlkvEHU+j1hC0glM0B8FDVcr6yiBS6VWlhyoKrh4l+Rea7bTqqgxeUDqGiyT+LrT+
	 cK/TSg7YtXRYw==
Date: Mon, 26 Oct 2026 16:50:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-serial@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, mfd@lists.linux.dev,
	Brian Masney <bmasney+clk@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	Lee Jones <lee@kernel.org>, linux-i3c@lists.infradead.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 19/20] dt-bindings: arm: berlin: Add Synaptics SL261X SoC
 and RDK board
Message-ID: <179305144215.3880355.17021264203914650157.robh@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-20-jszhang@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929061417.20733-20-jszhang@kernel.org>


On Tue, 29 Sep 2026 14:14:16 +0800, Jisheng Zhang wrote:
> Add devicetree binding for the Synaptics SL261X SoCs and corresponding
> RDK boards.
> 
> The SL261X include five pin-to-pin compatible SoCs: SL2611, SL2613,
> SL2615, SL2617, and SL2619.
> 
> The corresponding RDK boards are based on the these SoCs.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/arm/marvell,berlin.yaml          | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

