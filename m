Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E923FC2;
	Sun,  4 Aug 2024 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722752581; cv=none; b=bixVaduZ4Ck7KgPMqMzbaOTDMB22NpOdVinKka/bKOAD77B4gNyLKWyaDjpXrEGZ1/71dtT5V/uG9Lv5Hl2IP5yu7mtP4SiJQO9rSfdrXhL4/leks8jBoNByn2RYEW9rx6QBmY0HFb37q/IaIvn+24FSZTsDuEGI0ge+rPNNL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722752581; c=relaxed/simple;
	bh=e2KwdmpAEeu/CxUB955zMwv6k2v7QDlGFFwf4VhPBZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQA1AVVV3+kTC6rquFvLPnwDz1UgBcpG2uHAygHh50AE5MqJ6xnkegrzr+jGhtxCVEX7aAHT/+vkUpftgVpFbQpuVMynws+j9kvltaSogrO1oJO51cqo3pbUryG7yoDrJiWXSk0of3fflhAawNv1Pm3WXc4FyLchfhfrJn/sKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BAPOxYD2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BAPOxYD2"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AC7A541943;
	Sun,  4 Aug 2024 08:22:55 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bfxzql5IWaIV; Sun,  4 Aug 2024 08:22:54 +0200 (CEST)
Date: Sun, 4 Aug 2024 14:22:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722752574; bh=e2KwdmpAEeu/CxUB955zMwv6k2v7QDlGFFwf4VhPBZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BAPOxYD2ErIWPwE9V9eroZvbUZjtUETM32iyvVLYXnNJrLwHODsPUGINv5AT46fzy
	 5hgksWLOaCdHsfYGYpJczmnPTWzptsoQ0KORgHeQ8GUpKMeAaVhD5ootDDjfFtXA++
	 87E6wFBgI1dehnR8fRZokTKmbc3hPnWmu5z3TK3d0ak2tvlkvPWlJeDgl8/Cd4jGw6
	 HtCqVwY/zMfkdgix4TGzg6GgNqM6Pt9IXPb28avNrPQPLT2gLUHz/EiLi9gH/nNt7t
	 cRQ4bGzultoUXW8jfov0BIFWr2l1hxVeJWqB4wO4h+QYbywG80aKtwuQXuRXF17cyf
	 NJiemnfL4FG/w==
From: Yao Zi <ziyao@disroot.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/4] Add initial support for Rockchip RK3528 SoC
Message-ID: <Zq8eJB7zqOvYQvmw@ziyaolaptop.my.domain>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <0c77f99f4af96807a2a8c3028e3c1d4d@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c77f99f4af96807a2a8c3028e3c1d4d@manjaro.org>

On Sun, Aug 04, 2024 at 07:40:43AM +0200, Dragan Simic wrote:
> Hello all,
> 
> On 2024-08-03 14:55, Yao Zi wrote:
> > Rockchip RK3528 is a quad-core ARM Cortex-A53 SoC designed for
> > multimedia application. This series add a basic device tree with CPU,
> > interrupts and UART nodes for it and is able to boot into a kernel with
> > only UART console.
> > 
> > Has been tested on Radxa E20C board[1] with vendor U-boot, successfully
> > booted into initramfs with this log[2].
> 
> I wonder will at least the RK3528 datasheet become available publicly?

I found none for now, and I am not someone from Rockchip, thus don't
know whether they have a plan to make it public, either. But there has
been some devices shipping it already and getting them mainlined will
be a neat thing.

Just FYI, the vendor kernel is available here[1] on the "develop-5.10"
branch.

Best regards,
Yao Zi

[1]: https://github.com/rockchip-linux/kernel

> 
> > [1]: https://docs.radxa.com/en/e/e20c
> > [2]: https://gist.github.com/ziyao233/b74523a1e3e8bf36286a572e008ca319
> > 
> > Yao Zi (4):
> >   dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
> >   dt-bindings: arm: rockchip: Add Radxa E20C board
> >   arm64: dts: rockchip: Add base DT for rk3528 SoC
> >   arm64: dts: rockchip: Add Radxa e20c board
> > 
> >  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
> >  .../bindings/serial/snps-dw-apb-uart.yaml     |   1 +
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3528-radxa-e20c.dts   |  22 +++
> >  arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 182 ++++++++++++++++++
> >  5 files changed, 211 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > 
> > 
> > base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
