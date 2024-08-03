Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAEC49659;
	Sat,  3 Aug 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722693189; cv=none; b=BGu8MYqz90geMWsNoDO0TGgCp2OKClP8isNN/bqQU55g/na4M1AsV1g0BhIjs6eWTV/uK1ijO4SdpZAVDZZMNpnZLgxQA9bmtjSKW1DPkFZRRKzr8XnS+OnKIQal4c16bo742GE3MJHmw49F7oxDS3CN4dXQ/ynCyc0sYDrsrUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722693189; c=relaxed/simple;
	bh=bk7/OnAhj274Gt5seZW+zqWCGaoFoFkkGV82e3GwOrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDFHWs3pyvEf7yOSQz6TxPWpaHx1Dx2CNK+i6F1T7Y9CcNCh+2gMxk3o13cOChpCFXepmQ1GD8tvVIPNAp1JK02H0aq5Ilh+GEJYb/buKIX+lvyaml417U+r40IkCv9DWV9bba8i8Pqor942ja/0YkdFkts35U0jIjAOyRvODiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gOgkOQJp; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gOgkOQJp"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8D4BF40D5C;
	Sat,  3 Aug 2024 15:53:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FuwoRZpePIE6; Sat,  3 Aug 2024 15:53:04 +0200 (CEST)
Date: Sat, 3 Aug 2024 21:52:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722693184; bh=bk7/OnAhj274Gt5seZW+zqWCGaoFoFkkGV82e3GwOrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gOgkOQJpxMfbXYQd8qL7FCNVf7zizoNVInDiTebd67Uk70rmq/VjfEF28HdK69pUK
	 XlAU+DqegjVRtbXasANSLLNva59LJHAihKT5fruTZ2dHCEcyNQSRjdmM9tMISLCH44
	 c0GjDhTJjoYxufwo0oteneTEglmbPeh/fn1NiePkGhCX0qVRspvSksmx/Rsh1JZp8s
	 RKW+ek/xqJ6MaCFlXVTvag79wkI+/lfWnQOTeIkCzvaQhvUOOWQLE+x1hedu/HIHjz
	 32G4nDQKzG3T2/WpKq9Ej6j1JHYx7w/5wK2w5lc1wQZz1s7MobgJyqBLOq8l9rwU+T
	 xWwSVOeh0v78A==
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
	Ondrej Jirman <megi@xff.cz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add Radxa e20c board
Message-ID: <Zq41xr3fYoXqLjIF@ziyaolaptop.my.domain>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <20240803125510.4699-6-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803125510.4699-6-ziyao@disroot.org>

On Sat, Aug 03, 2024 at 12:55:11PM +0000, Yao Zi wrote:
> Add board-level device tree for Radxa e20c board[1]. This basic
> implementation supports boot into a kernel with only UART console.
> Other features will be added later.
> 
> [1]: https://docs.radxa.com/en/e/e20c
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 22 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index fda1b980eb4b..ecdd767d0323 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -74,6 +74,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e20c.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-d.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-s.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg353p.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> new file mode 100644
> index 000000000000..534bd47e9971
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2020 Rockchip Electronics Co., Ltd
> + * Copyright (c) 2024 Radxa Limited
> + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
> + */
> +
> +/dts-v1/;
> +#include "rk3528.dtsi"
> +
> +/ {
> +	model = "Radxa E20C";
> +	compatible = "radxa,e20c", "rockchip,rk3528";
> +
> +	chosen {
> +		stdout-path = "serial5:115200n8";

There is an error, stdout-path should be "serial0:1500000n8".
Sorry for my mistake, will be corrected in next revision.

Best regards,
Yao Zi
