Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D41EA84;
	Sun,  4 Aug 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722777778; cv=none; b=f9yIThV13xAohD1Hg/vl5jy8UZUthP4NlI2RYIB9LKoEMAhOJeHTSab9+KHv+BFtVjONkHOXE6YEpGrkHxwKXlyLJPLKKJTN3FZkoR7eBWACySCeIGfhuAIllfyEefZkOWU/RQzsaNmLzIoyah7c1JAVcJd2iRHf2DPddI45COY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722777778; c=relaxed/simple;
	bh=EJwbLhrdm5mtnRnMgCm3j6P/Pxr9AN3xHKptBP6VPEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUhtPE39MvNZZs1kf1T8YNXDfnKTtS/6kOMabpjjKNBrayyL90RCxNgmsKN/KsiNmSM/KQiVLGC+NFXwI6wQe9RyB3NpHfHquv3zwFdrdQfQcOLgUkp7lGydETuYm0+HRejeX8RrTXsgguoFBfhGUaCCB4cB8uEDcFqdIU4+ILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PonhCu0S; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PonhCu0S"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 44AD041832;
	Sun,  4 Aug 2024 15:22:55 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sKl4H72e6Lt0; Sun,  4 Aug 2024 15:22:54 +0200 (CEST)
Date: Sun, 4 Aug 2024 21:22:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722777774; bh=EJwbLhrdm5mtnRnMgCm3j6P/Pxr9AN3xHKptBP6VPEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PonhCu0SQzsaWi52cTDNuxSLWtBoWgtPAhZWtQ3YmvU8k/f2ejpypCRmZxNHCFMXC
	 JoAjskIOegj5QP9lprKfstYkiEGmOdR+LYqJ/K062IFMfRMEpK7dmTIr8hgVzwDg7l
	 ZaqHkZUlcgafOkdQEjNMPueO9T8wfk9L8goa9KB6ZAofjr79aTcFZHl3P61a/iLShn
	 AZSB0HqbWN9Pm17YuB+GlwxA3Q8XD1DLkcGeg+LPfInag8l6hrV+HJ0HU4mPxUV2hU
	 IRm5X0Z8ptlTCGZy7mkRNUtnNK857zsad4cpdgl96s0GluFaozjQMaDvvkekS/8eSX
	 TSxt754zSDP8w==
From: Yao Zi <ziyao@disroot.org>
To: Diederik de Haas <didi.debian@cknow.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>, linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Message-ID: <Zq-AlANMrNCf5xCK@ziyaolaptop.my.domain>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <20240803125510.4699-5-ziyao@disroot.org>
 <3483951.iGylCHCCq3@bagend>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3483951.iGylCHCCq3@bagend>

On Sun, Aug 04, 2024 at 01:27:35PM +0200, Diederik de Haas wrote:
> On Saturday, 3 August 2024 14:55:10 CEST Yao Zi wrote:
> > +       gic: interrupt-controller@fed01000 {
> > +               compatible = "arm,gic-400";
> > +               #interrupt-cells = <3>;
> > +               #address-cells = <0>;
> > +               interrupt-controller;
> > +               reg = <0x0 0xfed01000 0 0x1000>,
> > +                     <0x0 0xfed02000 0 0x2000>,
> > +                     <0x0 0xfed04000 0 0x2000>,
> > +                     <0x0 0xfed06000 0 0x2000>;
> > +               interrupts = <GIC_PPI 9
> > +                       (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> > +       };
> > +
> > +       uart0: serial@ff9f0000 {
> > +               compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
> > +               reg = <0x0 0xff9f0000 0x0 0x100>;
> > +               interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> > +               reg-shift = <2>;
> > +               reg-io-width = <4>;
> > +               clock-frequency = <24000000>;
> > +               status = "disabled";
> > +       };
> 
> The properties should be sorted as follows:
> - compatible
> - reg
> - <other properties sorted alphabetically>
> - status
> 
> This also applies to the other blocks which I didn't quote.

Thanks, will be fixed in next revision.

Best regards,
Yao Zi
