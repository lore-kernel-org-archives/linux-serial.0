Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D837519C56D;
	Thu, 19 Sep 2024 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742709; cv=none; b=OTpYlW0h4gVdUaH90pejKhbq3rGvK31EyNgk4QFjGz1uMqmmR4pxqM0aWatTH1wbp0fShzvhlQ0FUOvHLiYIxyNIirsAk+ogH04MkWQ6yHQ9mtMbVZh9kaXpvhoqjYFcAvf+jwT54yGKVv/Fj0N41TWa1rQsYJ1mjH0Am172OGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742709; c=relaxed/simple;
	bh=/os8jdsvZNjZzBQqTEH9zSBE9KS0uwILd2ijRnbkvU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XW7Zd7IwIWPEueJAJuv177W9s3OI/faPshDeKoeZlIrEGLBEJowqFWCqXZ9BiYtoNPg6KnZShlY21vx7X+zsZ+TiZRoP9bWBw85o0Pqn4f8BvN9zwDskcrmro3qq01OP92VTcg7qp0BkTihT1sCdsNUtO02CKfI9tbE7O1crRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DNFeORec; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DNFeORec"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2CE6523D13;
	Thu, 19 Sep 2024 12:44:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qw0S_KiD1mf1; Thu, 19 Sep 2024 12:44:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1726742697; bh=/os8jdsvZNjZzBQqTEH9zSBE9KS0uwILd2ijRnbkvU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DNFeORec4f+AS0c8WR+mK9+oKWcxhMjeHXEgkhzRaIFpxvXFdDbniCgSzkNxfPLpf
	 3fotaflPhH4vQv46nLUVoPuPdMxNflI0okssfRLCA71T/G393xnQ5IzmDNEJBJGT11
	 QQ8rsOgeRoPemOYd34UP5N3hMQMzgWqDCv4uaHaG42TQnOCfjQWAUguWayIj7LuedM
	 BTobRFh35Pfrh3V3sN/7M1s4QID0o6lDA/QhQOTh7lVEdIwRtGS/YxNm3MTG4V8rHU
	 Pv0Bk0XTzAt5no+nIJVTykqWX4MBFHKH+WHIwr0XSquJF2s1t4RdcMCQRm8GjS1M5M
	 M6HABXoLsluGg==
Date: Thu, 19 Sep 2024 10:44:25 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH v4 0/4] Add initial support for Rockchip RK3528 SoC
Message-ID: <ZuwAiaCF6hCr7Fa2@pineapple>
References: <20240829092705.6241-1-ziyao@disroot.org>
 <ZunjLMQGEcES2zIV@pineapple>
 <23655990.6Emhk5qWAg@phil>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23655990.6Emhk5qWAg@phil>

On Wed, Sep 18, 2024 at 01:13:25AM +0200, Heiko Stuebner wrote:
> Hey,
> 
> Am Dienstag, 17. September 2024, 22:14:36 CEST schrieb Yao Zi:
> > On Thu, Aug 29, 2024 at 09:27:01AM +0000, Yao Zi wrote:
> > > Rockchip RK3528 is a quad-core ARM Cortex-A53 SoC designed for
> > > multimedia application. This series add a basic device tree with CPU,
> > > interrupts and UART nodes for it and is able to boot into a kernel with
> > > only UART console.
> > > 
> > > Has been tested on Radxa E20C board[1] with vendor U-boot, successfully
> > > booted into initramfs with this log[2].
> 
> > Ping on this thread. Is it possible to get this merged in v6.12? Or
> > anything else I need to do?
> 
> sadly nope. From a timeline point of view things should ideally be in the
> Rockchip tree by -rc6 . Which then move to the soc tree and from there
> to Linus' tree.
> 
> There is this rule that all new development for a -rc1 kernel should be
> present in linux-next _before_ the merge-window opens.
> 
> The thing we need to figure out for your series is the uart binding,
> because that _should_ go through the tree handling serial drivers.
> Greg is in your cc list but with the amount of mail he gets, I don't
> think he has single-parts of patch series on his radar.
> 
> So I guess the easiest way would be to send the uart-binding from patch 1
> as a completely separate patch with adapted Cc list, so that it's obvious
> this should go through the serial tree.

Will do it, thanks for the suggestion.

> From talking with Collabora people today at the Open Source Summit, it
> seems that's also their plan for the rk3576 that is stuck at a similar
> state.
> 
> 
> Hope that helps a bit to explain

Thanks for your reply.

Cheers,
Yao Zi
