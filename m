Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5C1AED24;
	Wed, 14 Aug 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648911; cv=none; b=ltZ9VuRmEo9N3Evsj13qnNgvjyQs8ppcv7dNCkvEYprJPyAD8JzOGqQ8LAFlds4yJMf/9TCsu5bON0mYV62gyborhlfqSaHhSKkpU4MxISXmg79ce6zlXh+XECbmWej6L/U/jfvZbuZ0U2jRBuIbBh/z3qTTTx1hqM9SdGd/A2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648911; c=relaxed/simple;
	bh=l5CbK8lsNYXz7WLusbOjthn2e52Ss1865Pf1ASkxRN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuQdshXmYqHDAGfrAqUa9pY4j9EmLnVaioZ/xRv1sjgaEl7XWih1OZOmYY23TH6SuvkinDCXBWNwijCAYbzPAXhg9DouUTh/aFWrmtv4nBV6At/vXOe1vnpITKxuD3w9AchMYjGW1GgS5ubvgBJQeuKwYD/tQfefTv2eurj7qHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=22GQztV2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="22GQztV2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wWwr7zWATQuYFqeeYM1CqrF/gl5kEJAwbc6M3ZyF80g=; b=22GQztV2mfG2u0Gc3jzzQSpO65
	7VWKwbTO6qzTKqhrLh0IqCLyOlWjXl3mSnI+8B6yooUouFyQUKE/ZDwgwCOSw8rtfEyG9f79lRUaO
	owewVmJvWZ+S0wNt++i6JU9XJQdPMzhU2LZHSn7EaRy0nBccifQgaMjJIt/Mwc6aQD3g/E0qsM+pq
	ZYjg5gSRkHb38a/dNHs3CttvGLosNHUhYxJ2l/affw8kN7Oubw7nwTDDtCRF8D65TGYVaTCoCmnEk
	5YhH/gVdXEBa9dWqFRckrU1i9EO8DfVXAHJS7b73xvVPG4dq+Oq0BohGfL6hP7Cb1JJsnojyhvZyi
	w2HyhxTg==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seFoV-0004yv-7N; Wed, 14 Aug 2024 17:21:27 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
 Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>,
 Ondrej Jirman <megi@xff.cz>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Date: Wed, 14 Aug 2024 17:21:25 +0200
Message-ID: <2429972.SyXcmblsem@diego>
In-Reply-To: <6320e4f3-e737-4787-8a72-7bd314ba883c@kernel.org>
References:
 <20240803125510.4699-2-ziyao@disroot.org>
 <b967ab05-dd0e-4fc5-bee6-ad7639e47bfb@kernel.org>
 <6320e4f3-e737-4787-8a72-7bd314ba883c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 13. August 2024, 18:38:58 CEST schrieb Krzysztof Kozlowski:
> On 04/08/2024 16:05, Krzysztof Kozlowski wrote:
> > On 04/08/2024 15:20, Yao Zi wrote:
> >>>
> >>>> +		compatible = "fixed-clock";
> >>>> +		#clock-cells = <0>;
> >>>> +		clock-frequency = <24000000>;
> >>>> +		clock-output-names = "xin24m";
> >>>> +	};
> >>>> +
> >>>> +	gic: interrupt-controller@fed01000 {
> >>>
> >>> Why this all is outside of SoC?
> >>
> >> Just as Heiko says, device tree for all other Rockchip SoCs don't have
> >> a "soc" node. I didn't know why before but just follow the style.
> >>
> >> If you prefer add a soc node, I am willing to.
> > 
> > Surprising as usually we expect MMIO nodes being part of SoC to be under
> > soc@, but if that's Rockchip preference then fine.
> 
> One more comment, I forgot we actually have it documented long time ago:
> 
> https://elixir.bootlin.com/linux/v6.11-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L90

Thanks for finding that block.

I guess we'll follow that advice then and go with a soc node :-) .


Heiko


