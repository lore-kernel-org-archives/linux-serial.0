Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F24AD59;
	Sun,  4 Aug 2024 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722750059; cv=none; b=U3YWYgDCDedwj6KPGT0hUQgvpIDPznPy5AGO2AQ+3+HR/h6UAR8D3AdyAXH5nr3YHwPPNhtHuPr7Y3hk02B4L1lMdfQECjMo6oij/qxDMtJorhu4h3vwFBskZX4Ogx/WObwTFlqXVeTLJRdhqJjqnb9dxw57AjxfQJekTEH3Q7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722750059; c=relaxed/simple;
	bh=0HRhv5yR2GM7y/9QAtXndsutKfzGnscC3iMEPFaBgb8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WsVto5AMqlF3X74Tlsbws5F2xM4bb7ckHrJEPMbdaAjjDv9hoti0B7M1/5RFcmNHAePFU0IcoiXhHg/l5SmRNIbPvNaYHKxVHWbIITws2eFJaLR4QJ+ybnShKLA/1t9dPpBq0aiq0/B3U3lUrfco6zedvsD55oBp0/Q5P18VufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=c6oCsVeP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="c6oCsVeP"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722750047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tX3JvGIYlx8csPMqWm0u4u7fIhbdLPz4xTLWRhyYx0=;
	b=c6oCsVeP2bTK+Msyv/P1exnF7+kUkx5p/WsUrZWotPvOa0XmVdPIp8kE072+nTtYRWrryN
	I06nFgWlycEFyp1DRJIyl2Ldew5Yun727GhOBdSKh7jus5zaB9gMkrmEauZN1Rct+71Q90
	CeRQ0WK2CEp4YQSGJ+OtEDNmuwlIZwTwzU/6QJCSb07ew5Qz8lcx6FtB/s6Bt0HSFAMZHL
	R8FZEXa7EDaEkyJJqblMJyphyylrN9yICfB8p1lAYW/vmipoLqsIePcWqYjkqpPaMOtR7L
	PLqd++Wx/FZhP53R19siZulStRSMqu7B9QVLz3dXxgIR8rNVgpiXTIM62jkQrQ==
Date: Sun, 04 Aug 2024 07:40:43 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>, Andy Yan
 <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>, Jagan Teki
 <jagan@edgeble.ai>, Ondrej Jirman <megi@xff.cz>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/4] Add initial support for Rockchip RK3528 SoC
In-Reply-To: <20240803125510.4699-2-ziyao@disroot.org>
References: <20240803125510.4699-2-ziyao@disroot.org>
Message-ID: <0c77f99f4af96807a2a8c3028e3c1d4d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-08-03 14:55, Yao Zi wrote:
> Rockchip RK3528 is a quad-core ARM Cortex-A53 SoC designed for
> multimedia application. This series add a basic device tree with CPU,
> interrupts and UART nodes for it and is able to boot into a kernel with
> only UART console.
> 
> Has been tested on Radxa E20C board[1] with vendor U-boot, successfully
> booted into initramfs with this log[2].

I wonder will at least the RK3528 datasheet become available publicly?

> [1]: https://docs.radxa.com/en/e/e20c
> [2]: https://gist.github.com/ziyao233/b74523a1e3e8bf36286a572e008ca319
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
>  .../boot/dts/rockchip/rk3528-radxa-e20c.dts   |  22 +++
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 182 ++++++++++++++++++
>  5 files changed, 211 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
> 
> 
> base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
