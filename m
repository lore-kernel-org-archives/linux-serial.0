Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5E1EB27;
	Sun,  4 Aug 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722775803; cv=none; b=AHhEn5ilQ4VKGLEOQbc8VHegKbVqv0bHs5GdpuXGQfZj+llceW17QPaJgL6yDnRzCqo5F7zWifzQ13QZ7EC2nbRoqkzHALVFZxFWwjrUJMZO2fZtDjxWz+m7mI0gLYyKV55x3RNfMkV1UEdg2S20Nr2iBlOcIepwlTM8XMZa23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722775803; c=relaxed/simple;
	bh=m2UOwOthI9uh4DkJKz10xC9fCuZKNFvcONy4yFh9SDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbX2DVMHDz1TdC57Sz/U8MpaDFy9EU+R8tfNN4Dch1rcGAT53VHByRjkZnHNqTb8ipW/6mXCugIT/oUwTX50irmmUEibR7V8k3E5EdrT54hrxzCOYGMOOKYkabGXOEakfXaVZHxVlzpzhbc8UMe2VGUq7CVY3xCHD45KEufymM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1saafy-0008En-TS; Sun, 04 Aug 2024 14:49:30 +0200
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
Date: Sun, 04 Aug 2024 14:49:28 +0200
Message-ID: <10507028.U7f9L36N0a@diego>
In-Reply-To: <56bd1478-ce8c-4c1d-ab16-afe4ad462bf5@kernel.org>
References:
 <20240803125510.4699-2-ziyao@disroot.org>
 <20240803125510.4699-5-ziyao@disroot.org>
 <56bd1478-ce8c-4c1d-ab16-afe4ad462bf5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Krzysztof,

Am Sonntag, 4. August 2024, 12:05:11 CEST schrieb Krzysztof Kozlowski:
> On 03/08/2024 14:55, Yao Zi wrote:
> > This initial device tree describes CPU, interrupts and UART on the chip
> > and is able to boot into basic kernel with only UART. Cache information
> > is omitted for now as there is no precise documentation. Support for
> > other features will be added later.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---

> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <24000000>;
> > +		clock-output-names = "xin24m";
> > +	};
> > +
> > +	gic: interrupt-controller@fed01000 {
> 
> Why this all is outside of SoC?

I guess you mean outside of a "soc {}" node?

Here the rk3528 simply follows all other Rockchip SoCs :-) .

Digging into the history, the first rk3066a and initial rk3288 submission
did use a soc {} node, which later got removed as suggested by arm-soc
maintainers at the time [0].

I guess that changed since then?


Heiko


[0] https://lore.kernel.org/linux-arm-kernel/20140716005528.GA26207@quad.lixom.net/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3030d30d9c99c057b5ddfa289cffa637a2775f5


