Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6C179967;
	Tue, 17 Sep 2024 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726604105; cv=none; b=exn/S5hxkRFO0Ak1upino74aQ9+D8MJKt4MFmXhmceLjzqP9DF36yYFvmTTvgIBr2ka96d07KgcXaL+BTdXMyyIgEDhS5VrcpeNmy1YZtoR2cnY5DjYEgLs5AU+g0UJgumSbZpTY4EDzM7ZHn72M8ajm+HzC7YRcWuyT2o56r8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726604105; c=relaxed/simple;
	bh=81iSzbOqnhSne0ktuF01wg+nnD9mtVaFvoeVj8EBkw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mx3oJ/K9/oqKSaTWgF3VHJSzHAgunO62N7VUJLq6ZVBiKB6yamXf4ruxVTWK48kyP8KfVmRC79rm3PPkZTknNfqLcN+E/2ef41pTJjKBfAVNorMBLSmd9KkzR/O4oa3jZvr+t9Dy4sre+kd6q7OKqiQagPh8B6N95jUzPyGuVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Th5+iAsG; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Th5+iAsG"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D9E282004E;
	Tue, 17 Sep 2024 22:14:59 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z5SgtwYYZVmj; Tue, 17 Sep 2024 22:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1726604098; bh=81iSzbOqnhSne0ktuF01wg+nnD9mtVaFvoeVj8EBkw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Th5+iAsGerByToyw4NuXu8K47DlwvEDYpiK0yxRx5l/RxP8eRTk9Tm/L/5lcBEv99
	 y3um4swxXKfFj5++rSau/mlVnzW2SqcbI4TWoNO2VDtzgNWtmtTlAyfZ8WZDDARLlk
	 njS39OGvoKPoyXdQ8nsieeU/tpVdGWrTp1PdtAJ/Cuw0wtP9+CWySSTKqzWZdY3Qy3
	 Dlf5vTvHGhqBWP8LK9KMyRlPhE0/CGUAopEuf2GseFQiB86ZAGDFg7Qt2LcWr5n1sP
	 i1rVOELPo+x6mIj5Tfaoj2l7RcZ7YAEo2Yom9g51I1QImo6U12IAJzDuR8vkB9T2mX
	 nsMCVFH3CzB7A==
Date: Tue, 17 Sep 2024 20:14:36 +0000
From: Yao Zi <ziyao@disroot.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
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
Message-ID: <ZunjLMQGEcES2zIV@pineapple>
References: <20240829092705.6241-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829092705.6241-1-ziyao@disroot.org>

On Thu, Aug 29, 2024 at 09:27:01AM +0000, Yao Zi wrote:
> Rockchip RK3528 is a quad-core ARM Cortex-A53 SoC designed for
> multimedia application. This series add a basic device tree with CPU,
> interrupts and UART nodes for it and is able to boot into a kernel with
> only UART console.
> 
> Has been tested on Radxa E20C board[1] with vendor U-boot, successfully
> booted into initramfs with this log[2].
> 
> [1]: https://docs.radxa.com/en/e/e20c
> [2]: https://gist.github.com/ziyao233/b74523a1e3e8bf36286a572e008ca319
> 
> Changed from v3:
> - move mmio devices into soc node
> https://lore.kernel.org/all/20240814155014.18097-1-ziyao@disroot.org/
> 
> Changed from v2:
> - fix fixed-clock nodename
> https://lore.kernel.org/all/20240811140725.64866-1-ziyao@disroot.org/
> 
> Changed from v1:
> - fix stdout-path
> - style improvements
> https://lore.kernel.org/all/20240803125510.4699-2-ziyao@disroot.org/
> 
> Yao Zi (4):
>   dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
>   dt-bindings: arm: rockchip: Add Radxa E20C board
>   arm64: dts: rockchip: Add base DT for rk3528 SoC
>   arm64: dts: rockchip: Add Radxa e20c board
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  .../bindings/serial/snps-dw-apb-uart.yaml     |   1 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3528-radxa-e20c.dts   |  22 ++
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 189 ++++++++++++++++++
>  5 files changed, 218 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
> 
> -- 
> 2.46.0
> 

Ping on this thread. Is it possible to get this merged in v6.12? Or
anything else I need to do?

Thanks for your time.

Best regards,
Yao Zi
