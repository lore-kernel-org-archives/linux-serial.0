Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A961547DC;
	Mon,  5 Aug 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874988; cv=none; b=XGHbewDfrZTrPpJE6xZNANwwz/4Rj3jclzFkBWzJdR+Kt38TIIb2oRzKi19F+VEPe+SV8FS8GArPy8nKy4YLK5V7ZaWXYcmlxARDeq2kLVSwfTYmttHICvNR0FxR95wP1JX2Ih3zv6j1KCcKP0/bzCHCFaW6SacSUgxtM/7lnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874988; c=relaxed/simple;
	bh=6qIlI/ZA8suC3l92XJ5goqxx350QpUDQOkwCZyfLITo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR6clozPMZm++qyy8txbsUaZiBXMMv0tMx70OWi0pOFdzTnX2MDiXKSkBYYFALf9YyVO7dPLoUSEHlOcSeoPV4iwBj9ttshIor/StqUgoCZ5OX9srOQY2LjRazSNpe3Y5SMw13edoVmxVFUfawSboSA4kbGKZDLvqipmvF2z0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=UelkwFNf; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="UelkwFNf"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9CCCD40C91;
	Mon,  5 Aug 2024 18:22:57 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qDXlvlnU29eC; Mon,  5 Aug 2024 18:22:56 +0200 (CEST)
Date: Tue, 6 Aug 2024 00:22:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722874976; bh=6qIlI/ZA8suC3l92XJ5goqxx350QpUDQOkwCZyfLITo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UelkwFNfMZ5qaYl1Ax+fpc0ktTmc1h+H2/PvIEsUSB33ul2dVsoBrgWw2kfifxk+a
	 ZNapY89XNiZFMyDuB/iJ/gOr53fmVm9WUJHtok7zl6dq8rSaDkqXgUYv4W0OcXfL2J
	 L+gEybNbuYS0834qzBjTRxbXwSJdh8gSYVCcvfPSF2lHxU/Cl0fployJ+Ij2CXfzz/
	 AUryQu2DN3o+Rq72zca20Fb2wP9QH1ZnPpCRME8Srt0maxdrvD3/uEDhIR5knSprg8
	 WAwyvBfOIME16f7syGH7kCclq/Qb4xNSYQ1hIfjq33TEOzZWnhQcoWCT+2g0GZ/Gta
	 Odf00auRkCe/g==
From: Yao Zi <ziyao@disroot.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Message-ID: <ZrD8N7_tYAiKCg-C@ziyaolaptop.my.domain>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <ZrCwrWjRgvE0RS98@ziyaolaptop.my.domain>
 <82e7e3a78f784b3ad63094c8a0ab1932@manjaro.org>
 <7941737.iedYuu7f5S@diego>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7941737.iedYuu7f5S@diego>

On Mon, Aug 05, 2024 at 01:47:45PM +0200, Heiko Stübner wrote:
> Am Montag, 5. August 2024, 13:37:11 CEST schrieb Dragan Simic:
> > On 2024-08-05 12:59, Yao Zi wrote:
> > > On Sun, Aug 04, 2024 at 04:05:24PM +0200, Krzysztof Kozlowski wrote:
> > >> On 04/08/2024 15:20, Yao Zi wrote:
> > >> >>
> > >> >>> +		compatible = "fixed-clock";
> > >> >>> +		#clock-cells = <0>;
> > >> >>> +		clock-frequency = <24000000>;
> > >> >>> +		clock-output-names = "xin24m";
> > >> >>> +	};
> > >> >>> +
> > >> >>> +	gic: interrupt-controller@fed01000 {
> > >> >>
> > >> >> Why this all is outside of SoC?
> > >> >
> > >> > Just as Heiko says, device tree for all other Rockchip SoCs don't have
> > >> > a "soc" node. I didn't know why before but just follow the style.
> > >> >
> > >> > If you prefer add a soc node, I am willing to.
> > >> 
> > >> Surprising as usually we expect MMIO nodes being part of SoC to be 
> > >> under
> > >> soc@, but if that's Rockchip preference then fine.
> > >> 
> > > 
> > > Okay, then I would leave it as is.
> > > 
> > > For the fixed-clock node, I think "xin24m: clock-24m { }" is okay and
> > > follows the new rule?
> > 
> > I find "xin24m: clock-xin24m { }" better, because keeping the "xin24m"
> > part in /sys listing(s), for example, can only be helpful.
> 
> I would second that :-) . Like on a number of boards we have for example
> 125MHz gmac clock generators ... with 2 gmacs, there are 2 of them.
> 
> I'm not sure the preferred name accounts for that?
> 
> Similarly we also keep the naming in the regulator node,
> it's regulator-vcc3v3-somename {} instead of just regulator-3v3 {}.
> 

"clock-xin24m" wouldn't be more descriptive than "clock-24m" and there
are usually only a few fixed clocks in dt, thus finding corresponding
definition isn't a problem I think.

For the gmac case, Krzysztof, do you think something like
"clock-125m-gmac1" is acceptable, just like what has been done for
regulators?

Best regards,
Yao Zi
