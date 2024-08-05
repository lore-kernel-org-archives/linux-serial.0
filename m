Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391C6A01E;
	Mon,  5 Aug 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858489; cv=none; b=tPhCG5h8cZ9SDbuwtWKukr6mBfdiY7nfcVWGYhBvz499vOrLIZJaxDtCQMSNuRNf9Q3MwEZE8kcTzc7Z5HOtkWiUBXYJWQyAIsSu8z9Nm5h33l9htXOnQHr6DXgrGvdCfNZyPLK6c1XqhK6vby7MFR9Yvpo+OqgcvM+nZNl03pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858489; c=relaxed/simple;
	bh=xWUzpUed0WtFaOwTnrWGivckLFH1J0Q2Ufzdyr5VCps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5GrJVgS9xNBnt1B3kwQeZS61nrnMJRg6UJKmArgNDTdLDnZooS5nfXOYNOPshCcWIfBrOf38sHPLiuRyaQneP2o7p6rwv1pNlHD5ED+DySpREeu9L2njdkaT4yoE9fvLCZDOaOUtIka6La4afGneWNmVPBw5EcKXo5kLLCwK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sawBm-0001Hv-Lc; Mon, 05 Aug 2024 13:47:46 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Yao Zi <ziyao@disroot.org>, Dragan Simic <dsimic@manjaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
 Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman <megi@xff.cz>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Date: Mon, 05 Aug 2024 13:47:45 +0200
Message-ID: <7941737.iedYuu7f5S@diego>
In-Reply-To: <82e7e3a78f784b3ad63094c8a0ab1932@manjaro.org>
References:
 <20240803125510.4699-2-ziyao@disroot.org>
 <ZrCwrWjRgvE0RS98@ziyaolaptop.my.domain>
 <82e7e3a78f784b3ad63094c8a0ab1932@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 5. August 2024, 13:37:11 CEST schrieb Dragan Simic:
> On 2024-08-05 12:59, Yao Zi wrote:
> > On Sun, Aug 04, 2024 at 04:05:24PM +0200, Krzysztof Kozlowski wrote:
> >> On 04/08/2024 15:20, Yao Zi wrote:
> >> >>
> >> >>> +		compatible = "fixed-clock";
> >> >>> +		#clock-cells = <0>;
> >> >>> +		clock-frequency = <24000000>;
> >> >>> +		clock-output-names = "xin24m";
> >> >>> +	};
> >> >>> +
> >> >>> +	gic: interrupt-controller@fed01000 {
> >> >>
> >> >> Why this all is outside of SoC?
> >> >
> >> > Just as Heiko says, device tree for all other Rockchip SoCs don't have
> >> > a "soc" node. I didn't know why before but just follow the style.
> >> >
> >> > If you prefer add a soc node, I am willing to.
> >> 
> >> Surprising as usually we expect MMIO nodes being part of SoC to be 
> >> under
> >> soc@, but if that's Rockchip preference then fine.
> >> 
> > 
> > Okay, then I would leave it as is.
> > 
> > For the fixed-clock node, I think "xin24m: clock-24m { }" is okay and
> > follows the new rule?
> 
> I find "xin24m: clock-xin24m { }" better, because keeping the "xin24m"
> part in /sys listing(s), for example, can only be helpful.

I would second that :-) . Like on a number of boards we have for example
125MHz gmac clock generators ... with 2 gmacs, there are 2 of them.

I'm not sure the preferred name accounts for that?

Similarly we also keep the naming in the regulator node,
it's regulator-vcc3v3-somename {} instead of just regulator-3v3 {}.



