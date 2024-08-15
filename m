Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD291714BB;
	Thu, 15 Aug 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740296; cv=none; b=hnRb7oIOTM4CcyTVabmPu6L4lNIPIJmTFJJJj+xiAZTxSm2HIU/9/zmlHA9kFpdqYuRtB3UIVKM7n/onjnKW4jssrnEXn0zeuaPzWAqThbWhIodDpOOkp6XFmEtrxvvRtHfR81PcFIKCW1VcaUVMKN7fFBYOVw3t3YSMvMq3ZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740296; c=relaxed/simple;
	bh=Vk2v87mT8X6xfcazuD8cmWUhNBpB4W5IzOeh5rkcGak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osWghKot6n8dAcGqoWI0Bo/YJEwqfWZNtiQnsT5py6g/s6qgtssqvbB1bVhhpm2QAiMV4O5jiIlClBfWSAefu1/ispnN+WsI7R7QNF37/QaNn175rIxVWKJ4GZHSlb0wUHvRWyGmWOTl0ix0RrCabf1uvPBXCXJVu95ovZUbvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=L/X8ZNhz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="L/X8ZNhz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O/AN0hyG3LGc7JIYcAxYKaWwQIKmaBs8HS6fRiUxTG0=; b=L/X8ZNhzTUSQ5vGLG/6LpS5m7S
	6m+BfWP9NusJN88xdz6lVLmegCxgtQ3Prr+jAoUSBq9ITJcn2IYNP9/YEbBoV5AjZlyycJPiif362
	/m1JsZex/hm1Y5/NziwRt0ITlstaqVjZl+xhao55KtALelqA2ZCE4Dm0qt1SnQAjwd6Hczmy4hDN4
	rGMPUwoMFSz1GIx9WfX+Lz9s+5X/+41YHAmcWdijqPHP44y4HLsluI0O7ariH/MN6QF9PNAJDkteY
	VYK+dW1rShG6HfsnwzVPK7zcfC9b0e0u7n9DE/KGgEIp9msAEDra4wRiCBBmmrQbdWNsQ7SNgLwQ1
	MyN8uPZQ==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sedaY-0005Ys-5O; Thu, 15 Aug 2024 18:44:38 +0200
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
Date: Thu, 15 Aug 2024 18:44:36 +0200
Message-ID: <2548443.Ac65pObt5d@diego>
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

I guess that piece of documentation should move to the dts style
guide though? Because it's not about writing bindings but how
to structure a dts/dtsi.


