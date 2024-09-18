Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F4149C70;
	Wed, 18 Sep 2024 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640510; cv=none; b=dCWpYntC40POdL5n0ZPmTs0IAhhJrSuFIY/dQcr8qDDhcAcUPC5xEKKT2O4N86F61vcnjdinpZtl/L04z1f1p9atf4mf4hmfEcJ+HVlnIGOlocMJR5198qymrJzDmGxTCC+8jFS3AnI8l9byXHpimOwIUbOMPFGM5m4/a4ER/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640510; c=relaxed/simple;
	bh=oyYt8Xngaj7P/IOreZdbBQsMi8xb97lu/A7vj7k2qzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l043K3JMvKcdATgEwHQ9WaVzZxEtvP4IXEoSSU4TMZ0NgCe9x9dQARiRL5U/+gwl+x63PcsBhAn5SR7TpFl6xb0JQKHOUdTlfb1FU/foWdzoIPCwwwaq/G4Akxtd5MbVYuQXXWb75+Mz5wTRtrMYrtL+vx4bcOV0+UuSy9ULq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i4aKd0TV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i4aKd0TV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B9FC4CEC3;
	Wed, 18 Sep 2024 06:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726640509;
	bh=oyYt8Xngaj7P/IOreZdbBQsMi8xb97lu/A7vj7k2qzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4aKd0TVlrwE+0/JKPUU9enWLM2kYvKt/BCRQT3+c2/SSNDafYzYLbTCxJr2wFMvR
	 7ue3ZVkq+YE2R3f3szzEoNN0AIspwLjbnX3bAaubBmf1wQMKWqRaR5i5DVcmH25Jlu
	 jgWGRzafFSQ/ILc2SZOaw1W2/Zl7SHu8LbL7pdlE=
Date: Wed, 18 Sep 2024 08:21:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Yao Zi <ziyao@disroot.org>,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH v4 0/4] Add initial support for Rockchip RK3528 SoC
Message-ID: <2024091817-art-splashy-f547@gregkh>
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

Yeah, I missed this as it was part of a larger series.

> So I guess the easiest way would be to send the uart-binding from patch 1
> as a completely separate patch with adapted Cc list, so that it's obvious
> this should go through the serial tree.

Yes, please just send that one patch and I can pick it up.

thanks,

greg k-h
