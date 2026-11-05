Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889791;
	b=TcLhbWSwjdTODU2r4/q+GOyp2TXgEd4KSJ7E8AzXWvp5gRlbBpKvYbEqVhhRfwH1wnVj
	 ITLJd2kcXtAo+tiqubojV6mIXL+HiJruvAhj9lIck9vLiJTx/I521dXT7+2tpT0sRmsgh
	 /poVXpaVipTqBxz0xywp+LQvgqheaEk05qBDricfkHKKZBK0tjjk21qWqD1pg+tmLh/ej
	 hKfagtxhDq+/KjIlxwb/uHWDtz4QEFyysI4iss4nblpL22IYHdLEkdh8IUHnnWKL/m3+S
	 MiGCZSDCjDRE8hM7uZMnVmsVgPnPmwAqXxCxSYasd0hMidMBc/BrYq/ZfV0nB+/Fq6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=43u83yv3y/AcUm7j7VuycPlBvarwqlz0nqyYMrh0YN0=;
	b=YoOzA8KfzcGtbqclIsPfupsNeLIv44v43A/okG/QT5BLeOJikUY3bYrJxGw/ywO7JSyD
	 JwzPSTUFpqjmJqfN3oEGImMmkYpMZMhSZ4Wyf30lBXDuGQ4AkwBZEVuabzUxfqDs7cwMS
	 AeqARUf6XXWCW96Td3JN6VPBnzKaH+Ft2DQnsGhoJmdJyMWtDSG9CE0vkR6AgfKaMGngZ
	 mlXfrhGm+TqqqmFzE5nRXvSNh7m9Wj+OI8PTKaPlK8eYTVlaIVRCFjcyubHQ3sZ9no1wD
	 jUqTPQ8xSmrOSLFw8vuUrzIQofAzht6ww4+PW5lB80ot7ZRhlqfBBR8G5YdPXpe/GHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRytBMn7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8B606A31B;
	Thu,  5 Nov 2026 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRytBMn7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050811F00919;
	Thu,  5 Nov 2026 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889791;
	bh=43u83yv3y/AcUm7j7VuycPlBvarwqlz0nqyYMrh0YN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KRytBMn7WE4zqViJdmdoQXyyFqxbev9jSjI1U08L/4sYzKNsz5xBJKuycHlXHHPSO
	 gI51Qe7j7iRRjrBrkCQWArCf//9afnl7kWaIMMfzuy2gVEa+93eLI25aOvm7LJDYKe
	 qe8AwTJIazJr+r5iCVmXkGeUuCbOTLbtjnwrXLJu78RcGbJhjLMKJ2KwNhZR34fzCM
	 Ac2wdZDZDoZ0WysCcTAwhzXTNZg8iU+Og/cVvYpGPx5DRraSMs7LVyjIQun/WkpfpB
	 ///R7urHQg0J67GCaxPNYjTndXTQuUxmSu+KkStGXhyJCUnQaUzJRiaRP+dhEZo5tw
	 m+o1Eb6CYQkfQ==
Message-ID: <sashiko-outbox-199259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] arm64: dts: mediatek: Add basic support for
 MT8163 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-5-e68d7d428f99@protonmail.ch>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
 <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-5-e68d7d428f99@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:43:10 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] arm64: dts: mediatek: undocumented and unmatched mt8163-wdt comp=
atible
- [Medium] arm64: dts: mediatek: mt8163: wrong IRQ trigger type on watchdog=
 node
--

commit 67e669b8d381b252cd1f347ad5f9a9a92a7b5322
Author: Ben Grisdale <bengris32@protonmail.ch>

arm64: dts: mediatek: Add basic support for MT8163 SoC

This commit adds the base device tree include file for the MediaTek MT8163
SoC, defining the CPUs, caches, PSCI, interrupt controllers, timers, PMU,
watchdog, and UART nodes.

> diff --git a/arch/arm64/boot/dts/mediatek/mt8163.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8163.dtsi
> new file mode 100644
> index 0000000000000..645f4e15587bf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8163.dtsi
> @@ -0,0 +1,243 @@

[ ... ]

> +	soc {
> +		compatible =3D "simple-bus";
> +		ranges;
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +
> +		watchdog: watchdog@10007000 {
> +			compatible =3D "mediatek,mt8163-wdt";

[Severity: Medium]
Does the watchdog@10007000 node fail to bind and fail dtbs_check with only
"mediatek,mt8163-wdt" in its compatible property?

Unlike the timer, sysirq, and uart nodes, "mediatek,mt8163-wdt" is not
documented in Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.y=
aml
and is not present in mtk_wdt_dt_ids[] in drivers/watchdog/mtk_wdt.c:

static const struct of_device_id mtk_wdt_dt_ids[] =3D {
	{ .compatible =3D "mediatek,mt2712-wdt", .data =3D &mt2712_data },
	{ .compatible =3D "mediatek,mt6589-wdt", .data =3D &mt6589_data },
	...
	{ .compatible =3D "mediatek,mt8195-wdt", .data =3D &mt8195_data },
	{ /* sentinel */ }
};

Without a fallback compatible such as "mediatek,mt6589-wdt" (and a
corresponding binding entry) or a driver match entry, mtk_wdt_probe() will
not match this node, leaving the hardware watchdog, system restart handler,
and TOPRGU reset controller unavailable. Should this include a fallback
compatible and binding update?

> +			reg =3D <0 0x10007000 0 0x1000>;
> +			interrupts =3D <GIC_SPI 128 IRQ_TYPE_EDGE_FALLING>;

[Severity: Medium]
Should the interrupt trigger type on watchdog@10007000 be IRQ_TYPE_LEVEL_LOW
instead of IRQ_TYPE_EDGE_FALLING?

Because the parent interrupt controller is sysirq, mtk_sysirq_set_type() in
drivers/irqchip/irq-mtk-sysirq.c inverts the polarity and forwards
IRQ_TYPE_EDGE_FALLING to the GIC as IRQ_TYPE_EDGE_RISING:

	if (type =3D=3D IRQ_TYPE_LEVEL_LOW || type =3D=3D IRQ_TYPE_EDGE_FALLING) {
		if (type =3D=3D IRQ_TYPE_LEVEL_LOW)
			type =3D IRQ_TYPE_LEVEL_HIGH;
		else
			type =3D IRQ_TYPE_EDGE_RISING;
		value |=3D (1 << offset);
	}

However, the MediaTek TOPRGU watchdog bark interrupt is level-triggered (as
described in commit 311f6c4bba24 ("watchdog: mediatek: acknowledge pretimeo=
ut
interrupt") and Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt=
.yaml),
and mtk_wdt_deassert_irq() in drivers/watchdog/mtk_wdt.c acknowledges the
pretimeout interrupt by toggling WDT_MODE_IRQ_LEVEL_EN twice across a delay:

	reg =3D ioread32(wdt_base + WDT_MODE);
	reg ^=3D WDT_MODE_IRQ_LEVEL_EN;
	iowrite32(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);

	udelay(WDT_IRQ_LEVEL_SYNC_US);

	reg =3D ioread32(wdt_base + WDT_MODE);
	reg ^=3D WDT_MODE_IRQ_LEVEL_EN;
	iowrite32(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);

With edge triggering configured, wouldn't toggling WDT_MODE_IRQ_LEVEL_EN in
mtk_wdt_deassert_irq() cause spurious re-triggering or missed pretimeout
interrupts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-arm64-init=
ial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch?part=3D5
