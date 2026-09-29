Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6C350A0F;
	Tue, 29 Sep 2026 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664459; cv=none; b=XNFNwi95JJcGR9iOS79BYRtYF5bFZPUHrAKJqww3ItQxgVkry3OadC12v8ObQXMd5rubEnjTQdcXf08BAHETr3BgMSD/229lqrVF/8Xz+dOW2TEHzzX80h78LOYDUMrqA/BZRywPxlvFkSlYC9+VAawa15xMaXQHqHqpaPHw69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664459; c=relaxed/simple;
	bh=/0LrC2RxTphSEA/1PaEo9HCQLwX3jvloBdvVB8oCfDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OXlSp1Of+hTkXXl0itGxizeR5n031LBfQMZRFlba9iqWxr8HSuRYSSBKe/iPbXa3D4FRVa1We7yHlE3EhGUDm532Pf+24IPENtervFJR3cfcmf3biKw+xNKGpVXKPEOi8BzDByM5pLjitOFfSbqksnNzmtPHHB4Hr/jnq+vCFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkcA4PIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkcA4PIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931681F000FF;
	Tue, 29 Sep 2026 06:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664458;
	bh=K8KuaxQckNe2MccofgXiA03iijp30ZSc0gaaENsMpaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lkcA4PIpbWfmRv6WRLJqPZQfSeA06swsOct6a/cK+18FQk1GQTtULwg7ub/0rPAc8
	 b0P8As/BRCxOlwreaCiFlSLfD7TkMTjEAWZraquQ3xkTh+Z2qep9OeOSyQZ9i7cgkR
	 lV9VKDQOMawJdY9essOxXsX8bMb6vUnkgMCpWx43MFon0Z0YCI2oFuHl6xXjXdVOW1
	 Lykzlr9j2g1G+hbiU6M5oeF3B1rYxNCDbVX0juQVBQO5rC5PCTkDAeRcUZMP9Itf3i
	 r5nG2KC9/TUSE09CWDvhC5Z8TWuVs9nOdSn2PGQqfU+cUNH3q+C0f6nTRWGPxnUOYn
	 qfG96xpSC5d1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/20] pinctrl: berlin: support Synaptics SL261X SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-i3c@lists.infradead.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, robh@kernel.org, lee@kernel.org, Frank.Li@kernel.org, linux-serial@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260929061417.20733-15-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-15-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:47:37 +0000
Message-Id: <20260929064737.931681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] pinctrl: sl261x: incorrect multiplexer register base offset for SM=
_GPIO20
- [High] pinctrl: sl261x: incorrect configuration register offset for GPIO54
- [Low] pinctrl: sl261x: mismatched comments for uart1 pin functions
--

commit fd69572f1bec3df913befb121d2d8d563a04f10c
Author: Jisheng Zhang <jszhang@kernel.org>

pinctrl: berlin: support Synaptics SL261X SoCs

This commit adds a new pinctrl driver for the Synaptics SL261X SoCs. It
defines the pin configuration groups, register offsets, and multiplexer
functions for both the main SoC and the system manager pin controller block=
s.

> diff --git a/drivers/pinctrl/berlin/pinctrl-sl261x.c b/drivers/pinctrl/be=
rlin/pinctrl-sl261x.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pinctrl/berlin/pinctrl-sl261x.c

[ ... ]

> +	BERLIN_PINCTRLCONF_GROUP("GPIO53", 0x800c, 0x3, 0x00,
> +			0x8878, 10,
> +			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* GPIO53 */
> +			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii2"), /* RD1 */
> +			BERLIN_PINCTRL_FUNCTION(0x6, "spi4"), /* SS3n */
> +			BERLIN_PINCTRL_FUNCTION(0x7, "spi3")), /* SCLK */
> +	BERLIN_PINCTRLCONF_GROUP("GPIO54", 0x800c, 0x3, 0x03,
> +			0x87c, 10,

[Severity: High]
Is the configuration register offset for GPIO54 correct here?=20

The surrounding GPIO configurations in sl261x_soc_pinctrl_groups use a 0x88=
00
base (for example, GPIO53 uses 0x8878 and GPIO55 uses 0x8880). Does this co=
de
incorrectly hardcode 0x87c instead of 0x887c, potentially causing writes to
the wrong hardware address when configuring pins?

[ ... ]

> +	BERLIN_PINCTRLCONF_GROUP("SM_GPIO21", 0xb08, 0x3, 0x0c,
> +			0xc68, 10,
> +			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* SM GPIO21 */
> +			BERLIN_PINCTRL_FUNCTION(0x1, "xspi")), /* SM XSPI DATA2 */
> +	BERLIN_PINCTRLCONF_GROUP("SM_GPIO20", 0x8, 0x3, 0x0f,
> +			0xc6c, 10,

[Severity: High]
Does this code use the wrong multiplexer register base offset for SM_GPIO20?

Surrounding SM_GPIO groups in sl261x_sysmgr_pinctrl_groups (like SM_GPIO21 =
and
SM_GPIO19) correctly use 0xb08. Using 0x8 here could cause the driver to
write to the wrong hardware address when applying pinmux states.

[ ... ]

> +	BERLIN_PINCTRLCONF_GROUP("SM_GPIO8", 0xb0c, 0x3, 0x0c,
> +			0xc90, 10,
> +			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* SM GPIO8 */
> +			BERLIN_PINCTRL_FUNCTION(0x1, "uart0"), /* SM UART0 TXD */
> +			BERLIN_PINCTRL_FUNCTION(0x2, "can0"), /* SM CAN0 TX */
> +			BERLIN_PINCTRL_FUNCTION(0x3, "sm_clkout"),
> +			BERLIN_PINCTRL_FUNCTION(0x6, "uart1")), /* SM UART0 TXD */

[Severity: Low]
This isn't a bug, but the trailing comment for uart1 incorrectly documents
the pin functionality as SM UART0 TXD. Should this be SM UART1 TXD?

> +	BERLIN_PINCTRLCONF_GROUP("SM_GPIO7", 0xb0c, 0x3, 0x0f,
> +			0xc94, 10,
> +			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"), /* SM GPIO7 */
> +			BERLIN_PINCTRL_FUNCTION(0x1, "uart0"), /* SM UART0 RXD */
> +			BERLIN_PINCTRL_FUNCTION(0x2, "can0"), /* SM CAN0 RX */
> +			BERLIN_PINCTRL_FUNCTION(0x3, "key_row6"),
> +			BERLIN_PINCTRL_FUNCTION(0x4, "gpio_trig"), /* TRIG2 */
> +			BERLIN_PINCTRL_FUNCTION(0x5, "pwm"), /* SM PWM9 */
> +			BERLIN_PINCTRL_FUNCTION(0x6, "uart1")), /* SM UART0 RXD */

[Severity: Low]
This isn't a bug, but there appears to be a similar copy-paste error here.
Should this trailing comment be labeled as SM UART1 RXD?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D14
