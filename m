Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF912B6C;
	Sun,  4 Aug 2024 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722778098; cv=none; b=HDwzToXkmou1epzBUJTweo6obmZkWBvgk+qfUS5I7LOf3HXaqWtHkEtbZSRQKYUw8mCURiTQmv3joA4gmG5HFz4e1gSSD5wTwC9OOMWVf0jje58VJ6P+gSjXifszLzr1AROREtIvKxlCbWbS5cHow2ugh6HH2XcIKoaFXw379V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722778098; c=relaxed/simple;
	bh=RfCC0Rd2hawHEeBBuBIbGRY7g/EAFFGPxBU/1QuLlsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhbw+IUCwamBh2skwwKi1rHnu0HOmA9+2B/PSkb5UzVqEekXubmYjr/aSWsLfBXV2pbWOKmo4kNyJeXSjDAxKA7wpQsf2iHZ3WObDu/RIaPpqq59jSY34Ajz3nstg1cxKxySynI5F0+lE5hwTU/5w4quXSFcRF5lku4WIUSVW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aOaTOxoc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aOaTOxoc"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3A4134103C;
	Sun,  4 Aug 2024 15:28:14 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fGeTbZQBCPqx; Sun,  4 Aug 2024 15:28:12 +0200 (CEST)
Date: Sun, 4 Aug 2024 21:27:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722778092; bh=RfCC0Rd2hawHEeBBuBIbGRY7g/EAFFGPxBU/1QuLlsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aOaTOxoc7xbi8RoeDfgUdN1RRZ3nZxU1OaftnAR08AkWuc+MpV2Uvu2EqaKvCp+Kl
	 rwn0WbPO9aDFORnzOfprKAi46k26BxBRFR5dSNnApdJCVb6kxwdXVa3BFgIAQ0a2Iw
	 HXyZ+rfSfi/pdK3HBuyrKPsh88saq1U7DGV08fxM3JfgFQCqu+x8l/reM1TH8cfb7w
	 brKd/MWRT4xaZYZ+5/dYHJyGvlT/eaVjapGtrht0qmbYxzFARqPQZkgXeNVjotaZch
	 3GdooHtVSdYeK1oSAqkPDmwzfbn831t4GgtpwUN2KtrhzzGO5IPdqBaJsY6clG0Pto
	 pjUUfWwHoJaSQ==
From: Yao Zi <ziyao@disroot.org>
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/4] Add initial support for Rockchip RK3528 SoC
Message-ID: <Zq-B07RbFdDTFX3R@ziyaolaptop.my.domain>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <0c77f99f4af96807a2a8c3028e3c1d4d@manjaro.org>
 <Zq8eJB7zqOvYQvmw@ziyaolaptop.my.domain>
 <3EA59A56-C6E5-40B7-A5C4-C280B001E981@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EA59A56-C6E5-40B7-A5C4-C280B001E981@gmail.com>

On Sun, Aug 04, 2024 at 11:13:59AM +0200, Piotr Oniszczuk wrote:
> 
> 
> > Wiadomość napisana przez Yao Zi <ziyao@disroot.org> w dniu 04.08.2024, o godz. 08:22:
> > 
> > On Sun, Aug 04, 2024 at 07:40:43AM +0200, Dragan Simic wrote:
> >> Hello all,
> >> 
> >> On 2024-08-03 14:55, Yao Zi wrote:
> >>> Rockchip RK3528 is a quad-core ARM Cortex-A53 SoC designed for
> >>> multimedia application. This series add a basic device tree with CPU,
> >>> interrupts and UART nodes for it and is able to boot into a kernel with
> >>> only UART console.
> >>> 
> >>> Has been tested on Radxa E20C board[1] with vendor U-boot, successfully
> >>> booted into initramfs with this log[2].
> >> 
> >> I wonder will at least the RK3528 datasheet become available publicly?
> > 
> > I found none for now, and I am not someone from Rockchip, thus don't
> > know whether they have a plan to make it public, either. But there has
> > been some devices shipping it already and getting them mainlined will
> > be a neat thing.
> > 
> 
> Maybe this hight be useful: at some point in time I started to hack with rk3528 support in mainline kernel.
> HW I’m using is vontar rk3528 tvbox.
> 
> So far - on mainline 6.10 kernel - I got working: clocks, pin control, uart, sdcard, eth, usb.
> 
> I started to work on dw hdmi and got to stage with correct mode sets by dw-hdmi but I stuck with vop3 support.
> 
> Generally - I was back porting code from bsp but rockchip bsp is too divergent from mainline to my back porting skills :-(
> 
> If anybody can help with vop3 - then we can have quite good initial support of rk3528 in mainline (the, sdcard, usb, eth, hdmi)
> gpu, hdmi audio should be probably easy…
> 
> My rk3528 enablements:
> 
> Bindings: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1100-dt-bindings-clock-add-rk3528-clock-definitions.patch
> 
> Clocks: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1101-clk-rockchip-add-clock-controller-for-the-RK3528.patch
> 
> Pincontrol: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1102-pinctrl-rockchip-add-rk3528-support.patch
> 
> Power domain bindings: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1103-dt-bindings-power-add-RK3528-SoCs-header-for-idle.patch
> 
> Ethernet support: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1104-ethernet-stmmac-dwmac-rk3528-add-GMAC-support.patch
> 
> Power domains support: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1105-soc-rockchip-power-domain-add-rk3528-support.patch
> 
> usb: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1106-phy-rockchip-inno-usb2-add-phy-support-for-rk3528.patch
> 
> SoC power domains: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1108-soc-rockchip-power-domain-add-rk3528-support.patch
> 
> Thermal: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1108-thermal-rockchip-add-support-for-rk3528.patch
> 
> Naneng phy: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1109-phy-rockchip-naneng-combphy-add-support-for-rk3528.patch
> 
> dw hdmi: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1110-phy-rockchip-inno-hdmi-add-support-for-rk3528.patch
> 
> Inno hdmi: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1111-drm-rockchip-dw_hdmi-add-support-for-rk3528.patch       Nvmem: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1113-nvmem-rockchip-otp-add-support-for-rk3528.patch
> 
> Sound soc: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1114-sound-soc-codecs-add-rk3528-support.patch
> 
> rk3528 dtsi: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1150-arm64-dtsi-rockchip-add-3528.dtsi.patch: 

FYI, This link is dead.

> Vontar tvbox dts: https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.10/files/1151-arm64-dts-rockchip-add-dts-for-vontar_r3.patch
> 
> It may happen that above patches will not apply clean on vanilla 6.10 as I’m patching kernel for s905/s912/sm1/g12/rpi3/rpi4/rpi5/3328/3399//3566/3568/3588/3528 and rk3528 patches are after applied s905/s912/sm1/g12/rpi3/rpi4/rpi5/3328/3399/3566/3568/3588 patches.
> 
> If anybody is interested in adding vop3 support - pls give me sign - we can work together…
> 
> > Just FYI, the vendor kernel is available here[1] on the "develop-5.10"
> > branch.
> > 
> > Best regards,
> > Yao Zi
> > 
> > [1]: https://github.com/rockchip-linux/kernel
> > 
> >> 
> >>> [1]: https://docs.radxa.com/en/e/e20c
> >>> [2]: https://gist.github.com/ziyao233/b74523a1e3e8bf36286a572e008ca319
> >>> 
> >>> Yao Zi (4):
> >>>  dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
> >>>  dt-bindings: arm: rockchip: Add Radxa E20C board
> >>>  arm64: dts: rockchip: Add base DT for rk3528 SoC
> >>>  arm64: dts: rockchip: Add Radxa e20c board
> >>> 
> >>> .../devicetree/bindings/arm/rockchip.yaml     |   5 +
> >>> .../bindings/serial/snps-dw-apb-uart.yaml     |   1 +
> >>> arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >>> .../boot/dts/rockchip/rk3528-radxa-e20c.dts   |  22 +++
> >>> arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 182 ++++++++++++++++++
> >>> 5 files changed, 211 insertions(+)
> >>> create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> >>> create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
> >>> 
> >>> 
> >>> base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
> > 
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

Best regards,
Yao Zi
