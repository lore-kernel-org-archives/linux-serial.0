Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55413AD11;
	Mon,  5 Aug 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855632; cv=none; b=HiwOpAluhkE06AnFd8wAxx8ViKLCKXFIiwdjDIdb1I/J8MFMk83q9KVFHuxhEn1fjwhPefw7LrVnwXW53mtrohhpr22zjUPLxDJ2P9tVqIxiFAN3YBW9TTQNGouG+W+EqkUDoL5gkPCn+8mb08x/u5mUnX/QPEjdRrOZO7b0ZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855632; c=relaxed/simple;
	bh=yWG1ffncRBE4pRq4s7S+wiFWhJWlpLs09+f9rKud/VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUclJEq5CULce7yw9V4UhUxhtU9b8C6D+071XaiD9frkTDf2cIlit2leejjh+9OT3rfgSn+FmeSc/pitXZ28cXQegHGms0IfB/3wfGTlPGouHlX4KfaQkzezO+Lu5HhY8nngqj3b6m28R//8IGkzejMFNJWod1IKaeDhOpd73Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FDgChoiu; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FDgChoiu"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5C3FD418FA;
	Mon,  5 Aug 2024 13:00:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cSj5y5vJ8qJe; Mon,  5 Aug 2024 13:00:24 +0200 (CEST)
Date: Mon, 5 Aug 2024 18:59:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722855624; bh=yWG1ffncRBE4pRq4s7S+wiFWhJWlpLs09+f9rKud/VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FDgChoiuUO85kHJM0IZ4qjGqc85KQmq6H4+JkylVQiZBK+gVlyoh5x0atGlxizFVf
	 cTypiefgmtxEIxI91rSTNShf6kv33ApVhNDamIEGsqHw/7PCnlu6dVxj01j4GWCfbY
	 kK7f47u61jJIMLxI4mP+aMLQHyv0eYe0qirOjJvE2I1OK31i9W5mMYszkHtrxDuiux
	 2OgjUnLMKOr6/yQ/UsatIXNFvbBTL7hArMhRZ1ClcP+hLmshhn+D8vZkS6ZysBcpwn
	 ZTpNJ7Xg/U0EHlkK+4JirorUqto4ryCfmsZ9ihdNMzE1EBKqxcfTIWHgioTLrHUz8a
	 nt0k4zASa4gWA==
From: Yao Zi <ziyao@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
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
	Ondrej Jirman <megi@xff.cz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Message-ID: <ZrCwrWjRgvE0RS98@ziyaolaptop.my.domain>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <20240803125510.4699-5-ziyao@disroot.org>
 <56bd1478-ce8c-4c1d-ab16-afe4ad462bf5@kernel.org>
 <Zq-AFWYaqu7zGuz-@ziyaolaptop.my.domain>
 <b967ab05-dd0e-4fc5-bee6-ad7639e47bfb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b967ab05-dd0e-4fc5-bee6-ad7639e47bfb@kernel.org>

On Sun, Aug 04, 2024 at 04:05:24PM +0200, Krzysztof Kozlowski wrote:
> On 04/08/2024 15:20, Yao Zi wrote:
> >>
> >>> +		compatible = "fixed-clock";
> >>> +		#clock-cells = <0>;
> >>> +		clock-frequency = <24000000>;
> >>> +		clock-output-names = "xin24m";
> >>> +	};
> >>> +
> >>> +	gic: interrupt-controller@fed01000 {
> >>
> >> Why this all is outside of SoC?
> > 
> > Just as Heiko says, device tree for all other Rockchip SoCs don't have
> > a "soc" node. I didn't know why before but just follow the style.
> > 
> > If you prefer add a soc node, I am willing to.
> 
> Surprising as usually we expect MMIO nodes being part of SoC to be under
> soc@, but if that's Rockchip preference then fine.
> 

Okay, then I would leave it as is.

For the fixed-clock node, I think "xin24m: clock-24m { }" is okay and
follows the new rule?

Best regards,
Yao Zi
